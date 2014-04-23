require 'spec_helper'

describe Cookbook::Card do
  it 'will load from the catalog file' do
    test_card = 
    '
    name: iOS Template
    url: git@github.com:maschall/cookbook-ios.git
    description: A cookbook template for iOS
    '
    
    card = Cookbook::Card.new(YAML.load(test_card))
    
    card.name.should eq('iOS Template')
    card.url.should eq('git@github.com:maschall/cookbook-ios.git')
    card.description.should eq('A cookbook template for iOS')
  end
  
end