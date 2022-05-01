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
3. Let Github Action push back to the repo by going to the repo `Settings` > `Actions` > `General`, scroll to the bottom. Under `Workflow permissions` make sure that `Read and write permissions` are enabled.
4. Enable Github Pages by going to the repo `Settings` > `Pages`. Under `Source` click the button that says `None` and choose `Main` (or your custom branch`.
6. Upload your own `untappd.json` data
7. Github Action will automatically build and upload your new data

### Update your fork
Check out [Github doc](https://docs.github.com/en/github/collaborating-with-pull-requests/working-with-forks/merging-an-upstream-repository-into-your-fork) for an easy guide for how to update your fork.

## Development
It's running on Ruby and Jekyll.

### Regex for getting styles from Untappd.com
Untappd sometimes changes their list of styles, so it needs to be kept updated.

1. Go to https://untappd.com/beer/top_rated
2. Use this regex to easily get a formatted line of styles
   `<option value="\d+" data-value-slug="(\w|-)+">([A-Za-z\-\s\(\)/&èéäö]+)</option>`

## Data structures
Easily seen in the `_data`-folder. There are one file for each feature.
