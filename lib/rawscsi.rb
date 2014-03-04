$root = File.expand_path('../../', __FILE__)
require "#{$root}/lib/rawscsi/version"
require "#{$root}/lib/rawscsi/base"
require "#{$root}/lib/rawscsi/search_helper"

module Rawscsi
  class Configuration
    attr_accessor :model, :domainname, :domainid, :region, :api_version
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    config = configuration
    yield(config)
  end
end