require 'httparty'

module Rawscsi
  class Base
    def send_req_to_aws(url, query, options)
      HTTParty.get url, query: options.merge(q: query)
    end

    def collect_ids(response)
      response_hash = JSON.parse(response.body)
      response_hash['hits']['hit'].collect {|result| result['id']}
    end

    def collect_ar(id_array)
      return [] if id_array.empty?
      id_array.collect!(&:to_i)
      results =
        if ActiveRecord::VERSION::MAJOR > 2
          klass.where(:id => id_array).to_a
        else
          klass.find_all_by_id(id_array)
        end
      results.index_by(&:id).slice(*id_array).values
    end

    def klass
      model.constantize
    end

    def get_ar_objects(response)
      id_array = collect_ids(response)
      collect_ar(id_array)
    end
  end
end
