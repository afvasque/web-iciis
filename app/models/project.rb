class Project < ActiveRecord::Base
	
	#  RETURNS LATLONG AS NEEDED FOR GMAPS API
  	def latlong
    	[self.latitude , self.longitude]
  	end

end
