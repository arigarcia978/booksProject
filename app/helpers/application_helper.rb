module ApplicationHelper

	def get_dropdown_title
		if user_signed_in?
			return current_user.email
		else 
			return 'Log in'
		end
	end

	def get_options_for_dropdown 
		if user_signed_in?
			return link_to 'Cerrar sesión', destroy_user_session_path, method: :delete
		else
			return link_to 'Iniciar sesión', new_user_session_path
		end
	end
end
