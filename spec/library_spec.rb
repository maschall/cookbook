require 'spec_helper'

describe Cookbook::Library do
  describe '#cookbooks' do
    before(:each) do
      @library = create_library('test')
    end
    
    it 'will update catalog' do
      @library.stub(:update_library)
      
      @library.should_receive(:update_library)
      
      @library.cookbook
    end
    
    it 'will create a git directory' do
      Dir.stub(:exists?).and_return(false)
      
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:clone).and_return(git)
      Git.should_receive(:clone)
      
      @library.cookbook
    end
    
    it 'will load the git directory' do
      Dir.stub(:exists?).and_return(true)
      
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:open).and_return(git)
      Git.should_receive(:open)
      
      @library.cookbook
    end
    
    it 'will pull the latest' do
      Dir.stub(:exists?).and_return(true)
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:open).and_return(git)
      
      git.should_receive(:pull)
      
      @library.cookbook
    end
    
    it 'will read the catalog' do
      @library.stub(:update_library)
      
      Cookbook::Cookbook.should_receive(:new)
      
      @library.cookbook
    end
  end
  
  def create_library(url)
    Cookbook::Cookbook.stub(:new)
    Cookbook::Library.new(url)
  end
end