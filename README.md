# Sinatra::Pepper

A gem for loading sinatra extensions by condition, like chanko or chili gem for sinatra

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra' # require: 'sinatra/base'
gem 'sinatra-pepper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-pepper

## Usage

```ruby
require 'sinatra/base'
require 'sinatra-pepper'

module PepperSample
  def self.registered(base)
    base.set :foo_key, "Hello, admin!"
  end
end

class Sample < Sinatra::Base
  register Sinatra::Pepper
  register_pepper PepperSample do |env|
    env['rack.session'] && env['rack.session']['is_admin']
  end

  set :foo_key, "Hello, friend!"
  get '/' do
    "#{settings.foo_key}"
  end
end
Sample.run!
```

Then, if you're normal user, see on `/`:

    "Hello, friend!"

No effect from a pepper extension. But if you're admin, you'll see:

    "Hello, admin!"

TBD More sample & test...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
