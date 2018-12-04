class Like < ApplicationRecord
  belongs_to :user
  validates :tweet_id, uniqueness: true
end
