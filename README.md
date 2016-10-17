# Multitagger

Multitagger offers a unified API for automatic image tagging services. With Multitagger, you can start developing your image-recognizing app and have
the comfort of changing your provider without rewriting the code, or even
use multiple providers at once. See the [blog post] for background.

Multitagger currently supports five providers:

 - [Algorithmia Illustration Tagger]
 - [Clarifai]
 - [Google Cloud Vision]
 - [Imagga]
 - [Microsoft Cognitive Services]

 [Algorithmia Illustration Tagger]: https://algorithmia.com/algorithms/deeplearning/IllustrationTagger
 [Clarifai]: https://www.clarifai.com/
 [Google Cloud Vision]: https://cloud.google.com/vision/
 [Microsoft Cognitive Services]: https://www.microsoft.com/cognitive-services
 [Imagga]: https://imagga.com
 [blog post]: https://blog.rebased.pl/2016/10/04/computer-vision-1.html

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'multitagger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multitagger

## Usage

The simplest way to use Multitagger is to just do:

```ruby
tags = Multitagger.tag(:google, "/path/to/your/image.jpg")
```

Where the first argument tells Multitagger to use Google Cloud Vision as the tagging service, and the second designates a local path to your image.

This will return an array of `Multitagger::Tag` structures, each of which has `name` (a string) and `prob` (a number from 0.0 to 1.0 representing the probability that this tag fits the image). See the file `multitagger/tag.rb`.

To use another provider, just replace the first argument. `Multitagger.providers` will tell you what providers are available.

You can also instantiate the tagging service and then call the `tag` method on that:

```ruby
tagger = Multitagger.tagger(:google)
tags = tagger.tag("/path/to/your/image.jpg")
```

## Configuration

Before you can use Multitagger, you must configure it. This is commonly done by putting your service’s credentials in `config/multitagger.yml`.

You need obtain the credentials (typically an API key, an app ID, a secret, or a combination of these, depending on the service) separately for each service you plan on using, by registering with the service.

You’ll find a sample `multitagger.yml` in the `config/` directory in this repo; substitute the keys as needed.

If you need to put this file elsewhere, call this before invoking tagging:

```ruby
Multitagger::Config.read("/path/to/your/multitagger.yml")
```

Alternatively, you can pass the configuration hash as a second argument to `Multitagger.tagger`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rebased/multitagger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
