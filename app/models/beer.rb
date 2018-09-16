class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    return "Beer has #{ratings.count} #{"rating".pluralize(ratings.count)}, average #{ratings.average(:score)}"
  end
end
