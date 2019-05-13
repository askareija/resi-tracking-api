# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # Validation
  validates :email, presence: true, uniqueness: true
end
