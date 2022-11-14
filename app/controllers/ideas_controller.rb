class IdeasController < ApplicationController
  before_action :set_idea, only: %i[show edit update destroy]

  # GET /ideas
  def index
    @ideas = Idea.order(created_at: :desc)
  end

  # GET /ideas/1
  def show
    @reviews = @idea.reviews.order(created_at: :desc)
    @review = Review.new
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
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_params
      params.require(:idea).permit(:title, :description)
    end
end
