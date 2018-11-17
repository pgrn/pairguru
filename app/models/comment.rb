class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user, counter_cache: true

  validates :movie_id, uniqueness: { scope: :user_id, message: "You have already left a comment on this movie!"}
  validates :text, presence: true
end
