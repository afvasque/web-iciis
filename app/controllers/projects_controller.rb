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
    @assitant_researchers = @project.researchers.order("id asc").offset(1).all

    #Para mostrar los sitios de investigacion de cada proyecto
    @json = @project.study_sites.to_gmaps4rails
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.researchers.build
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

    @project = Project.new(project_params.except(:researchers_attributes))

    project_params[:researchers_attributes].each do |k,v|
      @project.researchers << Researcher.find(v['id'])
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
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
      @main_researcher = @project.researchers.first

      @researchers = Researcher.all

      if @project.researchers.count > 1
        @assitant_researchers = @project.researchers.drop(1)
      end
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
