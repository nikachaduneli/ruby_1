# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true,
            length: {maximum: 40, minimum: 5}
end
