class ApplicationController < ActionController::Base
	def deletedependency 
		type=params[:type]
		id=params[:data]
		result=0
		case type
		when "resource"
		  if(AccountResourceMapping.where(resource_id: id).all[0] || ResourceSkillMapping.where(resource_id: id).all[0])
				result=1
			end
		when "unit"
		  if(OrganisationalUnit.find(id).accounts[0] || OrganisationalUnit.find(id).services[0])
				result=1
			end
		when "service"
		  if( AccountServiceMapping.where(service_id: id).all[0])
				result=1
		  end
		when "skill"
		  if( ResourceSkillMapping.where(skill_id: id).all[0])
				result=1
		  end
		when "role"
		  if( Resource.where(heirarchy_id: id).all[0])
				result=1
		  end
		when "account"
		  if( AccountResourceMapping.where(account_id: id).all[0])
				result=1
		  end
		else
		end
		render json:result
	end	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
   private
      def restrict_access
        api_key = ApiKey.find_by_access_token(request.headers["accessToken"])
        head :unauthorized unless api_key
      end
end
