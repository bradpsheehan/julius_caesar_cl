require './play'
require 'rspec'
require 'rack/test'

describe Play do
  include Rack::Test::Methods

  before do
    File.delete('./play.yaml') if File.exist?('./play.yaml')
  end

  subject { Play.new("http://www.cafeconleche.org/examples/shakespeare/j_caesar.xml") }

  it 'requires a url' do
    expect { Play.new }.to raise_error ArgumentError
  end

  describe '#save' do
    it 'writes to a yaml file for local storage' do
      expect { subject.save }.to change { Play.database.transaction { Play.database['play'] }.nil? }.to false
    end
  end

end
