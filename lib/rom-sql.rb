require 'rom'
require 'rom/memory'

#rom = ROM.container(:sql, 'sqlite::memory') do |config|
rom = ROM.container(:memory, 'memory://untappd') do |config|
  # define relations and commands here...
  config.default.create_table(:beers) do
    primary_key :id
    foreign_key :brewery, :breweries

    column :name, String
    column :type, String
    column :abv, Integer
    column :ibu, Integer
    column :url, String
    column :global_weighted_rating_score, Integer
    column :global_rating_score, Integer
  end

  config.default.create_table(:breweries) do
    primary_key :id

    column :name, String
    column :city, String
    column :state, String
    column :country, String
    column :url, String
  end

  config.default.create_table(:venues) do
    primary_key :name, String

    column :city, String
    column :state, String
    column :country, String
    column :lat, Integer
    column :lng, Integer
  end

  config.default.create_table(:checkins) do
    primary_key :id
    foreign_key :beer
    foreign_key :venue

    column :rating_score, Integer
    column :comment, String
    column :created_at, Date
    column :flavor_profiles, String
    column :serving_type, String
    column :tagged_friends, String
    column :total_toasts, Integer
    column :total_comments, Integer
    column :photo_url, String
    column :purchase_venue, String
  end

  config.relation(:breweries) do
    schema(infer: true) do
      associations do
        has_many :beers
      end
    end
  end

  config.relation(:beers) do
    schema(infer: true) do
      associations do
        belongs_to :breweries, as: :brewery
        has_many :checkins
      end
    end
  end

  config.relation(:checkins) do
    schema(infer: true) do
      associations do
        belongs_to :checkins
      end
    end
  end

  config.relation(:checkins) do
    schema(infer: true) do
      associations do
        has_one :beer
        has_one :checkin
      end
    end
  end
end

class BreweryRepo < ROM::Repository[:breweries]
  commands :create

  def has(id)
    breweries.where(id: id)
  end
end

class BeerRepo < ROM::Repository[:beers]
  commands :create

  def has(id)
    beers.where(id: id).first
  end

  def count
    beers.to_a.size
  end
end

brewery_repo = BreweryRepo.new(rom)
beer_repo = BeerRepo.new(rom)

untappd_json = JSON.parse(File.read('../untappd.json'))
untappd_json.each do |check_in |
  brewery_id = check_in['brewer_id']
  brewery = brewery_repo.has(brewery_id)
  unless brewery
    brewery = brewery_repo.create(id: brewery_id,
                        city: check_in['brewery_city'],
                        state: check_in['brewery_state'],
                        country: check_in['brewery_country'])
  end
  
  bid = check_in['bid']
  unless beer_repo.has(bid)
    beer_repo.create(id: bid,
                     name: check_in['beer_name'],
                     type: check_in['beer_type'],
                     abv: check_in['beer_abv'],
                     ibu:  check_in['beer_ibu'],
                     brewery: brewery_id)
  end
end

p beer_repo.count
