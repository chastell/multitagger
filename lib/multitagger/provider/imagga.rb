require 'rest_client'

module Multitagger
  module Provider
    class Imagga
      def initialize(config)
        @key = config["key"]
        @secret = config["secret"]
      end

      def tag(image)
        auth = 'Basic ' + Base64.strict_encode64("#{@key}:#{@secret}").chomp
        image_response_raw = RestClient.post "https://api.imagga.com/v1/content",
                                             { image: File.new(image, 'rb') },
                                             { Authorization: auth }
        image_response = JSON.parse image_response_raw
        image_id = image_response["uploaded"].first["id"]
        tag_response_raw = RestClient.get "https://api.imagga.com/v1/tagging?content=#{image_id}",
                                          { Authorization: auth }
        tag_response = JSON.parse tag_response_raw
        tags = tag_response["results"].first["tags"].map { |x| [ x["tag"], x["confidence"] ] }
        tags.map { |x| Tag.new(x.first, x.last / tags.first.last) }
      end
    end
  end
end
