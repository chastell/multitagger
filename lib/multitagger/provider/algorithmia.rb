require 'algorithmia'

module Multitagger
  module Provider
    class Algorithmia
      def initialize(config)
        @client = ::Algorithmia.client(config["key"])
      end

      def tag(image)
        algo = @client.algo("deeplearning/IllustrationTagger/0.2.3")
        image_data = Base64.encode64(File.open(image, "rb").read)
        input = { "image" => "data:image/jpeg;base64,#{image_data}" }
        result = algo.pipe(input).result
        result["general"].map { |x| Tag.new(x.keys.first, x.values.first) }
      end
    end
  end
end
