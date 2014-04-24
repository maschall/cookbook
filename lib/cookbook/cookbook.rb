module Cookbook
  class Cookbook
    
    attr_accessor :recipes
    
    def initialize(path)
      self.recipes = cookbook_from_file(path)['recipes'].map { |id, recipe| [id, Recipe.new(recipe)] }
    end
    
    private
    
    def cookbook_from_file(path)
      cookbook = YAML.load_file(path)
    end
    
  end
end