# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save article without email' do
    user = User.new
    assert user.save
  end
end
