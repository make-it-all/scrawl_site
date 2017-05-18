class Note < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  scope :visible, ->{ all }

end
