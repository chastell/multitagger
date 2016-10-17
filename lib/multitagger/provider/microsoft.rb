require 'microsoft_computer_vision'
require 'json'

module Multitagger
  module Provider
    class Microsoft
      def initialize(config)
        @client = MicrosoftComputerVision::Client.new(config["key"])
      end

      def tag(image)
        result = @client.analyze image, {visual_features: "Tags"}
        data = JSON.parse result.body
        data["tags"].map { |x| Tag.new(x["name"], x["confidence"]) }
      end
    end
  end
end
