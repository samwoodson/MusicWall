class Song < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :reviews

  validates :title, presence: true
  validates :artist, presence: true
  validates :link, presence: true

  before_save :youtube_embed

  def youtube_embed
    if link[/youtu\.be\/([^\?]*)/]
      @youtube_id = $1
      self.link = "http://www.youtube.com/embed/#{@youtube_id}"
    elsif
      link[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      @youtube_id = $5
      self.link = "http://www.youtube.com/embed/#{@youtube_id}"
    end
  end

end