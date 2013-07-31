require 'yaml/store'
require 'open-uri'
require 'nokogiri'

JULIUS_CAESAR_XML = Nokogiri::HTML(open("http://www.cafeconleche.org/examples/shakespeare/j_caesar.xml"))

class Play

  def save
    database.transaction do |db|
      db['play'] ||= []
      db['play'] << {
                      title: JULIUS_CAESAR_XML.xpath("//play/title").text,
                      personas: JULIUS_CAESAR_XML.xpath("//persona").map { |a| { name: a.content,
                                                                                 lines_spoken: lines_spoken(a.content),
                                                                                 longest_speech: longest_speech(a.content),
                                                                                 scene_appearances: scene_appearances(a.content),
                                                                                 percent_total_scenes: percent_total_scenes(a.content)}
                                                                          }
                    }
    end
  end

  def lines_spoken(name)
    speeches = JULIUS_CAESAR_XML.xpath('//speech')
    line_count = 0
    speeches.each do |speech|
      if speech.children[0].text == name
        line_count += speech.children[1..-1].count
      end
    end
    line_count
  end

  def longest_speech(name)
    speeches = JULIUS_CAESAR_XML.xpath('//speech')
    speech_lengths = []
    speeches.each do |speech|
      if speech.children[0].text == name
        speech_lengths << speech.children[1..-1].children.map { |a| a.content.length }.inject(&:+)
      end
    end
    return 0 if speech_lengths.max == nil
  end

  def scene_appearances(name)
    scenes = JULIUS_CAESAR_XML.xpath('//scene')
    scene_appearance_count = 0
    scenes.each do |scene|
      if scene.children[2..-1].children[1..-1].text.include?(name)
        scene_appearance_count += 1
      end
    end
    scene_appearance_count
  end

  def percent_total_scenes(name)
    total_scenes = JULIUS_CAESAR_XML.xpath('//scene').count
    percent_of_total = (scene_appearances(name).to_f / total_scenes) * 100
    percent_of_total.round
  end

  def database
    @database ||= YAML::Store.new "play"
  end

end
