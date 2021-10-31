require 'rom'
require 'rom/memory'

require_relative './relations'

class UntappdRom
  attr_reader :breweries, :beers, :venues, :checkins

  def initialize(untappd)
    @untappd = untappd
    rom = ROM.container(:memory) do |config|
      config.register_relation(Breweries, Beers, Checkins, Venues)
    end

    @breweries = rom.relations[:breweries]
    @beers = rom.relations[:beers]
    @venues = rom.relations[:venues]
    @checkins = rom.relations[:checkins]

    @untappd.each do |checkin |
      checkin_id = checkin['checkin_id']
      brewery_id = checkin['brewer_id']
      beer_id = checkin['bid']
      venue_name = checkin['venue_name']

      unless breweries.has(brewery_id)
        brewery = @breweries.insert(
          {
            id: brewery_id,
            city: checkin['brewery_city'],
            state: checkin['brewery_state'],
            country: checkin['brewery_country']
          })
      end

      unless beers.has(beer_id)
        beer = @beers.insert(
          {
            id: beer_id,
            name: checkin['beer_name'],
            type: checkin['beer_type'],
            abv: checkin['beer_abv'],
            ibu:  checkin['beer_ibu'],
            global_weighted_rating_score: checkin['global_weighted_rating_score'],
            global_rating_score: checkin['global_rating_score'],
            brewery: brewery_id
          })
      end

      @checkins.insert(
        {
          id: checkin_id,
          rating_score: checkin['rating_score'],
          comment: checkin['comment'],
          created_at: checkin['created_at'],
          flavor_profiles: checkin['flavor_profiles'],
          serving_type: checkin['serving_type'],
          tagged_friends: checkin['tagged_friends'],
          total_toasts: checkin['total_toasts'],
          total_comments: checkin['total_comments'],
          photo_url: checkin['photo_url'],
          purchase_venue: checkin['purchase_venue'],
          beer: beer,
          venue: venue_name
        })

      unless venues.has(venue_name)
        @venues.insert(
          {
            name: venue_name,
            city: checkin['venue_'],
            state: checkin['venue_'],
            country: checkin['venue_'],
            lat: checkin['venue_'],
            lng: checkin['venue_'],
            checkins: checkin_id
          })
      end
    end
  end
end
