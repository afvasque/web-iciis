class MappingController < ApplicationController
  def index	
    @json = StudySite.distinct.to_gmaps4rails do |study_site, marker|
      marker.infowindow render_to_string(:partial => "/projects/infowindow", :locals => { :study_site => study_site, :projects => study_site.projects})
        marker.title "#{study_site.location}"
        #Eventualmente cambiar por el nombre del proyecto
        marker.json({ :sidebar => study_site.location })
        marker.picture({:width => 32,
                        :height => 32})
    end
  end

  def gmaps4rails_address
    #describe how to retrieve the address from your model
    "#{self.location}" 
  end

  def gmaps4rails_sidebar
   
  end

end
