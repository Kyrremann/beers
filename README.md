allmy.beer
==========

Allmy.beer uses your exported data from Untappd and generate even more statistics than what Untappd offer. For example can you see beers per year, and month, plus it avarages several interesting facts, such as abv and number of consumed beers.

Some key features:

* Beers per year and month
* Average beer per month and year
* Easily see beers, breweries, and styles you have tried


## Getting started

It's pretty simple to get started using this application, as it's all hosted by Github, and I use Travis to generate the data and files needed.

1. Fork this repo
2. Change `e-mail` and `url` in `_config.yml` 
   * If you don't have a domain, use `<username>.github.io/allmy.beer` as `url`
3. Follow this [gist](https://gist.github.com/willprice/e07efd73fb7f13f917ea#guided-tutorial) to set up [Travis](https://travis-ci.org/)
4. Upload your own `untappd.json`
5. Travis will automatically build and upload your new data


## Data structures

Easily seen in the `_data`-folder. There are one file for each feature.
