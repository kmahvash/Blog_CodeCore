class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  validates :title, presence: true, length: {minimum: 5}

  validates :body, presence: true

  def self.search(term)
    if term == ""
    "You must enter a search term"
    else
    where(["title ILIKE? OR body ILIKE?", "%#{term}%", "%#{term}%"])
    end
  end

end
