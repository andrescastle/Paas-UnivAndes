class DepositosController < ApplicationController
  # GET /depositos
  # GET /depositos.json
   before_filter :define_path
   before_filter :authenticate_user!

  def define_path
    @public_path = File.join(Rails.root.to_s, 'public')
    @uploads_url = '/uploads'
    @upload_path = File.join(@public_path, @uploads_url)
    @current_url = params[:dir] || @uploads_url
    @current_path = File.join(@public_path, @current_url)+ '/*'
  end

 def update_deposito
   @deposito = Deposito.find(params[:id])
   render :layout => false
 end


  def index
    @depositos = Deposito.all.sort_by(&:created_at).reverse
    @tipo_depositos = TipoDeposito.all

    @deposito = Deposito.new

    respond_to do |format|
      format.html { render :layout => 'actividads' }
      format.json { render json: @depositos }
      end
  end

  # GET /depositos/1
  # GET /depositos/1.json
  def show
    @deposito = Deposito.find(params[:id])
    @tipo_archivos = TipoArchivo.all.uniq

     @archivo = Archivo.new
     
    respond_to do |format|
      format.html { render :layout => 'actividads' }
      format.json { render json: @deposito }
    end
  end

  # GET /depositos/new
  # GET /depositos/new.json
  def new
    @deposito = Deposito.new

    respond_to do |format|
      format.html { render :layout => 'actividads' }
      format.json { render json: @artefactos }
    end
  end

  # GET /depositos/1/edit
  def edit
    @deposito = Deposito.find(params[:id])
  end

  # POST /depositos
  # POST /depositos.json
  def create

      @deposito = Deposito.new(params[:deposito])
      @deposito.tipo_deposito_id=params[:tipo_deposito]
      @depositos = Deposito.all
      @tipo_depositos = TipoDeposito.all

      respond_to do |format|
        if @deposito.save
          format.html { render  action: "index", :layout => 'actividads' }
          format.json { render json: @deposito }
        else
          format.html { render action: "new", :layout => 'actividads' }
          format.json { render json: @deposito.errors, status: :unprocessable_entity }
        end
      end
    end

  # PUT /depositos/1
  # PUT /depositos/1.json
  def update
    @deposito = Deposito.find(params[:id])

    respond_to do |format|
      if @deposito.update_attributes(params[:deposito])
        format.html { redirect_to @deposito, notice: 'El deposito fue actualizado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deposito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /depositos/1
  # DELETE /depositos/1.json
  def destroy
    @deposito = Deposito.find(params[:id])
    @deposito.destroy

    respond_to do |format|
      format.html { redirect_to depositos_url }
      format.json { head :no_content }
    end
  end

   # ===  Accion existe
   # Determina si existe un proyecto de acuerdo a un nombre
   def existe
     @deposito = Deposito.find_by_nombre(params[:nombre])
     if(@deposito)
       render :text => "true"
     else
       render :text => "false"
     end
   end

   def get_tipo_depositos
     @data_for_select2 = TipoDeposito.all

     @c= params[:callback]

     @tam=@data_for_select2.length
     @i=1
     @data = @c+"({"+"\""
     @data_for_select2.each do |select|

       @data  = @data+select.id.to_s+"\""+":"+"\""+select.nombre+"\""

       if @tam!=@i
         @data=@data+","+"\""
       else
         @data=@data+"})"
       end
       @i=@i+1
     end

     render :text => @data
   end

  protected

  def secured_path?(file_path)
    return File.exist?(file_path) && ! File.dirname(file_path).index(@public_path).nil?
  end



  def slugify(value)
    return value.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s\
          .downcase\
          .gsub(/[']+/, '')\
          .gsub(/\W+/, ' ')\
          .strip\
          .gsub(' ', '-')
  end
end
