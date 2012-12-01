require 'sinatra/base'

module Sinatra
  module Pepper
    def self.registered(base)
      base.class_eval {
        alias_method :__call__!, :call!

        def call!(env)
          spiced_klass = nil
          self.class.peppers.each_pair do |extension, condition|
            if condition.call(env)
              spiced_klass ||= Class.new(self.class)
              spiced_klass.send :register, extension
            end
          end
          spiced_klass ? spiced_klass.call(env) : self.__call__!(env)
        end
      }
    end

    # TODO peppers would not be inherited, I wonder is it OK
    def peppers
      @peppers ||= {}
    end

    def register_pepper(extension, opts={}, &condition)
      if bloc = opts[:if]
        register_pepper extension, &bloc
      end
      peppers[extension] = condition
    end
  end

  register Pepper
end
