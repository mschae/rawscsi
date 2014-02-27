module Rawscsi
  class SearchHelper
    attr_accessor :model, :domainname, :domainid, :region, :api_version

    def initialize(options)
      options.each do |key, value|
        self.send((key.to_s+'=').to_sym, value)
      end
    end

  end
end
