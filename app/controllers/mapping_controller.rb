class MappingController < ApplicationController

   
  def search_in_projects
    get_search_projects

    render 'projects/index'
  end

  def search
    
    get_search_projects

    render :action => 'index'
  end

  def index
    @projects = []    
    get_markers(StudySite.all, false)
  end

  def get_markers(study_sites, is_search)
    @markers = Hash.new
    @json = study_sites.to_gmaps4rails do |study_site, marker|

      @markers[study_site.id] = marker

      if not is_search
        to_add = Project.all.limit(5).order("id desc")
        to_add.each do |p|
          if not @projects.include?(p)
            @projects << p
          end
        end
      end
      
      marker.infowindow render_to_string(:partial => "/projects/infowindow", 
        :locals => { :study_site => study_site, :projects => study_site.projects})
        marker.title "#{study_site.location}"
        marker.picture({:picture => '/assets/image3047.png',
                        :width => 50,
                        :height => 50})
        #Id para despues abrir infowindow desde el menu acordeon
        marker.json({ :id => study_site.id })
    end
  end

  def gmaps4rails_address
    #describe how to retrieve the address from your model
    "#{self.location}" 
  end

  def gmaps4rails_marker_picture
  {
    "picture" => 'Icono_localizador_r.png',
    "width" => 20,
    "height" => 20,
  }
  end

  private

      def get_search_projects
        @mapped = true
        @projects = nil
        @projects = Project.search(params[:search])
        @searched_study_site = StudySite.search(params[:search])
        @searched_researchers = Researcher.search(params[:search])

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

        @searched_researchers.each do |sr|
          p = Project.find_all_by_researcher_id(sr.id)
          p.each do |srp|
            if not @projects.include?(srp)
              srp.study_sites.each do |srpss|
                study_sites << srpss
              end
            end
          end
        end

        study_sites.each do |ss|
          ss.projects.each do |p|
            if not @projects.include?(p)
              @projects << p
            end
          end
        end

        get_markers(study_sites, true)

      end

      def admin_user
      redirect_to(signin_path) unless signed_in?
      # TheRole 1 es admin
      if signed_in?
        redirect_to(root_url) unless current_user.role_id == 1
      end
    end


end
