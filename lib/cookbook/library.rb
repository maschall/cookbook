module Cookbook
  class Library
    
    attr_accessor :cookbooks
    
    def initialize(url)
      @url = url
    end
    
    def cookbook
      update_library
      
      read_cookbook
    end
    
    private
    
    def update_library
      if Dir.exists? library_dir
        g = Git.open(library_dir)
      else
        g = Git.clone( @url, library_dir )
      end
      g.pull
    end
    
    def read_cookbook
      Cookbook.new(cookbook_path)
    end
    
    def library_dir
      Config.base_directory + '/library'
    end
    
    def cookbook_path
      library_dir + '/cookbook'
    end
    
  end
end