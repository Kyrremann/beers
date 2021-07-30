Beers
=====

Beers uses your exported data from Untappd and generate even more statistics than what Untappd offer.
For example can you see beers per year, and month, plus it averages several interesting facts, such as abv and number of consumed beers.

Some key features:

* Beers per year and month
* Average beer per month and year
* Easily see beers, breweries, and styles you have tried


## Getting started

It's pretty simple to get started using this application, as it's all hosted by Github. I use Github Actions to generate the data based on the `untappd.json` file.

1. Fork this repo
2. Change `e-mail` in `_config.yml` 
   * The site will be aviable at `<username>.github.io/beers`
3. Upload your own `untappd.json` data
4. Github Action will automatically build and upload your new data


### Regex for getting styles from Untappd.com

1. Go to https://untappd.com/beer/top_rated
2. Use this regex to easily get a formatted line of styles
   `<option value="\d+" data-value-slug="(\w|-)+">([A-Za-z\-\s\(\)/&èéäö]+)</option>`


## Data structures

Easily seen in the `_data`-folder. There are one file for each feature.
