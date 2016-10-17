require 'multitagger'

puts Multitagger.tagger(:clarifai).tag("/tmp/cat.jpg")
