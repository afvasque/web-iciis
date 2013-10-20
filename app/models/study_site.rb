class StudySite < ActiveRecord::Base
	has_and_belongs_to_many :projects
  validates_presence_of :location
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

    def gmaps4rails_sidebar
      #Podrian agregarse mas proyectos por sitio de estudio
     "<div class='sidebar_project'>
      #{self.projects[0].title} - #{self.location} <br /> 
      #{self.projects[0].researchers[0].name}
      </div>"  
    end
   
end
