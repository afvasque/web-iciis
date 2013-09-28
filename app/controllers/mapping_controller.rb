class MappingController < ApplicationController
  def index
  	projects = Project.all
  	
	@projects_latlong = []
    
    for p in projects
      @projects_latlong.push(p.latlong)
    end

  end
end
