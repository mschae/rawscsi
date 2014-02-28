$root = File.expand_path('../../../', __FILE__)
require "#{$root}/spec_helper"
require 'active_record'

describe Rawscsi::Base do
  it 'collects ids from aws response correctly' do
    aws_api = double
    aws_api.stub(:body => "{\"hits\":{\"found\":3,\"hit\":[{\"id\":1},{\"id\":2},{\"id\":3}]}}")
    Rawscsi::Base.new.collect_ids(aws_api).should == [1, 2, 3]
  end

  it 'returns empty array when there are no results' do
    id_array = []
    Rawscsi::Base.new.collect_ar([]).should == []
  end
end