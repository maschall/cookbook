require 'spec_helper'

describe Cookbook::Library do
  before(:each) do
    @library = create_library()
    mock_config = double(Cookbook::Config)
    mock_config.stub(:cookbook_urls).and_return(['1', '2'])
    @library.instance_variable_set("@config", mock_config)
  end
  
  describe '#cookbooks' do
    it 'returns an array' do
      @library.cookbooks.count.should eq(2)
    end
    
    it 'returns an array of cookbooks' do
      Cookbook::Cookbook.should_receive(:new).exactly(2).times
      
      @library.cookbooks
    end
  end
  
  describe '#update_library' do
    it 'will tell each cookbook to update' do
      cookbook1 = create_cookbook_expecting_update
      cookbook2 = create_cookbook_expecting_update
      
      @library.stub(:cookbooks).and_return([cookbook1, cookbook2])
      
      @library.update_library
    end
  end
  
  def create_library()
    Cookbook::Cookbook.stub(:new)
    Cookbook::Library.new()
  end
  
  def create_cookbook_expecting_update()
    cookbook = double(Cookbook::Cookbook)
    cookbook.stub(:update)
    cookbook.should_receive(:update)
    cookbook
  end
end