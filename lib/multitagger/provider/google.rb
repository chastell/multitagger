require 'google/cloud'

module Multitagger
  module Provider
    class Google
      def initialize(config)
        @vision = ::Google::Cloud.vision(config["project"], config["keyfile"])
      end

      def tag(image)
        img = @vision.image(image)
        img.labels.map { |x| Tag.new(x.description, x.score) }
      end
    end
  end
end
