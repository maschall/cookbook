module Cookbook
  class Card
  
    attr_accessor :url,
     :name,
     :description
  
    def initialize( card ) 
      card.each do |attribute, value|
        setter_method = "#{attribute}="
        if respond_to?(setter_method)
          send( setter_method, value )
        end
      end
    end
  
  end
end