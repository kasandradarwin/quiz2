require 'rails_helper'

user = FactoryBot.create(:user)

RSpec.describe IdeasController, type: :controller do
    describe "#new" do

    context "with signed in user" do
        before do
          session[:user_id] = FactoryBot.create(:user).id
        end
        it "requires a render of a new template" do

          get(:new)

          expect(response).to(render_template(:new))
    
        end

    context "without signed in user" do
        it "should redirect to the sign in page" do
          get(:new)
          expect(response).to redirect_to(new_session_path)
        end
      end

      it "requires setting an instance variable with a new idea" do
     
        get(:new)
        expect(assigns(:idea)).to(be_a_new(Idea))
    
      end
    end

#create tests:

    describe "#create" do
    def valid_request
      post(:create, params: {
        idea: FactoryBot.attributes_for(:idea)
      })
    end

    context "with signed in user" do

      before do
        session[:user_id] = FactoryBot.create(:user).id
      end
      
      context "with valid parameters" do
        it "requires a new creation of an idea in the database" do
          count_before = Idea.count 
          valid_request
    
          # THEN
          count_after = Idea.count
          expect(count_after).to(eq(count_before + 1))
        end
        it "requires a redirect to the show page for the new idea" do

          valid_request
          idea_post = Idea.last
          expect(response).to(redirect_to(idea))  
    
        end
      end
  
      context "with invalid parameters" do
        def invalid_request
          post(:create, params: {
            idea: FactoryBot.attributes_for(:idea, title: nil)
          })
        end
  
        it "requires that the database does not save the new record of idea" do

          count_before = Idea.count

          invalid_request

          count_after = Idea.count
          expect(count_after).to(eq(count_before))  
        end
        it "requires a render of the new idea template" do
          invalid_request
          expect(response).to(render_template(:new))  
        end
      end
    end
    
  end




   





    describe "#create" do

      def valid_request
        idea(:create, params: {
            idea: FactoryBot.attributes_for(:idea)
        })
      end

        it "requires a new creation of an idea in the db" do
        
        end

        it "requires redirect to the show page for the new idea"

        end

        it "requires user to be signed in"
      end


end
