 class ApplicationController < ActionController::Base
  protect_from_forgery
 # config.filter_parameters(:password)
   before_filter :set_i18n_locale_from_params
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
  before_filter :authenticate_user!
  # ...
  protected


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

# For all responses in this controller, return the CORS access control headers.

   def cors_set_access_control_headers
    # headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
     headers['Access-Control-Max-Age'] = "1728000"
   end

# If this is a preflight OPTIONS request, then short-circuit the
# request, return only the necessary headers and return an empty
# text/plain.

   def cors_preflight_check
     if request.method == :options
       headers['Access-Control-Allow-Origin'] = '*'
       headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
       headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
       headers['Access-Control-Max-Age'] = '1728000'
       render :text => '', :content_type => 'text/plain'
     end
   end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { :locale => I18n.locale }
    end
end

