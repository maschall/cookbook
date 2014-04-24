require 'spec_helper'

describe Cookbook::Cookbook do
  it 'will load from the cookbook file' do
    test_cookbook = 
    '
      recipes:
        ios:
          name: iOS Template
          url: git@github.com:maschall/cookbook-ios.git
          description: A cookbook template for iOS
        android:
          name: Android Template
          url: git@github.com:maschall/cookbook-android.git
          description: A cookbook template for Android
        ruby:
          name: Ruby Template
          url: git@github.com:maschall/cookbook-ruby.git
          description: A cookbook template for Ruby
    '
    
    YAML.stub(:load_file).and_return( YAML.load(test_cookbook) )
    YAML.should_receive(:load_file).with('somewhere/test/path')
    
    Cookbook::Recipe.stub(:new)
    Cookbook::Recipe.should_receive(:new).exactly(3).times
    
    cookbook = Cookbook::Cookbook.new('somewhere/test/path')
    
    cookbook.recipes.length.should eq(3)
  end
  
end