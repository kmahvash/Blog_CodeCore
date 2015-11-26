class Post < ActiveRecord::Base

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  validates(:title, {presence: true, length: {minimum: 5}})

  validates(:body, {presence: true})

  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :image, ImageUploader

  paginates_per 24
  max_paginates_per 50

  def liked_by?(user)
    likes_for(user).present?
  end

  def likes_for(user)
    likes.find_by_user_id(user.id)
  end

  def votes_for(user)
    votes.find_by_user_id(user_id)
  end

  def voted_for?(user)
    votes_for(user).present?
  end

  def vote_results
    votes.select{|v| v.is_up?}.count - votes.select{|v| !v.is_up?}.count
  end

  def self.search(term)
    if term
      where(["title ILIKE? OR body ILIKE?", "%#{term}%", "%#{term}%"])
    else
      all
    end
  end






end
