module Cookbook
  class Library
    
    def initialize(url)
      @url = url
    end
    
    def cookbooks
      update_library
      
      @catalog = read_catalog
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
    
    def read_catalog
      Catalog.new(catalog_path)
    end
    
    def library_dir
      Config.base_directory + '/library'
    end
    
    def catalog_path
      library_dir + '/catalog'
    end
    
  end
end