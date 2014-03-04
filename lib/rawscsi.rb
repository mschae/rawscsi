module Rawscsi
  autoload :Version,      'rawscsi/version'
  autoload :Base,         'rawscsi/base'
  autoload :SearchHelper, 'rawscsi/search_helper'
  autoload :Searchable,   'rawscsi/searchable'

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
