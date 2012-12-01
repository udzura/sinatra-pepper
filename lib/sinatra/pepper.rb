require 'sinatra/base'

module Sinatra
  module Pepper
    def self.registered(base)
      :noop
    end
  end

  register Pepper
end
