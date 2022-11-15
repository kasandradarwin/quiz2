class IdeasController < ApplicationController
  before_action :find_idea, only: [:edit, :update, :show, :destroy]
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show ]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /ideas
  def index
    @ideas = Idea.order(created_at: :desc)
  end

  # GET /ideas/1
  def show
     @reviews = @idea.reviews.order(created_at: :desc)
    @review = Review.new
    @user = current_user
    @like = @idea.likes.find_by(user: current_user)
    # raise
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user

    respond_to do
      if @idea.save
        redirect_to idea_url(@idea), notice: "Idea was successfully created." 
      else
        render :new, status: :unprocessable_entity 
      end
    end
  end

  # PATCH/PUT /ideas/1
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to idea_url(@idea), notice: "Idea was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  def destroy
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url, notice: "Idea was successfully destroyed." }
    end
  end

  private

    def find_idea
      @idea = Idea.find params[:id]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_params
      params.require(:idea).permit(:title, :description)
    end
end
