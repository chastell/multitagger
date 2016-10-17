require 'clarifai_ruby'
require 'base64'

module ClarifaiRuby
  class MyTagRequest < TagRequest
    def get(image_url_or_path, opts = {})
      if image_url_or_path =~ URI::regexp
        super
      else
        body = {
          encoded_data: File.new(image_url_or_path),
          model: opts[:model]
        }
        build_request!(body, opts)
        @raw_response = @client.post(TAG_PATH, body).parsed_response
        raise RequestError.new @raw_response["status_msg"] if @raw_response["status_code"] != "OK"
        TagResponse.new(raw_response)
      end
    end
  end
end

module Multitagger
  module Provider
    class Clarifai
      def initialize(our_config)
        ClarifaiRuby.configure do |config|
          config.client_id = our_config["id"]
          config.client_secret = our_config["secret"]
        end
      end

      def tag(image)
        response = ClarifaiRuby::MyTagRequest.new.get(image)
        response.tag_images.first.tags.map { |x| Tag.new(x.word, x.prob) }
      end
    end
  end
end
