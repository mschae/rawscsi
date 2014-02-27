require 'uri'

module Rawscsi
  class SearchHelper
    attr_accessor :model, :domainname, :domainid, :region, :api_version

    def initialize(options)
      options.each do |key, value|
        self.send((key.to_s+'=').to_sym, value)
      end
    end

    def url(query, options={})
      options = {}.merge(options)
      sep_url = ''
      sep_url << "http://search-"
      sep_url << "#{domainname}-#{domainid}.#{region}."
      sep_url << "cloudsearch.amazonaws.com/"
      sep_url << "#{api_version}/search?"
      sep_url << "q=#{query}"
      URI.escape(sep_url)
    end

  end
end