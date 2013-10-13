class StudySite < ActiveRecord::Base
	has_and_belongs_to_many :projects
	acts_as_gmappable :lat => 'latitude', :lng => 'longitude'
	
	#  RETURNS LATLONG AS NEEDED FOR GMAPS API
  	def latlong
    	[self.latitude , self.longitude]
  	end

  	def gmaps4rails_address
  		self.location
	end
end
