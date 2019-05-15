# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :track_histories

  # Validation
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
end
