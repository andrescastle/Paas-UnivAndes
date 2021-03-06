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

describe CompuertaPreDesicionsController do

  # This should return the minimal set of attributes required to create a valid
  # CompuertaPreDesicion. As you add validations to CompuertaPreDesicion, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "compuerta_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompuertaPreDesicionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all compuerta_pre_desicions as @compuerta_pre_desicions" do
      compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
      get :index, {}, valid_session
      assigns(:compuerta_pre_desicions).should eq([compuerta_pre_desicion])
    end
  end

  describe "GET show" do
    it "assigns the requested compuerta_pre_desicion as @compuerta_pre_desicion" do
      compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
      get :show, {:id => compuerta_pre_desicion.to_param}, valid_session
      assigns(:compuerta_pre_desicion).should eq(compuerta_pre_desicion)
    end
  end

  describe "GET new" do
    it "assigns a new compuerta_pre_desicion as @compuerta_pre_desicion" do
      get :new, {}, valid_session
      assigns(:compuerta_pre_desicion).should be_a_new(CompuertaPreDesicion)
    end
  end

  describe "GET edit" do
    it "assigns the requested compuerta_pre_desicion as @compuerta_pre_desicion" do
      compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
      get :edit, {:id => compuerta_pre_desicion.to_param}, valid_session
      assigns(:compuerta_pre_desicion).should eq(compuerta_pre_desicion)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CompuertaPreDesicion" do
        expect {
          post :create, {:compuerta_pre_desicion => valid_attributes}, valid_session
        }.to change(CompuertaPreDesicion, :count).by(1)
      end

      it "assigns a newly created compuerta_pre_desicion as @compuerta_pre_desicion" do
        post :create, {:compuerta_pre_desicion => valid_attributes}, valid_session
        assigns(:compuerta_pre_desicion).should be_a(CompuertaPreDesicion)
        assigns(:compuerta_pre_desicion).should be_persisted
      end

      it "redirects to the created compuerta_pre_desicion" do
        post :create, {:compuerta_pre_desicion => valid_attributes}, valid_session
        response.should redirect_to(CompuertaPreDesicion.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved compuerta_pre_desicion as @compuerta_pre_desicion" do
        # Trigger the behavior that occurs when invalid params are submitted
        CompuertaPreDesicion.any_instance.stub(:save).and_return(false)
        post :create, {:compuerta_pre_desicion => { "compuerta_id" => "invalid value" }}, valid_session
        assigns(:compuerta_pre_desicion).should be_a_new(CompuertaPreDesicion)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CompuertaPreDesicion.any_instance.stub(:save).and_return(false)
        post :create, {:compuerta_pre_desicion => { "compuerta_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested compuerta_pre_desicion" do
        compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
        # Assuming there are no other compuerta_pre_desicions in the database, this
        # specifies that the CompuertaPreDesicion created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CompuertaPreDesicion.any_instance.should_receive(:update_attributes).with({ "compuerta_id" => "1" })
        put :update, {:id => compuerta_pre_desicion.to_param, :compuerta_pre_desicion => { "compuerta_id" => "1" }}, valid_session
      end

      it "assigns the requested compuerta_pre_desicion as @compuerta_pre_desicion" do
        compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
        put :update, {:id => compuerta_pre_desicion.to_param, :compuerta_pre_desicion => valid_attributes}, valid_session
        assigns(:compuerta_pre_desicion).should eq(compuerta_pre_desicion)
      end

      it "redirects to the compuerta_pre_desicion" do
        compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
        put :update, {:id => compuerta_pre_desicion.to_param, :compuerta_pre_desicion => valid_attributes}, valid_session
        response.should redirect_to(compuerta_pre_desicion)
      end
    end

    describe "with invalid params" do
      it "assigns the compuerta_pre_desicion as @compuerta_pre_desicion" do
        compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CompuertaPreDesicion.any_instance.stub(:save).and_return(false)
        put :update, {:id => compuerta_pre_desicion.to_param, :compuerta_pre_desicion => { "compuerta_id" => "invalid value" }}, valid_session
        assigns(:compuerta_pre_desicion).should eq(compuerta_pre_desicion)
      end

      it "re-renders the 'edit' template" do
        compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CompuertaPreDesicion.any_instance.stub(:save).and_return(false)
        put :update, {:id => compuerta_pre_desicion.to_param, :compuerta_pre_desicion => { "compuerta_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested compuerta_pre_desicion" do
      compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
      expect {
        delete :destroy, {:id => compuerta_pre_desicion.to_param}, valid_session
      }.to change(CompuertaPreDesicion, :count).by(-1)
    end

    it "redirects to the compuerta_pre_desicions list" do
      compuerta_pre_desicion = CompuertaPreDesicion.create! valid_attributes
      delete :destroy, {:id => compuerta_pre_desicion.to_param}, valid_session
      response.should redirect_to(compuerta_pre_desicions_url)
    end
  end

end
