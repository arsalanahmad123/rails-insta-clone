class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one_attached :video 
  attr_accessor :media 
  has_many :likeables, dependent: :destroy
  has_many :likes, through: :likeables,source: :user 
  has_many :comments,dependent: :destroy

  def date_joined 
    created_at.strftime("%B %d, %Y")
  end
  
end