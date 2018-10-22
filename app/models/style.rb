class Style < ApplicationRecord
  has_many :beers
  has_many :ratings, through: :beers

  include RatingAverage

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating || 0) }.first(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
  end
end
