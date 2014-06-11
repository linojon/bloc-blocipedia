class WikisController < ApplicationController

  def index
    @wikis = Wiki.not_private
    @wikis = (@wikis + current_user.wikis).uniq if current_user
  end

  def show
    @wiki = Wiki.friendly.find params[:id]
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.friendly.find params[:id]
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully"
    else
      flash[:error] = "Error creating wiki. Please try again"
      render :new
    end
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again"
      render :edit
    end
  end

  def collaborators
    @wiki = Wiki.friendly.find params[:id]
    authorize @wiki
    @collaborators = @wiki.collaborators    
    @users = User.all
  end

  def update_collaborators
    @wiki = Wiki.friendly.find params[:id]
    authorize @wiki
    @wiki.replace_collaborators params[:collaborators]
    redirect_to collaborators_wiki_path(@wiki), notice: 'Collaborators updated'
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :content, :private)
  end

end
