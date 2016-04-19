class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :message, presence: true

end