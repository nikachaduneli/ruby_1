
class Article < ApplicationRecord
  validates :title, presence: true, length: {maximum: 100, minimum: 5}
  validates :description, presence: true, length: { minimum: 5}
  has_many_attached :images, :dependent => :destroy
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  self.per_page = 5

end
