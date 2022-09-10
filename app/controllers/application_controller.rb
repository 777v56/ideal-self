class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admin_root_path
    else
        user_path(current_user.id)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
        root_path
    else
        new_admin_session_path
    end
  end

end
