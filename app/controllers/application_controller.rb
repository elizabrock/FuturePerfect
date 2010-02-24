class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "iPhone"

  rescue_from(ActiveRecord::RecordNotFound) { |e| render_404 }

  protected

    def render_404
      respond_to do |format|
        format.html { render :template => 'shared/404', :status => "404 Not Found" }
        format.all  { render :nothing => true, :status => "404 Not Found"  }
      end
    end
end
