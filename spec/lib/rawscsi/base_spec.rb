$root = File.expand_path('../../../', __FILE__)
require "#{$root}/spec_helper"

describe Rawscsi::Base do
  it 'collects ids from aws response correctly' do
    Rawscsi::Base.collect_ids(AWSCSMockResponse).should == [1, 2, 3]
  end
end