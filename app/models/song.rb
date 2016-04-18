class Song < ActiveRecord::Base

  validates :title, presence: true
  validates :artist, presence: true
  validates :link, presence: true

  before_save :youtube_embed

  def youtube_embed
    if link[/youtu\.be\/([^\?]*)/]
      @youtube_id = $1
    else
      link[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      @youtube_id = $5
    end
  end


end