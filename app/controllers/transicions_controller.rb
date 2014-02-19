class TransicionsController < ApplicationController
  # GET /transicions
  # GET /transicions.json
  before_filter :authenticate_user!

  def index
    @transicions = Transicion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transicions }
    end
  end

  # GET /transicions/1
  # GET /transicions/1.json
  def show
    @transicion = Transicion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transicion }
    end
  end

  # GET /transicions/new
  # GET /transicions/new.json
  def new
    @transicion = Transicion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transicion }
    end
  end

  # GET /transicions/1/edit
  def edit
    @transicion = Transicion.find(params[:id])
  end

  # POST /transicions
  # POST /transicions.json
  def create
    @transicion = Transicion.new(params[:transicion])

    respond_to do |format|
      if @transicion.save
        format.html { redirect_to @transicion, notice: 'Transicion was successfully created.' }
        format.json { render json: @transicion, status: :created, location: @transicion }
      else
        format.html { render action: "new" }
        format.json { render json: @transicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transicions/1
  # PUT /transicions/1.json
  def update
    @transicion = Transicion.find(params[:id])

    respond_to do |format|
      if @transicion.update_attributes(params[:transicion])
        format.html { redirect_to @transicion, notice: 'Transicion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transicions/1
  # DELETE /transicions/1.json
  def destroy
    @transicion = Transicion.find(params[:id])
    @transicion.destroy

    respond_to do |format|
      format.html { redirect_to transicions_url }
      format.json { head :no_content }
    end
  end
end
