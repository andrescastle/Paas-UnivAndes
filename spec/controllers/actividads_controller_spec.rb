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

describe ActividadsController do

  # This should return the minimal set of attributes required to create a valid
  # Actividad. As you add validations to Actividad, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ActividadsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all actividads as @actividads" do
      actividad = Actividad.create! valid_attributes
      get :index, {}, valid_session
      assigns(:actividads).should eq([actividad])
    end
  end

  describe "GET show" do
    it "assigns the requested actividad as @actividad" do
      actividad = Actividad.create! valid_attributes
      get :show, {:id => actividad.to_param}, valid_session
      assigns(:actividad).should eq(actividad)
    end
  end

  describe "GET new" do
    it "assigns a new actividad as @actividad" do
      get :new, {}, valid_session
      assigns(:actividad).should be_a_new(Actividad)
    end
  end

  describe "GET edit" do
    it "assigns the requested actividad as @actividad" do
      actividad = Actividad.create! valid_attributes
      get :edit, {:id => actividad.to_param}, valid_session
      assigns(:actividad).should eq(actividad)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Actividad" do
        expect {
          post :create, {:actividad => valid_attributes}, valid_session
        }.to change(Actividad, :count).by(1)
      end

      it "assigns a newly created actividad as @actividad" do
        post :create, {:actividad => valid_attributes}, valid_session
        assigns(:actividad).should be_a(Actividad)
        assigns(:actividad).should be_persisted
      end

      it "redirects to the created actividad" do
        post :create, {:actividad => valid_attributes}, valid_session
        response.should redirect_to(Actividad.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved actividad as @actividad" do
        # Trigger the behavior that occurs when invalid params are submitted
        Actividad.any_instance.stub(:save).and_return(false)
        post :create, {:actividad => {}}, valid_session
        assigns(:actividad).should be_a_new(Actividad)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Actividad.any_instance.stub(:save).and_return(false)
        post :create, {:actividad => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested actividad" do
        actividad = Actividad.create! valid_attributes
        # Assuming there are no other actividads in the database, this
        # specifies that the Actividad created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Actividad.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => actividad.to_param, :actividad => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested actividad as @actividad" do
        actividad = Actividad.create! valid_attributes
        put :update, {:id => actividad.to_param, :actividad => valid_attributes}, valid_session
        assigns(:actividad).should eq(actividad)
      end

      it "redirects to the actividad" do
        actividad = Actividad.create! valid_attributes
        put :update, {:id => actividad.to_param, :actividad => valid_attributes}, valid_session
        response.should redirect_to(actividad)
      end
    end

    describe "with invalid params" do
      it "assigns the actividad as @actividad" do
        actividad = Actividad.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Actividad.any_instance.stub(:save).and_return(false)
        put :update, {:id => actividad.to_param, :actividad => {}}, valid_session
        assigns(:actividad).should eq(actividad)
      end

      it "re-renders the 'edit' template" do
        actividad = Actividad.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Actividad.any_instance.stub(:save).and_return(false)
        put :update, {:id => actividad.to_param, :actividad => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested actividad" do
      actividad = Actividad.create! valid_attributes
      expect {
        delete :destroy, {:id => actividad.to_param}, valid_session
      }.to change(Actividad, :count).by(-1)
    end

    it "redirects to the actividads list" do
      actividad = Actividad.create! valid_attributes
      delete :destroy, {:id => actividad.to_param}, valid_session
      response.should redirect_to(actividads_url)
    end
  end

end
