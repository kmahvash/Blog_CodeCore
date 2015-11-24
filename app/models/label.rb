class Label < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :labelings, dependent: :destroy
  has_many :labeled_posts, through: :labelings, source: :post

end
