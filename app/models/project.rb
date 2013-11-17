class Project < ActiveRecord::Base
	has_and_belongs_to_many :researchers
	belongs_to :researcher #investigador principal
	
	accepts_nested_attributes_for :researchers

	validate :require_one_researcher, :require_one_study_site
	has_and_belongs_to_many :study_sites
	accepts_nested_attributes_for :study_sites
	validates_length_of :title, :maximum => 200
	validate :word_count_summary
	validates_presence_of :title, :summary, :methodology



	private
	    def require_one_researcher
	      errors.add(:base, "Debe haber al menos un investigador responsable") if self.researchers.size < 1
	    end

	    def require_one_study_site
	      errors.add(:base, "Debe haber al menos un sitio de estudio") if self.study_sites.size < 1
	    end

	    def word_count_summary
	      errors.add(:base, "El resúmen debe tener máximo 250 palabras") if self.summary.split.size > 250
	    end
end
