class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :user_id, presence: true
  validates :song_id, presence: true, uniqueness: {scope: :user_id}

  before_save :unique_vote

  # private
  #   def unique_vote
  #     if Vote.find_by(user_id: user_id) && Vote.find_by(song_id: song_id)
  #       false
  #     end
  #   end

end