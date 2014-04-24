module Cookbook
  class Cookbook
    
    def initialize(url)
      @url = url
    end
    
    def update
      if Dir.exists? cookbook_dir
        g = Git.open(cookbook_dir)
      else
        g = Git.clone(@url, cookbook_dir)
      end
      g.pull
    end
    
    def recipes
      @recipes ||= cookbook_from_file(cookbook_catalog)['recipes'].map { |id, recipe| [id, Recipe.new(recipe)] }
    end
    
    private
    
    def cookbook_from_file(path)
      YAML.load_file(path)
    end
    
    def cookbook_path
      Library.library_dir + cookbook_dir
    end
    
    def cookbook_dir
      @cookbook_dir ||= URI(@url).path
    end
    
    def cookbook_catalog
      cookbook_path + '/catalog'
    end
    
  end
end