# Beers

Personal Untappd stats dashboard built with Jekyll and hosted on GitHub Pages. Generates richer statistics than Untappd itself — breakdowns by year, month, day of week, ABV, style, brewery, country, and more.

## How it works

1. A daily GitHub Actions workflow downloads the latest [`unparsd`](https://github.com/kyrremann/unparsd) binary and runs `unparsd fetch`, which pulls new check-ins from the Untappd API and appends them to `checkins/YYYY.json`.
2. `unparsd generate` reads the `checkins/` folder and produces all aggregated `_data/*.json` files and the `_monthly/*.html` stubs.
3. The updated `checkins/` files are committed and pushed back to the repo.
4. GitHub Pages detects the push and rebuilds the Jekyll site automatically.

The `_data/` files and `_monthly/` stubs are generated — do not edit them by hand, they will be overwritten on the next CI run.

## Features

- Total check-ins, unique beers, breweries, and countries
- Beers per year and month, with daily averages
- ABV distribution chart
- Beers by day of week
- Longest drinking streak
- Interactive world map (UK split into England, Scotland, Wales, Northern Ireland)
- Filterable tables for beers, breweries, styles, and flavor profiles

## Development

Runs on Ruby and Jekyll 4.

```sh
bundle install
bundle exec jekyll serve
```

## Data structures

All aggregated data lives in `_data/`. Key files:

| File | Contents |
|---|---|
| `allmy.json` | Master aggregate: totals, `abv` histogram, `weekly` day-of-week counts, `streak` data, and `years` → `months` breakdowns |
| `beers.json` | All unique beers with ABV, IBU, brewery, rating, and check-in count |
| `breweries.json` | All breweries with country, beer list, and check-in count |
| `countries.json` | Countries with ISO code and check-in count (UK nations use `id: "GB"`, remapped to sub-regions in the map JS) |
| `styles.json` | Beer styles with unique beer count and total check-ins |
| `flavors.json` | Flavor profile tags with counts |
| `missing_styles.json` | Styles not yet tried |
| `missing_countries.json` | Countries not yet represented |

`checkins/YYYY.json` are the raw check-in records from the Untappd API — one file per year, these are the source of truth.

## Regex for getting styles from Untappd.com

Untappd sometimes changes their list of styles, so it needs to be kept updated.

1. Go to https://untappd.com/beer/top_rated
2. Use this regex to extract styles:
   `<option value="\d+" data-value-slug="(\w|-)+">([A-Za-z\-\s\(\)/&èéäö]+)</option>`
