require 'spec_helper'

describe Cookbook::Library do
  describe '#cookbooks' do
    before(:each) do
      @library = create_library('test')
    end
    
    it 'will update catalog' do
      @library.stub(:update_library)
      
      @library.should_receive(:update_library)
      
      @library.cookbooks
    end
    
    it 'will create a git directory' do
      Dir.stub(:exists?).and_return(false)
      
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:clone).and_return(git)
      Git.should_receive(:clone)
      
      @library.cookbooks
    end
    
    it 'will load the git directory' do
      Dir.stub(:exists?).and_return(true)
      
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:open).and_return(git)
      Git.should_receive(:open)
      
      @library.cookbooks
    end
    
    it 'will pull the latest' do
      Dir.stub(:exists?).and_return(true)
      git = double(Git::Base)
      git.stub(:pull)
      Git.stub(:open).and_return(git)
      
      git.should_receive(:pull)
      
      @library.cookbooks
    end
    
    it 'will read the catalog' do
      @library.stub(:update_library)
      
      Cookbook::Catalog.should_receive(:new)
      
      @library.cookbooks
    end
  end
  
  def create_library(url)
    Cookbook::Catalog.stub(:new)
    Cookbook::Library.new(url)
  end
end