require 'spec_helper'

describe Cookbook::Config do
  it 'will load from the config file' do
    config = Cookbook::Config.new()
    config.library_url.should eq('https://github.com/maschall/cookbook-library.git')
  end
  
end