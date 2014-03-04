$root = File.expand_path('../../../', __FILE__)
require "#{$root}/spec_helper"
require 'active_support/core_ext'

describe Rawscsi::SearchHelper do
  before(:each) do
    Rawscsi.configure do |config|
      config.model = 'Song'
      config.domainname = 'good_songs'
      config.domainid = '1a2b3c4d5e6f7g8h'
      config.region = 'us-east-1'
      config.api_version = '2011-02-01'
    end

    @search_helper = Rawscsi::SearchHelper.new
  end

  it 'configures properly' do
    Rawscsi.configuration.model.should == 'Song'
    Rawscsi.configuration.domainname.should == 'good_songs'
    Rawscsi.configuration.domainid.should == '1a2b3c4d5e6f7g8h'
    Rawscsi.configuration.region.should == 'us-east-1'
    Rawscsi.configuration.api_version.should == '2011-02-01'
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
      url = @search_helper.url
      url.should == "http://search-good_songs-1a2b3c4d5e6f7g8h.us-east-1.cloudsearch.amazonaws.com/2011-02-01/search"
    end
  end

  context '.bq_conditions' do
    it 'constructs date correctly' do
      one_week_ago = 1.week.ago
      now = Time.now
      conditions = @search_helper.bq_conditions(
        :date => { :name => :release_date,
                   :from => one_week_ago,
                   :to => now})
      conditions.should == "(and release_date:#{one_week_ago.to_i}..#{now.to_i})"
    end

    it 'constructs url with boolean conditions correctly' do
      url = @search_helper.bq_conditions(:bq => 'b_side:1')
      url.should == '(and b_side:1)'
    end

  end
  context '.conditions' do
    it 'constructs url for multiple conditions correctly' do
      one_week_ago = 1.week.ago
      now = Time.now
      conditions = @search_helper.conditions(:bq => 'b_side:1', :limit => 5,
                                             :date => {
        :name => :release_date,
        :from => one_week_ago,
        :to => now
      })
      conditions.should == {
        bq: "(and release_date:#{one_week_ago.to_i}..#{now.to_i} b_side:1)",
        size: 5,
      }
    end
  end
end
