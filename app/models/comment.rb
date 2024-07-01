class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, length: { maximum: 1000 }



  def first_letter_of_user 
    self.user.username[0].upcase
  end

  def created_at_formatted
    self.created_at.strftime("%B %d, %Y")
  end

end
