class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

end
