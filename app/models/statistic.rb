class Statistic
  include HTTParty
  base_uri 'https://us.api.battle.net'

  def initialize()
  end

  def dungeon_stats(character, realm, options={})
    MetaNexus.config do |c|
      c.region = 'us'
      c.locale = 'en_US'
      c.api_key = 'foo'
    end
    MetaNexus::Wow::Character.find(realm: realm, name: character)
  end

  def post(text)
    options = { :query => {:status => text}, :basic_auth => @auth }
    self.class.post('/statuses/update.json', options)
  end

  private

  def aggregate_opportunities
    {
    }
  end
end

# usage examples.
#twitter.post("It's an HTTParty and everyone is invited!")

# Make a god-damn map for that final statistics array? 110 entries daaang.
#character['statistics']['subCategories'][5]['subCategories'][6]['statistics']