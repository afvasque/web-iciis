class StudySite < ActiveRecord::Base
	has_and_belongs_to_many :projects
	acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :check_process => true, :checker => "gmaps"
	
	#  RETURNS LATLONG AS NEEDED FOR GMAPS API
  	def latlong
    	[self.latitude , self.longitude]
  	end

  	def gmaps4rails_address
  		if self.latitude.blank? or self.longitude.blank?
  			self.location
  		else
  			[self.latitude, self.longitude]
      end
	end
end
