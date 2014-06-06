class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find params[:id]
    raise "not authorized" if @wiki.private? && !@wiki.collaborators.include?(current_user)
  end

end
