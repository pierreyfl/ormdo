module ErrorRescues
  extend ActiveSupport::Concern

  included do

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: Api::Error.new('permission_error', exception.message), :status => :forbidden  }
      end
    end unless Rails.env.development?

    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.json { render json: Api::Error.new('record_not_found', exception.message), :status => :forbidden  }
      end
    end unless Rails.env.development?

    rescue_from Exception do |exception|
      Rails.logger.error "[DOW] Exception #{exception.class}: #{exception.message}"
      Rails.logger.error exception.backtrace
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: Api::Error.new('internal_server_error', exception.message, {:details=>exception.message, :backtrace => exception.backtrace}), :status => 500  }
      end
    end unless Rails.env.development?

  end

end