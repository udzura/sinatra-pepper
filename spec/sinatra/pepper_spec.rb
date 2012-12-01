require 'spec_helper'

describe Sinatra::Pepper do
  it { should respond_to :registered }
  describe 'ad-hoc registration' do
    module Pepper1
      def self.registered(base)
        base.set :foo_key, "admin_value"
      end
    end

    class Sample < Sinatra::Base
      register Sinatra::Pepper
      register_pepper Pepper1 do |env|
        env['rack.session'] && env['rack.session']['is_admin']
      end

      disable :show_exceptions
      set :foo_key, "normal_value"
      get '/' do
        "#{settings.foo_key}"
      end
    end

    def app
      Sample
    end

    describe 'normal access' do
      before { get '/' }
      subject { last_response.body }
      it { should == "normal_value" }
    end

    describe 'admin access' do
      before do
        get '/', {}, {'rack.session' => {'is_admin' => true} }
      end
      subject { last_response.body }
      it { should == "admin_value" }
    end
  end

end
