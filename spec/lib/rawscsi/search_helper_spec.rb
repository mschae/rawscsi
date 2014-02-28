$root = File.expand_path('../../../', __FILE__)
require "#{$root}/spec_helper"

describe Rawscsi::SearchHelper do
  before(:each) do
    @search_helper = Rawscsi::SearchHelper.new(:model => 'Song',
      :domainname => 'good_songs',
      :domainid => '1a2b3c4d5e6f7g8h',
      :region => 'us-east-1',
      :api_version => '2011-02-01')
  end
  it 'instantiates properly' do
    @search_helper.model.should == 'Song'
    @search_helper.domainname.should == 'good_songs'
    @search_helper.domainid.should == '1a2b3c4d5e6f7g8h'
    @search_helper.region.should == 'us-east-1'
    @search_helper.api_version.should == '2011-02-01'
  end

  it 'can accept default conditions' do
    @search_helper.default_conditions = {:limit => 10}
    @search_helper.default_conditions.should == {:limit => 10}
  end

  context 'query url' do
    it 'constructs basic url correctly' do
      url = @search_helper.url('nick drake')
      url.should == "http://search-good_songs-1a2b3c4d5e6f7g8h.us-east-1.cloudsearch.amazonaws.com/2011-02-01/search?q=nick%20drake"
    end

    it 'constructs url with limit correctly' do
      url = @search_helper.url('mazzy star', :limit => 10)
      url.should == "http://search-good_songs-1a2b3c4d5e6f7g8h.us-east-1.cloudsearch.amazonaws.com/2011-02-01/search?q=mazzy%20star&size=10"
    end

    it 'constructs url with date correctly' do
      one_week_ago = 1.week.ago
      now = Time.now
      url = @search_helper.url('lorde', 
        :date => { :name => :release_date,
          :from => one_week_ago,
          :to => now})
      url.should include("&bq=(and%20release_date:#{one_week_ago.to_i}..#{now.to_i}")
    end

    it 'constructs url with boolean conditions correctly' do
      url = @search_helper.url('radiohead', :bq => 'b_side:1')
      url.should include('&bq=(and%20b_side:1%20)')
    end

    it 'constructs url for multiple conditions correctly' do
      one_week_ago = 1.week.ago
      now = Time.now
      url = @search_helper.url('radiohead', :bq => 'b_side:1', :limit => 5,
        :date => {
          :name => :release_date,
          :from => one_week_ago,
          :to => now
          })
      url.should include("&bq=(and%20release_date:#{one_week_ago.to_i}..#{now.to_i}%20b_side:1%20)&size=5")
    end
  end
end
