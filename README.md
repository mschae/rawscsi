# Rawscsi

Rails Amazon Web Services Cloud Search Interface

Here's the official aws documentation: http://docs.aws.amazon.com/cloudsearch/latest/developerguide/searching.html

## Installation

Add this line to your application's Gemfile:

    gem 'rawscsi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rawscsi

## Usage

### Configuration

```ruby
Rawscsi.configure do |config|
  config.model = 'Article'
  config.domainname = 'prod-br-articles'
  config.domainid = 'puvb75tayhp4vxtqrk52ear3ty'
  config.region = 'us-east-1'
  config.api_version = '2011-02-01'
end
```

### Using the search helper programatically
```ruby
search_songs_helper = Rawscsi::SearchHelper.new
```

You can set default search conditions

```ruby
search_songs_helper.default_conditions = {:limit => 10}
```

Use it to search over an aws search domain. It returns an array of active record models, ordered by CloudSearch's rank score.

### Using the serach helper mixin

Given an arbitrary model that uses `ActiveRecord`. You gain search capibilities by `include`ing `Rawscsi::Searchable`:

```ruby
class User < ActiveRecord::Base
  include Rawscsi::Searchable
end
```

### Searching

```ruby
search_songs_helper.search('nick drake')
  => [#<Song id:156, artist_id: 13423, title: "Hazey Jane II">,
      #<Song id:342, artist_id: 13423, title: "One of These Things First">]
```

You can also add boolean conditions. This query only selects radiohead songs that are b-sides. Note this assumes in the good_songs search domain, there is a boolean field named "b_side".

```ruby
search_songs_helper.search('radiohead', :bq => "b_side:1")
  => [#<Song id:176, artist_id: 3423, title: "Meeting in the Aisle">..]
```

Here's how you limit the results:

```ruby
search_songs_helper.search('nick drake', :limit => 3)
```

Dates are a common constraint. Note the date index on cloud search must be a Unix timestamp integer.

```ruby
search_songs_helper.search('lorde',
  :date => {:name => 'release_date',
    :from => 10.months.ago, :to => Time.now})
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
