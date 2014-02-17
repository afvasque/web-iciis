class User < ActiveRecord::Base
	include TheRoleUserModel
	has_secure_password
	validates :role_id, presence: true
	
	#Fuente: http://ruby.railstutorial.org/chapters/modeling-users#sec-adding_a_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    def get_nombre_rol
    	if self.role_id == 1
    		"Administrador"
    	else
    		"Editor"
    	end
    end

end
