require 'uri'

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
      cond_array = ['and']
      cond_array << date_condition(options[:date]) if options[:date]
      cond_array += Array(options[:bq]) if options[:bq]
      ['(', cond_array.compact.join(' '), ')'].join
    end

    def conditions(options)
      conds = {}
      conds.merge!({:bq => bq_conditions(options)}) if options[:date] || options[:bq]
      conds.merge!({:size => options[:limit]}) if options[:limit]
      conds
    end

    def search(query, options)
      results = send_req_to_aws(url, query, options)
      get_ar_objects(results)
    end

    def url
      sep_url =  "http://search-"
      sep_url << "#{domainname}-#{domainid}.#{region}."
      sep_url << "cloudsearch.amazonaws.com/"
      sep_url << "#{api_version}/search"
      URI.escape(sep_url)
    end
  end
end
