# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name,
            presence: true,
            uniqueness: true,
            length: {maximum: 40, minimum: 5}

  self.per_page = 5
end
