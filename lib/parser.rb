require_relative './rom'

class Untappd
  def initialize(filename)
    @rom = UntappdRom.new(load_file(filename))
  end

  def load_file(filename)
    JSON.parse(File.read(filename))
  end

  def find_start_date
    #@start_date = Date.parse(@untappd[0]['created_at']).to_date
  end

  def missing_styles
    all_styles = load_file('_data/all_styles.json')
    tasted_styles = @rom.beers.unique_styles
    missing_styles = all_styles - tasted_styles
    missing_styles.sort
  end

  def styles
    p @rom.checkins.to_a.size
    p @rom.checkins.first.size
  end

  def export(filename, data)
    file = File.open("_data/#{filename}.json", "w")
    file.puts(data.to_json)
  end

  def generate_and_export
    #export('missing_styles', missing_styles)
    print @rom.beers.styles.to_json
    #export('styles', @rom.beers.styles) # TODO: Should be checkings per style
    #export('styles', styles)
  end
end

untappd = Untappd.new(ARGV[0] || 'untappd.json')
untappd.generate_and_export
