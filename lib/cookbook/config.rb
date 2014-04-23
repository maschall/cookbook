module Cookbook
  class Config
  
    def self.base_directory
      ENV['HOME'] + '/.cookbook'
    end
    
    def self.config_file_path
      File.expand_path('../../../defaults/config', __FILE__)
    end
    
    attr_accessor :library_url
    
    def initialize(path = Config.config_file_path)
      configuration_from_file(path).each_pair do |attribute, value|
        set_method = "#{attribute}="
        puts set_method
        if respond_to?(set_method)
          send(set_method, value)
        end
      end
    end
    
    private
    
    def configuration_from_file(path)
      if File.exists? path
        configuration = YAML.load_file(path)
      else
        {}
      end
    end
    
  end
end