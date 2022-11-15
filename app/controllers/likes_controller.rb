class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]

    def create
        @idea = Idea.find params[:idea_id]
        @like = Like.new(idea: @idea, user: current_user)

        if can?(:like, @idea)
            if @like.save
                flash.notice = "Idea liked"
            else
                flash.alert = @like.errors.full_messages.join(", ")
            end
        else
            flash.alert = "You cannot like this idea!"
        end
        redirect_to idea_path(@idea)
    end

    def destroy
       @like = current_user.likes.find params[:id]

       if !can?(:destroy, @like)
        flash[:warning] = "You cannot destroy a like you don't own!"
       elsif @like.destroy
        flash[:success] = "Idea Unliked"
       else
        flash[:warning] = "Couldn't Unlike the idea..."
       end
       redirect_to idea_path(@like.idea)
    end
end
