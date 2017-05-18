class User < ApplicationRecord
  include Clearance::User

  has_many :notes

  def self.authenticate_by_token token
    User.find_by(auth_token: token) if token.present?
  end

  def new_token!
    SecureRandom.hex(16).tap do |random_token|
      update_attributes auth_token: random_token
    end
  end

  def delete_token!
    update_attributes auth_token: nil
  end

end
