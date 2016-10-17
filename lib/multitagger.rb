require "multitagger/version"
require "multitagger/tag"
require "multitagger/config"

Dir[File.dirname(__FILE__) + '/multitagger/provider/*.rb'].each {|file| require file }

module Multitagger
  def self.tagger(provider, config = nil)
    clazz = Provider.const_get(provider.to_s.capitalize)
    config ||= Config.read[provider.to_s]
    clazz.new(config)
  end

  def self.providers
    Provider.constants.select { |c| Provider.const_get(c).is_a? Class }.map(&:downcase)
  end

  def self.tag(provider, image)
    self.tagger(provider).tag(image)
  end
end
