class Project < ActiveRecord::Base
	has_and_belongs_to_many :researchers
	accepts_nested_attributes_for :researchers
	
  has_and_belongs_to_many :study_sites
  accepts_nested_attributes_for :study_sites



end
