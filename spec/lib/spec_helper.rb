$root = File.expand_path('../../', __FILE__)
require "#{$root}/lib/rawscsi"

class AWSCSMockResponse
  class << self
    def body
      "{\"hits\":{\"found\":3,\"hit\":[{\"id\":1},{\"id\":2},{\"id\":3}]}}"
    end
  end
end