class Character
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # Restricts what attributes we actually want to set instance variables from the API response.
  RAW_CHARACTER_ATTRIBUTES = [:name, :realm, :thumbnail]

  attr_reader *RAW_CHARACTER_ATTRIBUTES, :statistics

  # TODO: Just uses default region right now.
  def initialize(name, realm)
    character_lookup = RBattlenet::Wow::Character.find(name: name,realm: realm, fields: ['statistics']).parsed_response
    character_lookup.each { |k,v| instance_variable_set("@#{k}", v) if RAW_CHARACTER_ATTRIBUTES.include?(k.to_sym) }

    # Filters out entries below 0. Maybe can hack .scope instead with some ActiveModel hackery.
    @statistics = character_lookup['statistics']['subCategories'][5]['subCategories'][6]['statistics']
      .select {|stat| stat['quantity'] > 0}
  end

end
