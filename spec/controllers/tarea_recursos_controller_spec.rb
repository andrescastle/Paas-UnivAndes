require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TareaRecursosController do

  # This should return the minimal set of attributes required to create a valid
  # TareaRecurso. As you add validations to TareaRecurso, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TareaRecursosController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all tarea_recursos as @tarea_recursos" do
      tarea_recurso = TareaRecurso.create! valid_attributes
      get :index, {}, valid_session
      assigns(:tarea_recursos).should eq([tarea_recurso])
    end
  end

  describe "GET show" do
    it "assigns the requested tarea_recurso as @tarea_recurso" do
      tarea_recurso = TareaRecurso.create! valid_attributes
      get :show, {:id => tarea_recurso.to_param}, valid_session
      assigns(:tarea_recurso).should eq(tarea_recurso)
    end
  end

  describe "GET new" do
    it "assigns a new tarea_recurso as @tarea_recurso" do
      get :new, {}, valid_session
      assigns(:tarea_recurso).should be_a_new(TareaRecurso)
    end
  end

  describe "GET edit" do
    it "assigns the requested tarea_recurso as @tarea_recurso" do
      tarea_recurso = TareaRecurso.create! valid_attributes
      get :edit, {:id => tarea_recurso.to_param}, valid_session
      assigns(:tarea_recurso).should eq(tarea_recurso)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TareaRecurso" do
        expect {
          post :create, {:tarea_recurso => valid_attributes}, valid_session
        }.to change(TareaRecurso, :count).by(1)
      end

      it "assigns a newly created tarea_recurso as @tarea_recurso" do
        post :create, {:tarea_recurso => valid_attributes}, valid_session
        assigns(:tarea_recurso).should be_a(TareaRecurso)
        assigns(:tarea_recurso).should be_persisted
      end

      it "redirects to the created tarea_recurso" do
        post :create, {:tarea_recurso => valid_attributes}, valid_session
        response.should redirect_to(TareaRecurso.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tarea_recurso as @tarea_recurso" do
        # Trigger the behavior that occurs when invalid params are submitted
        TareaRecurso.any_instance.stub(:save).and_return(false)
        post :create, {:tarea_recurso => {}}, valid_session
        assigns(:tarea_recurso).should be_a_new(TareaRecurso)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TareaRecurso.any_instance.stub(:save).and_return(false)
        post :create, {:tarea_recurso => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tarea_recurso" do
        tarea_recurso = TareaRecurso.create! valid_attributes
        # Assuming there are no other tarea_recursos in the database, this
        # specifies that the TareaRecurso created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TareaRecurso.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => tarea_recurso.to_param, :tarea_recurso => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested tarea_recurso as @tarea_recurso" do
        tarea_recurso = TareaRecurso.create! valid_attributes
        put :update, {:id => tarea_recurso.to_param, :tarea_recurso => valid_attributes}, valid_session
        assigns(:tarea_recurso).should eq(tarea_recurso)
      end

      it "redirects to the tarea_recurso" do
        tarea_recurso = TareaRecurso.create! valid_attributes
        put :update, {:id => tarea_recurso.to_param, :tarea_recurso => valid_attributes}, valid_session
        response.should redirect_to(tarea_recurso)
      end
    end

    describe "with invalid params" do
      it "assigns the tarea_recurso as @tarea_recurso" do
        tarea_recurso = TareaRecurso.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TareaRecurso.any_instance.stub(:save).and_return(false)
        put :update, {:id => tarea_recurso.to_param, :tarea_recurso => {}}, valid_session
        assigns(:tarea_recurso).should eq(tarea_recurso)
      end

      it "re-renders the 'edit' template" do
        tarea_recurso = TareaRecurso.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TareaRecurso.any_instance.stub(:save).and_return(false)
        put :update, {:id => tarea_recurso.to_param, :tarea_recurso => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tarea_recurso" do
      tarea_recurso = TareaRecurso.create! valid_attributes
      expect {
        delete :destroy, {:id => tarea_recurso.to_param}, valid_session
      }.to change(TareaRecurso, :count).by(-1)
    end

    it "redirects to the tarea_recursos list" do
      tarea_recurso = TareaRecurso.create! valid_attributes
      delete :destroy, {:id => tarea_recurso.to_param}, valid_session
      response.should redirect_to(tarea_recursos_url)
    end
  end

end
