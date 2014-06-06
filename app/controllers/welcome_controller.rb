class WelcomeController < ApplicationController
  layout 'application'

  def home
    redirect_to wikis_path if current_user
  end
end
