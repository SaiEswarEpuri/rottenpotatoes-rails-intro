class Movie < ActiveRecord::Base
    def self.all_ratings
     self.order(:rating).select(:rating).map(&:rating).uniq
    end
end
