class WikisController < ApplicationController

  def index
    @wikis = Wiki.not_private
  end

  def show
    @wiki = Wiki.friendly.find params[:id]
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.friendly.find params[:id]
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully"
    else
      flash[:error] = "Error creating wiki. Please try again"
      render :new
    end
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again"
      render :edit
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :content, :private)
  end

end
