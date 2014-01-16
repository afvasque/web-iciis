class Project < ActiveRecord::Base

	RESEARCH_FIELD = {politicas: 'Políticas públicas', desarrollo: 'Desarrollo y medioambiente', 
		patrimonio: 'Patrimonio cultural', subjetividades: 'Subjetividades y conflicto'}
	has_and_belongs_to_many :researchers
	belongs_to :researcher #investigador principal
	
	accepts_nested_attributes_for :researchers

	validate :require_one_researcher, :require_one_study_site
	has_and_belongs_to_many :study_sites
	accepts_nested_attributes_for :study_sites
	validates_length_of :title, :maximum => 200
	validate :word_count_summary
	validates_presence_of :title, :summary, :methodology, :research_field
	validates :research_field, inclusion: {in: RESEARCH_FIELD.values}


	def self.search(search)
		projects = Project.where('title ILIKE ? OR methodology ILIKE ? OR summary ILIKE ? OR publication ILIKE ?', "%#{search}%","%#{search}%", "%#{search}%","%#{search}%").to_a
		
	end

	private
	    def require_one_researcher
	      errors.add(:base, "Debe haber al menos un investigador responsable") if self.researcher.nil?
	    end

	    def require_one_study_site
	      errors.add(:base, "Debe haber al menos un sitio de estudio") if self.study_sites.size < 1
	    end

	    def word_count_summary
	      errors.add(:base, "El resúmen debe tener máximo 250 palabras") if self.summary.split.size > 250
	    end


end
