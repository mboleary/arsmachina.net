# Arsmachina.net

This is a personal blog built using Zola SSG with some extra scripts. The website is hosted using gitlab pages.

This is the public repository where the majority of my content lives.

## Data

The Data directory is how I include some build information into the webpage itself

- `cow` - This is the cow that is displayed on all pages

- `compile_date` - This is the date and time that the website was last compiled

- `git_hash` - This is the hash from the arsmachina.net repo that the website was built with

- `git_branch` - This is the branch that the website was built with

## Scripts

There are a collection of scripts that build and deploy the website.

If instaling for the first time, run `init.sh`.

To build the website, run `build.sh`.

To deploy the website, run `deploy.sh`

To clear build artifacts, run `clean.sh`

## Other directories

Most of the directories and files are pretty self-explainatory, but are listed here nonetheless.

- `content` - This holds the content for the website

- `data` (ignored) - Stores some data that is rendered into the website

- `npm` - Contains the npm libraries that are used in this website

- `scripts` - Contains scripts used to build the website

- `static` - Static content copied directly over to the website without going through the SSG

- `templates` - Template data for the website

- `config.toml` - Config file for Zola SSG

- `tags.json` - Contains styling information and text for labels
