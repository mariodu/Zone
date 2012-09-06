ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "#{Rails.root}/test/test_helper/functional_helper"

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:renren] = {
    'uid'      => '123456',
    'provider' => 'renren',
    'info'     => {
      'name' => 'DavidQin'
    }
}
