# Rawscsi

Rails Amazon Web Services Cloud Search Interface

## Installation

Add this line to your application's Gemfile:

    gem 'rawscsi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rawscsi

## Usage

Instantiate a search helper:

    my_search_helper = Rawscsi::SearchHelper.new(
      :model => 'Song',
      :domainname => 'good_songs',       
      :domainid => 'a1b2c3d4e5f6g7h8i',
      :region => 'us-east-1',
      :api_version => '2011-02-01'
      )

Use it to search over your aws search domain.
Returns an array of active record models.

    my_search_helper.search('nick drake')
      => [#<Song id:156, author_id: 13423, title: "Hazey Jane II">,
          #<Song id:342, author_id: 13423, title: "One of These Things First">]

You can also add boolean conditions:

    my_search_helper.search('nick drake', :bq => 'lyrics: lets sing a song for hazey jane')
      => [#<Song id:156, author_id: 13423, title: "Hazey Jane II">]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
