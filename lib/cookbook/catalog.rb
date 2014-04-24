module Cookbook
  class Catalog
    
    attr_accessor :recipes
    
    def initialize(path)
      self.recipes = catalog_from_file(path)['recipes'].map { |id, recipe| [id, Recipe.new(recipe)] }
    end
    
    private
    
    def catalog_from_file(path)
      catalog = YAML.load_file(path)
    end
    
  end
end