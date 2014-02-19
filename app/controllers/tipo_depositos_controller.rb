class TipoDepositosController < ApplicationController
  # GET /tipo_depositos
  # GET /tipo_depositos.json
  before_filter :authenticate_user!

  def index
    @tipo_depositos = TipoDeposito.all.sort_by(&:created_at).reverse
    @tipo_deposito = TipoDeposito.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipo_depositos }
    end
  end

  # GET /tipo_depositos/1
  # GET /tipo_depositos/1.json
  def show
    @tipo_deposito = TipoDeposito.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_deposito }
    end
  end

  # GET /tipo_depositos/new
  # GET /tipo_depositos/new.json
  def new
    @tipo_deposito = TipoDeposito.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_deposito }
    end
  end

  # GET /tipo_depositos/1/edit
  def edit
    @tipo_deposito = TipoDeposito.find(params[:id])
  end

  # POST /tipo_depositos
  # POST /tipo_depositos.json
  def create
    @tipo_deposito = TipoDeposito.new(params[:tipo_deposito])

    respond_to do |format|
      if @tipo_deposito.save
        format.html { redirect_to @tipo_deposito, notice: 'Tipo deposito was successfully created.' }
        format.json { render json: @tipo_deposito, status: :created, location: @tipo_deposito }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_deposito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_depositos/1
  # PUT /tipo_depositos/1.json
  def update
    @tipo_deposito = TipoDeposito.find(params[:id])

    respond_to do |format|
      if @tipo_deposito.update_attributes(params[:tipo_deposito])
        format.html { redirect_to @tipo_deposito, notice: 'Tipo deposito was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_deposito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_depositos/1
  # DELETE /tipo_depositos/1.json
  def destroy
    @tipo_deposito = TipoDeposito.find(params[:id])
    @tipo_deposito.destroy

    respond_to do |format|
      format.html { redirect_to tipo_depositos_url }
      format.json { head :no_content }
    end
  end
end
