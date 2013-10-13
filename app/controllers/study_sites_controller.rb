class StudySitesController < ApplicationController
  before_action :set_study_site, only: [:show, :edit, :update, :destroy]

  # GET /study_sites
  # GET /study_sites.json
  def index
    @study_sites = StudySite.all
  end

  # GET /study_sites/1
  # GET /study_sites/1.json
  def show
  end

  # GET /study_sites/new
  def new
    @study_site = StudySite.new
  end

  # GET /study_sites/1/edit
  def edit
  end

  # POST /study_sites
  # POST /study_sites.json
  def create
    @study_site = StudySite.new(study_site_params)

    respond_to do |format|
      if @study_site.save
        format.html { redirect_to @study_site, notice: 'Study site was successfully created.' }
        format.json { render action: 'show', status: :created, location: @study_site }
      else
        format.html { render action: 'new' }
        format.json { render json: @study_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /study_sites/1
  # PATCH/PUT /study_sites/1.json
  def update
    respond_to do |format|
      if @study_site.update(study_site_params)
        format.html { redirect_to @study_site, notice: 'Study site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @study_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_sites/1
  # DELETE /study_sites/1.json
  def destroy
    @study_site.destroy
    respond_to do |format|
      format.html { redirect_to study_sites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_site
      @study_site = StudySite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_site_params
      params.require(:study_site).permit(:start_date, :end_date, :data_collection_method, :name, :description, :latitude, :longitude, :location)
    end
end
