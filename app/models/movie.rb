class Movie < ActiveRecord::Base
	def self.all_ratings
		self.select(:rating).group(:rating).map { |movie| movie.rating }.sort
	end
end
