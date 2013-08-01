require 'yaml/store'
require 'open-uri'
require 'nokogiri'

# FILE = "http://www.cafeconleche.org/examples/shakespeare/j_caesar.xml"
# JULIUS_CAESAR_XML = Nokogiri::HTML(open(FILE))

class Play

  attr_reader :file, :xml

   def initialize(url)
     @file = url
     @xml = Nokogiri::HTML(open(@file))
   end


  def save
    database.transaction do |db|
      db['play'] ||= []
      db['play'] << play_data
    end
  end

  def play_data
    {
      title: find('play/title').text,
      personas: find('persona').map { |persona| extract_data_from(persona.content) }
    }
  end

  def extract_data_from(content)
    {
      name: content,
      lines_spoken: lines_spoken(content),
      longest_speech: longest_speech_by(content),
      scene_appearances: scene_appearances(content),
      percent_total_scenes: percent_total_scenes(content)
    }
  end

  def find(node)
    xml.xpath("//#{node}")
  end

  def speeches
    @speeches ||= find('speech')
  end

  def scenes
    @scenes ||= find('scene')
  end

  def lines_spoken(name)
    speeches_by(name).map { |speech| lines_in(speech).count }.inject(0, :+)
  end

  def speeches_by(persona)
    speeches.select do |speech|
      speaker_of(speech) == persona
    end
  end

  def speaker_of(speech)
    speech.children[0].text
  end

  def lines_in(speech)
    speech.children[1..-1]
  end

  def longest_speech_by(name)
    speech_lengths = [0]
    speeches.each do |speech|
      if speaker_of(speech) == name
        speech_lengths << lines_in(speech).children.map { |a| a.content.length }.inject(0, :+)
      end
    end
    speech_lengths.max
  end

  def scene_appearances(name)
    scene_appearance_count = 0
    scenes.each do |scene|
      if scene.children[2..-1].children[1..-1].text.include?(name)
        scene_appearance_count += 1
      end
    end
    scene_appearance_count
  end

  def percent_total_scenes(name)
    total_scenes = scenes.count
    percent_of_total = (scene_appearances(name).to_f / total_scenes) * 100
    percent_of_total.round
  end

  def self.all
    database.transaction { database['play'] || [] }.map do |data|
      new(data[:title])
    end
  end

  def self.database
    @database ||= YAML::Store.new "play"
  end

  def database
    Play.database
  end

end
