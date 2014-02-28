require 'uri'
require 'net/http'

module Rawscsi
  class Base
    def send_req_to_aws(query_str)
      url = URI.parse(query_str)
      req = Net::HTTP::Get.new(url.to_s)
      Net::HTTP.start(url.host, url.port) {|http| http.request(req)}
    end

    def collect_ids(response)
      response_hash = JSON.parse(response.body)
      response_hash['hits']['hit'].collect {|result| result['id']}
    end

    def collect_ar(id_array)
      return [] if id_array.empty?
      model.constantize.find_all_by_id(id_array, :order => "field(id, #{id_array.join(',')})")
    end

    def get_ar_objects(response)
      id_array = collect_ids(response)
      collect_ar(id_array)
    end
  end
end