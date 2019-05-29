class Micropost < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(created_at: :DESC) }

  validates :user_id, presence: true
  validates :content, presence: true, length:
    { maximum: Settings.microposts.content.max_length }
end
