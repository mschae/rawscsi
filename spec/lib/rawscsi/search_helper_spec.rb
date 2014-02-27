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

  context 'query url' do
    it 'constructs basic url correctly' do
      @search_helper.url('nick drake').should == "http://search-good_songs-1a2b3c4d5e6f7g8h.us-east-1.cloudsearch.amazonaws.com/2011-02-01/search?q=nick%20drake"
    end
  end
end