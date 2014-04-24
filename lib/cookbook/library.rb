module Cookbook
  class Library
    
    def self.library_dir
      Config.base_directory + '/library'
    end
    
    attr_accessor :cookbooks
    
    def initialize()
      @config = Config.new()
    end
    
    def cookbooks
      @config.cookbook_urls.map { |url| Cookbook.new(url) }
    end
    
    #def add_cookbook(url)
      #@config.cookbook_urls.push(url)
      #@config.save()
    #end
    
    def update_library
      cookbooks.each { |book| book.update }
    end
    
    private
    
  end
end