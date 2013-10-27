class StudySite < ActiveRecord::Base
	has_and_belongs_to_many :projects
  validates_presence_of :location
	acts_as_gmappable :check_process => false
	
	#  RETURNS LATLONG AS NEEDED FOR GMAPS API
  	def latlong
    	[self.latitude , self.longitude]
  	end

  	def gmaps4rails_address
  		self.location
	 end

    def gmaps4rails_sidebar
      #Podrian agregarse mas proyectos por sitio de estudio
      if self.projects[0]
       "<div class='sidebar_project'>
        <div id='sidebar_title'>
          #{self.projects[0].title} - #{self.location} <br />
        </div>
        #{self.projects[0].researchers[0].name}
        </div>"
      end  
    end
   
end
