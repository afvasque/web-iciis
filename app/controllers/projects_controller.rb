class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :registered_user, only: [:edit, :new]


  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all    
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    #El primer investigador es el principal
    @assitant_researchers = @project.researchers

    #Para mostrar los sitios de investigacion de cada proyecto
    @json = @project.study_sites.to_gmaps4rails do |item, marker|


        marker.picture({:picture => '/assets/image3047.png',
                        :width => 50,
                        :height => 50})

      end


  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.researcher = Researcher.new
    @main_researcher = @project.researcher
    @project.study_sites.build

    set_init_params

  end

  # GET /projects/1/edit
  def edit
    @researchers = Researcher.all

    @json = @project.study_sites.to_gmaps4rails
  end

  # POST /projects
  # POST /projects.json
  def create

    @project = Project.new(project_params.except(:researchers_attributes, :researcher))

    @project.researcher = Researcher.find(project_params[:researcher]['id'])
    @main_researcher = @project.researcher

    if project_params[:researchers_attributes] != nil
        project_params[:researchers_attributes].each do |k,v|
          @project.researchers << Researcher.find(v['id'])
        end
    end


    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Los datos fueron actualizados correctamente' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        set_init_params
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update

    @project.update(project_params.except(:researchers_attributes, :researcher, :study_sites_attributes))
    
    @project.researcher = Researcher.find(project_params[:researcher]['id'])
    
    @project.researchers = Array.new

    if not project_params[:researchers_attributes].nil?
      project_params[:researchers_attributes].each do |k,v|
        r = Researcher.find(v['id'])
        #agregar los nuevos
        if not @project.researchers.include? r and v['_destroy'] != '1'
          @project.researchers << r
        end
      end
    end

    project_params[:study_sites_attributes].each do |k,v|
      r = StudySite.find(v['id'])
      if not @project.study_sites.include? r
        @project.study_sites << r
      end
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'El proyecto se guardó correctamente.' }
        format.json { head :no_content }
      else
        set_init_params
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy

    #No destruimos el sitio de estudio porque podria tener otros proyectos asociados
    @project.study_sites.each do |ss|
      ss.destroy
    end

    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
      @main_researcher = Researcher.find_by_id(@project.researcher_id)

      @researchers = Researcher.all

      @assitant_researchers = @project.researchers unless @project.researchers.empty?

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(
        :id,
        :title,
        :start_date, 
        :end_date, 
        :methodology, 
        :publication, 
        :summary,
        :research_field,
        {:researcher => [:id, :_destroy]},
        {:researcher_attributes => [:id, :_destroy]},
        {:researchers_attributes => [:id, :_destroy]},
        {:study_sites_attributes => [:id, :start_date, :end_date, :data_collection_method, :name, :description, 
          :latitude, :longitude, :location, :gmaps, :_destroy]}
        )
    end

    def registered_user
      redirect_to(signin_path) unless signed_in?
    end

    def set_init_params
      # Para renderear el select correctamente
      @researchers = Researcher.all unless params[:researchers]


      # Para que no se caiga gmaps, requiere un JSON con latlong
      @json = '[{"lng":"-70.6157","lat":"-33.4992"}]' unless params[:location]
    end

end
