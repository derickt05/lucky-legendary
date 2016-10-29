class Character
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # Restricts what attributes we actually want to set instance variables from the API response.
  CHARACTER_ATTRIBUTES = [:name, :realm, :thumbnail]

  attr_reader *CHARACTER_ATTRIBUTES

  # TODO: Prob have to do something w/ region? en_US by default.
  def initialize(name, realm)
    character_lookup = RBattlenet::Wow::Character.find(name: name, realm: realm, fields: ['statistics']).parsed_response
    character_lookup.each { |k,v| instance_variable_set("@#{k}", v) if CHARACTER_ATTRIBUTES.include?(k.to_sym) }
  end

end

#character['statistics']['subCategories'][5]['subCategories'][6]['statistics']