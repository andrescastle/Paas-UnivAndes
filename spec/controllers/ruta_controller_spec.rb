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

describe RutaController do

  # This should return the minimal set of attributes required to create a valid
  # Rutum. As you add validations to Rutum, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RutaController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all ruta as @ruta" do
      rutum = Rutum.create! valid_attributes
      get :index, {}, valid_session
      assigns(:ruta).should eq([rutum])
    end
  end

  describe "GET show" do
    it "assigns the requested rutum as @rutum" do
      rutum = Rutum.create! valid_attributes
      get :show, {:id => rutum.to_param}, valid_session
      assigns(:rutum).should eq(rutum)
    end
  end

  describe "GET new" do
    it "assigns a new rutum as @rutum" do
      get :new, {}, valid_session
      assigns(:rutum).should be_a_new(Rutum)
    end
  end

  describe "GET edit" do
    it "assigns the requested rutum as @rutum" do
      rutum = Rutum.create! valid_attributes
      get :edit, {:id => rutum.to_param}, valid_session
      assigns(:rutum).should eq(rutum)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Rutum" do
        expect {
          post :create, {:rutum => valid_attributes}, valid_session
        }.to change(Rutum, :count).by(1)
      end

      it "assigns a newly created rutum as @rutum" do
        post :create, {:rutum => valid_attributes}, valid_session
        assigns(:rutum).should be_a(Rutum)
        assigns(:rutum).should be_persisted
      end

      it "redirects to the created rutum" do
        post :create, {:rutum => valid_attributes}, valid_session
        response.should redirect_to(Rutum.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rutum as @rutum" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rutum.any_instance.stub(:save).and_return(false)
        post :create, {:rutum => {}}, valid_session
        assigns(:rutum).should be_a_new(Rutum)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rutum.any_instance.stub(:save).and_return(false)
        post :create, {:rutum => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rutum" do
        rutum = Rutum.create! valid_attributes
        # Assuming there are no other ruta in the database, this
        # specifies that the Rutum created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Rutum.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => rutum.to_param, :rutum => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested rutum as @rutum" do
        rutum = Rutum.create! valid_attributes
        put :update, {:id => rutum.to_param, :rutum => valid_attributes}, valid_session
        assigns(:rutum).should eq(rutum)
      end

      it "redirects to the rutum" do
        rutum = Rutum.create! valid_attributes
        put :update, {:id => rutum.to_param, :rutum => valid_attributes}, valid_session
        response.should redirect_to(rutum)
      end
    end

    describe "with invalid params" do
      it "assigns the rutum as @rutum" do
        rutum = Rutum.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rutum.any_instance.stub(:save).and_return(false)
        put :update, {:id => rutum.to_param, :rutum => {}}, valid_session
        assigns(:rutum).should eq(rutum)
      end

      it "re-renders the 'edit' template" do
        rutum = Rutum.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rutum.any_instance.stub(:save).and_return(false)
        put :update, {:id => rutum.to_param, :rutum => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested rutum" do
      rutum = Rutum.create! valid_attributes
      expect {
        delete :destroy, {:id => rutum.to_param}, valid_session
      }.to change(Rutum, :count).by(-1)
    end

    it "redirects to the ruta list" do
      rutum = Rutum.create! valid_attributes
      delete :destroy, {:id => rutum.to_param}, valid_session
      response.should redirect_to(ruta_url)
    end
  end

end
