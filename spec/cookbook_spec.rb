require 'spec_helper'

describe Cookbook::Cookbook do
  before(:each) do
    @cookbook = Cookbook::Cookbook.new('https://github.com/maschall/cookbook-cookbook.git')
  end
  
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
    
    Cookbook::Library.stub(:library_dir).and_return('path/to/library')
    
    YAML.should_receive(:load_file).with('path/to/library/maschall/cookbook-cookbook.git/catalog')
    
    Cookbook::Recipe.stub(:new)
    Cookbook::Recipe.should_receive(:new).exactly(3).times
    
    @cookbook.recipes.length.should eq(3)
  end
  
  describe '#update' do
    it 'will create a git directory' do
      Dir.stub(:exists?).and_return(false)
      
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:clone).and_return(git)
      Git.should_receive(:clone)
      
      @cookbook.update
    end
    
    it 'will load the git directory' do
      Dir.stub(:exists?).and_return(true)
      
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:open).and_return(git)
      Git.should_receive(:open)
      
      @cookbook.update
    end
    
    it 'will pull the latest' do
      Dir.stub(:exists?).and_return(true)
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:open).and_return(git)
      
      git.should_receive(:pull)
      
      @cookbook.update
    end
  end
end