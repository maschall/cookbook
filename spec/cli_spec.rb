require 'spec_helper'

describe Cookbook::CLI do
  describe '#run' do
    it 'print outs version' do
      cli = create_cli('-v')
      
      cli.should_receive(:puts).with("Version: #{Cookbook::VERSION}").once
      
      cli.run
    end
    
    it 'exits on version' do
      cli = create_cli('-v')
      
      cli.should_receive(:exit)
      
      cli.run
    end
  end
  
  def create_cli(*args)
    cli = Cookbook::CLI.new(args)
    cli.stub(:puts)
    cli.stub(:exit)
    cli
  end
end