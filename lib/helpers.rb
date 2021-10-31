require 'countries'
require 'date'

module Helpers
  def find_code(name)
    c = ISO3166::Country.new(name)&.data
    c ||= ISO3166::Country.find_country_by_name(name)&.data
    c ||= ISO3166::Country.find_all_by('translated_names', name).values.first
    c ||= ISO3166::Country.find_all_by('unofficial_names', name).values.first
    c&.fetch('alpha3', nil)
  end

  def convert_countries(countries)
    datamapper = {}
    countries.each do |country, values|
      c = ISO3166::Country.find_country_by_name(country)
      unless c
        case country
        when "CHINA / PEOPLE'S REPUBLIC OF CHINA"
          c = ISO3166::Country.find_country_by_name('china')
        when 'PALESTINIAN TERRITORIES'
          c = ISO3166::Country.find_country_by_name('palestina')
        when 'PRINCIPALITY OF MONACO'
          c = ISO3166::Country.find_country_by_name('monaco')
        when "WALES", "ENGLAND", "SCOTLAND"
          c = ISO3166::Country.find_country_by_name('united kingdom')
        end
      end

      datamapper[c.alpha3] = {
        'fillKey' => 'brewery',
        'breweries' => values['breweries'].size,
        'checkins' => values['count']
      }
    end

    datamapper
  end

  def days_in_month(year, month)
    Date.new(year.to_i, month.to_i, -1).day
  end

  def days_drinking(start_date)
    year = start_date.year
    if year == Date.today.year
      end_date = Date.today
    else
      end_date = Date.new(year, 12, 31)
    end

    (end_date - start_date.to_date).to_i + 1
  end

  def get_date_info(check_in)
    checked_in = DateTime.parse(check_in['created_at'])
    return checked_in.year.to_s. checked_in.month.to_s, checked_in.day.to_s
  end
end
