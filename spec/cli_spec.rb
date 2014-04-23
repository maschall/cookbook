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
    
    context 'prints out help' do
      before(:each) do
        @cli = create_cli('-h')
      end
  
      it 'prints out invalid option' do
        @cli.should_receive(:puts)
  
        @cli.run
      end
  
      it 'exits' do
        @cli.should_receive(:exit)
  
        @cli.run
      end
    end
    
    context 'invalid option' do
      before(:each) do
        @cli = create_cli('-x')
      end
  
      it 'prints out invalid option and help' do
        @cli.should_receive(:puts).twice
  
        @cli.run
      end
  
      it 'exits' do
        @cli.should_receive(:exit)
  
        @cli.run
      end
    end
  end
  
  def create_cli(*args)
    cli = Cookbook::CLI.new(args)
    cli.stub(:puts)
    cli.stub(:exit)
    cli
  end
end