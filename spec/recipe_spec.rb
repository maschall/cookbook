require 'spec_helper'

describe Cookbook::Recipe do
  it 'will load from the catalog file' do
    test_recipe = 
    '
    name: iOS Template
    url: git@github.com:maschall/cookbook-ios.git
    description: A cookbook template for iOS
    '
    
    recipe = Cookbook::Recipe.new(YAML.load(test_recipe))
    
    recipe.name.should eq('iOS Template')
    recipe.url.should eq('git@github.com:maschall/cookbook-ios.git')
    recipe.description.should eq('A cookbook template for iOS')
  end
  
end