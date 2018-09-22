class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1040, less_than_or_equal_to: proc { Time.now.year } }
end
