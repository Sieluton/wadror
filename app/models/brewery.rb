class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage

  validates :name, presence: true
  validates :year, inclusion: { in: 1040..2018 }
end
