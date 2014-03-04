module Rawscsi
  module Searchable
    extend ActiveSupport::Concern

    included do
      @search_helper = Rawscsi::SearchHelper.new.tap do |search_helper|
        search_helper.model = self.to_s
      end
    end

    module ClassMethods
      delegate :search, to: :@search_helper
    end
  end
end

