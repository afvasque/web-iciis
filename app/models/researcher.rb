class Researcher < ActiveRecord::Base
	has_and_belongs_to_many :projects
	validates_presence_of :name

	def self.search(search)
		researchers = Researcher.where('name ILIKE ? OR email ILIKE ?', "%#{search}%","%#{search}%").all
	end

end
