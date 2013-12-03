class StudySite < ActiveRecord::Base
	has_and_belongs_to_many :projects
  validates_presence_of :location
	acts_as_gmappable :check_process => false

  def self.search(search)
        ss = StudySite.where('name LIKE ? OR location LIKE ?', "%#{search}%","%#{search}%").all
  end
	
	#  RETURNS LATLONG AS NEEDED FOR GMAPS API
  	def latlong
    	[self.latitude , self.longitude]
  	end

  	def gmaps4rails_address
  		self.location
	 end

    def gmaps4rails_sidebar
      #Podrian agregarse mas proyectos por sitio de estudio
      result = "";
      if self.projects[0]
       result = result + "<div class='sidebar_project'>
        <div id='sidebar_title' data-dropdown='drop1'>
          #{self.projects[0].title} - #{self.location} <br />"
          if self.projects[0].researchers[0]
              result = result + "</div>
            #{self.projects[0].researchers[0].name}
            </div>"
          end

      end  
    end
   
end
