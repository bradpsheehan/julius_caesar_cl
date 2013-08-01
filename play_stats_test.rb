require 'minitest/autorun'
require 'minitest/pride'
require_relative 'play_stats'

class PlayStatsTest < MiniTest::Unit::TestCase

  def setup
    @play = Play.new
  end

  def teardown
    if File.exist?('./play')
      File.delete('./play')
    end
  end

  def test_save
    @play.save
    refute @play.database.transaction { @play.database['play'] }.empty?
  end

  def test_lines_spoken
    @play.save
    test_play = Play.new
    lines_spoken = test_play.lines_spoken("CICERO")
    assert_equal @play.database.transaction { @play.database['play'][0][:personas][4][:lines_spoken] }, lines_spoken
  end

  def test_longest_speech
    skip
  end

  def test_scene_appearances
    skip
  end

  def test_percent_total
    skip
  end

end
