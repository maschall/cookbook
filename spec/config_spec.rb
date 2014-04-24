require 'spec_helper'

describe Cookbook::Config do
  it 'will load from the config file' do
    config = Cookbook::Config.new()
    config.cookbook_urls.count.should eq(1)
    config.cookbook_urls[0].should eq('https://github.com/maschall/cookbook-cookbook.git')
  end
  
end