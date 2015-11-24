class User < ActiveRecord::Base

  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :votes, dependent: :nullify
  has_many :voted_posts, through: :votes, source: :question

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip
  end


end
