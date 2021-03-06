# Fepath

### THIS IS ALPHA QUALITY SOFTWARE

A collection of command line tools to extract json from TIYO, convert it to files and folders and convert it back to json.

## Installation

**Clone the Repo**

Running the following command will prompt for username / password for tiyo, saving your input in a .env file for the repo, as well as running bundle install

`ruby bin/setup`

## Getting started

1. `bin/setup` will walk you through auth and initial setup.

## Usage

1. Scrape TIYO for all of your paths `ruby bin/extract`
2. Convert JSON into files / folders `ruby bin/convert`
2. Convert files / folders into JSON  `ruby bin/upload`
3. TODO: Actually upload to TIYO

All file operations will happen in this folder, under the tmp dir.

#### Folder format

* project
  - meta.yml
  * unit_1
    - meta.yml
    * 1_lets_teach.md
    * 2_lets_give_out_homework.md
    * 3_assingment_with_attachments
      - meta.json
      * readme.md
      * attachmen_1.rb

meta.yml / Frontmatter are parsed as yaml and are sanitized and injected
as attributes to the thing being created.

Titles and such for individual lessons are extracted from front matter in
each file.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fepath. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
