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
      if Dir.exists? catalog_dir
        g = Git.open(catalog_dir)
      else
        g = Git.clone( @url, catalog_dir )
      end
      g.pull
    end
    
    def read_catalog
      Catalog.new(catalog_path)
    end
    
    def catalog_dir
      Config.base_directory + '/library'
    end
    
    def catalog_path
      catalog_dir + '/catalog'
    end
    
  end
end