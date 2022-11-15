class ReviewsController < ApplicationController
    before_action :set_review, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:destroy]
  
    # idea /reviews
    def create
      @idea = Idea.find(params[:idea_id])
      @review = Review.new(review_params)
      @review.idea = @idea
      @review.user = current_user
  
      if @review.save
        flash[:success]="Review added"
      else
        @reviews = @idea.reviews.order(created_at: :desc)
        flash[:alert] = @review.errors.full_messages.join(", ")
  
      end
      redirect_to @idea
    end
  
    # DELETE /reviews/1
    def destroy
      @review = Review.find(params[:id])
      @idea = Idea.find(params[:idea_id])
      if can?(:crud, @review)
        @review.destroy
        redirect_to idea_path
        flash[:success] = 'Answer deleted'
      else
        redirect_to root_path, alert: 'Not Authorized to change answer!'
      end
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:description)
    end
  
    def authorize_user!
      redirect_to root_path, alert: 'Not Authorized!' unless can?(:crud, @review)
    end
  end
