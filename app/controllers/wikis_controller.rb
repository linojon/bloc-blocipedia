class WikisController < ApplicationController

  before_action :find_and_authorize_wiki, except: [:index, :new, :create]

  def index
    @wikis = Wiki.not_private
    @wikis = (@wikis + current_user.wikis).uniq if current_user
  end

  def show
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
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
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again"
      render :edit
    end
  end

  def collaborators
    @collaborators = @wiki.collaborators    
    @users = User.all
  end

  def update_collaborators
    @wiki.replace_collaborators params[:collaborators]
    redirect_to collaborators_wiki_path(@wiki), notice: 'Collaborators updated'
  end

  private

  def find_and_authorize_wiki
    @wiki = Wiki.friendly.find params[:id]
    authorize @wiki
  end

  def wiki_params
    params.require(:wiki).permit(:title, :content, :private)
  end

end
