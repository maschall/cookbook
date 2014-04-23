module Cookbook
  class Catalog
    
    attr_accessor :cards
    
    def initialize(path)
      self.cards = catalog_from_file(path)['cards'].map { |cardid, card| [cardid, Card.new(card)] }
    end
    
    private
    
    def catalog_from_file(path)
      catalog = YAML.load_file(path)
    end
    
  end
end