class Movie < ActiveRecord::Base
   scope :all_ratings, -> {uniq.pluck(:rating)}
end
