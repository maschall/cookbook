module Cookbook
  class Config
  
    def self.base_directory
      ENV['HOME'] + '/.cookbook'
    end
    
    def self.config_file_path
      File.expand_path('../../../defaults/config', __FILE__)
    end
    
    attr_accessor :cookbook_urls
    
    def initialize(path = Config.config_file_path)
      self.cookbook_urls = configuration_from_file(path)['cookbooks']
    end
    
    private
    
    def configuration_from_file(path)
      YAML.load_file(path)
    end
    
  end
end