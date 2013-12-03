class MappingController < ApplicationController

  def search
    @mapped = true
    @projects = Project.search(params[:search])
    @searched_study_site = StudySite.search(params[:search])
    
    study_sites = []
    @projects.each do |p|
      p.study_sites.each do |ss|
        study_sites << ss
      end
    end

    @searched_study_site.each do |sss|
      sss.projects.each do |psss|
        if not @projects.include?(psss)
          study_sites << sss
        end
      end
    end

    get_markers(study_sites)
    render 'index'
  end

  def index
    @projects = []    
    get_markers(StudySite.all)
  end

  def get_markers(study_sites)
    @markers = Hash.new
    @json = study_sites.to_gmaps4rails do |study_site, marker|

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

  private

      def admin_user
      redirect_to(signin_path) unless signed_in?
      # TheRole 1 es admin
      if signed_in?
        redirect_to(root_url) unless current_user.role_id == 1
      end
    end


end
