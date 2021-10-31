require 'rom'
require 'rom/memory'

class Beers < ROM::Relation[:memory]
  schema(:beers) do
    attribute :id, Types::Integer
    attribute :name, Types::String
    attribute :type, Types::String
    attribute :abv, Types::Integer
    attribute :ibu, Types::Integer
    attribute :global_weighted_rating_score, Types::Integer
    attribute :global_rating_score, Types::Integer

    attribute :brewery, Types::ForeignKey(:breweries)

    primary_key :id

    associations do
      has_many :checkins, combine_key: :beer
    end
  end

  def has(id)
    restrict(id: id).first
  end

  def unique_beers
    beers.to_a.size
  end

  def unique_styles
    styles.keys.uniq
  end

  def styles
    beers.map {|b| b[:type] }.tally
  end

  def by_name(name)
    restrict(beer_name: name)
  end

  def for_breweries(_assoc, breweries)
    restrict(brewery: breweries.map { |u| u[:id] })
  end
end

class Breweries < ROM::Relation[:memory]
  schema(:breweries) do
    attribute :id, Types::Integer
    attribute :name, Types::String
    attribute :city, Types::String
    attribute :state, Types::String
    attribute :country, Types::String

    primary_key :id

    associations do
      has_many :beers, combine_key: :brewery
    end
  end

  def has(id)
    restrict(id: id).first
  end
end

class Venues < ROM::Relation[:memory]
  schema(:venues) do
    attribute :name, Types::String
    attribute :city, Types::String
    attribute :state, Types::String
    attribute :country, Types::String
    attribute :lat, Types::Integer
    attribute :lng, Types::Integer

    primary_key :name

    associations do
      has_many :checkins, combine_key: :venue
    end
  end

  def has(name)
    restrict(name: name).first
  end
end

class Checkins < ROM::Relation[:memory]
  schema(:checkins) do
    attribute :id, Types::Integer
    attribute :rating_score, Types::Integer
    attribute :comment, Types::String
    attribute :created_at, Types::Date
    attribute :flavor_profiles, Types::String
    attribute :serving_type, Types::String
    attribute :tagged_friends, Types::String
    attribute :total_toasts, Types::Integer
    attribute :total_comments, Types::Integer
    attribute :photo_url, Types::String
    attribute :purchase_venue, Types::String

    primary_key :id

    attribute :beer, Types::ForeignKey(:beers)
    attribute :venue, Types::ForeignKey(:venues)
  end
end
