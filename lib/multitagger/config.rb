require 'yaml'

module Multitagger
  class Config
    def self.read(path = "config/multitagger.yml")
      @@config ||= YAML.load_file(path)
    end
  end
end
