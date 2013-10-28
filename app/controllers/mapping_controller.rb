class MappingController < ApplicationController
  def index	
    @projects = []
    @markers = Hash.new
    @json = StudySite.all.to_gmaps4rails do |study_site, marker|

      @markers[study_site.id] = marker

      study_site.projects.each do |p|
        if not @projects.include?(p)
          @projects << p

        end
      end
      
      marker.infowindow render_to_string(:partial => "/projects/infowindow", 
        :locals => { :study_site => study_site, :projects => study_site.projects})
        marker.title "#{study_site.location}"
        marker.picture({:width => 32,
                        :height => 32})
        #Id para despues abrir infowindow desde el menu acordeon
        marker.json({ :id => study_site.id })
    end
  end

  def gmaps4rails_address
    #describe how to retrieve the address from your model
    "#{self.location}" 
  end



end
