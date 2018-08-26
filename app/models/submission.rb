class Submission < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :artist, presence: true, length: { maximum: 100 }
  validates :genre, presence: true, length: { maximum: 100 }
end
