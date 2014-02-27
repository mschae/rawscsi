$root = File.expand_path('../../../', __FILE__)
require "#{$root}/spec_helper"

describe Rawscsi::SearchHelper do
  it 'instantiates properly' do
    search_helper = Rawscsi::SearchHelper.new(:model => 'Song',
      :domainname => 'good_songs',
      :domainid => '1a2b3c4d5e6f7g8h',
      :region => 'us-east-1',
      :api_version => '2011-02-01')
    search_helper.model.should == 'Song'
    search_helper.domainname.should == 'good_songs'
    search_helper.domainid.should == '1a2b3c4d5e6f7g8h'
    search_helper.region.should == 'us-east-1'
    search_helper.api_version.should == '2011-02-01'
  end
end