class User < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true, uniqueness: true 
    validates :password, presence: true, length: {minimum: 6}, on: :create
    validates :email, uniqueness: true
    has_one_attached :avatar
    has_many :posts, dependent: :destroy 
    GenderOptions = ["Male", "Female","Prefer not to say"]
    attr_accessor :oldpassword
    attr_accessor :email_or_phone

    has_many :likeables, dependent: :destroy
    has_many :liked_posts, through: :likeables,source: :post 
    has_many :comments,dependent: :destroy

    def date_joined 
        created_at.strftime("%B %d, %Y")
    end

    def like(post)
        if liked_posts.include?(post)
            liked_posts.destroy(post)
            return false
        else 
            liked_posts << post
            return true
        end
    end

    def liked?(post)
        liked_posts.include?(post)
    end

end
