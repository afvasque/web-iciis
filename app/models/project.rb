class Project < ActiveRecord::Base
	has_and_belongs_to_many :researchers
	accepts_nested_attributes_for :researchers
	validate :require_one_researcher
	has_and_belongs_to_many :study_sites
	accepts_nested_attributes_for :study_sites
	validates_length_of :title, :maximum => 200
	validate :word_count_summary

	private
	    def require_one_researcher
	      errors.add(:base, "You must provide at least one researcher") if self.researchers.size < 1
	    end

	    def word_count_summary
	      errors.add(:base, "El resúmen debe tener máximo 250 palabras") if self.summary.split.size > 250
	    end
end
