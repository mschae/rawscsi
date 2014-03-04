require 'uri'
require 'net/http'

module Rawscsi
  class SearchHelper < Rawscsi::Base
    attr_accessor :model, :domainname, :domainid, :region, :api_version, :default_conditions

    def initialize
      config = Rawscsi::configuration
      [:model, :domainname, :domainid, :region, :api_version].each do |key|
        self.send((key.to_s+'=').to_sym, config.send(key))
      end
      self.default_conditions = {}
    end

    def date_condition(date_hash)
      name = date_hash[:name]
      from = date_hash[:from].to_i
      to = date_hash[:to].to_i
      "#{name}:#{from}..#{to}"
    end

    def bq_conditions(options)
      cond_array = ['&bq=(and']
      cond_array << date_condition(options[:date]) if options[:date]
      cond_array << options[:bq] if options[:bq]
      cond_array << ')'
      cond_array.compact.join(' ')
    end

    def conditions(options)
      cond_str = ''
      cond_str << bq_conditions(options) if options[:date] || options[:bq]
      cond_str << "&size=#{options[:limit]}" if options[:limit]
      cond_str
    end

    def url(query, options={})
      options = default_conditions.merge(options)
      sep_url = ''
      sep_url << "http://search-"
      sep_url << "#{domainname}-#{domainid}.#{region}."
      sep_url << "cloudsearch.amazonaws.com/"
      sep_url << "#{api_version}/search?"
      sep_url << "q=#{query}"
      sep_url << conditions(options)
      URI.escape(sep_url)
    end

    def search(query, options)
      results = send_req_to_aws(url(query, options))
      get_ar_objects(results)
    end
  end
end