class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :user_id, presence: true
  validates :song_id, presence: true, uniqueness: {scope: :user_id}

end