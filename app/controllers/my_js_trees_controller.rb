class MyJsTreesController < ApplicationController
  # GET /my_js_trees
  # GET /my_js_trees.json
  before_filter :authenticate_user!

  def jstree
     @my_js_tree_id= MyJsTree.last.id+1
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def jstreedata

    @id_plantilla=params[:plantilla_id]
    @id_proceso=params[:proceso_id]

    if(@id_plantilla)
     @all_ous =  MyJsTree.find_all_by_plantilla_id(params[:plantilla_id], :order =>"parent_id,position")#@plantilla.id)#params[:id_plantilla])# .find_all_by_plantilla_id(params[:id_plantilla])
    else
      @all_ous =  MyJsTree.find_all_by_proceso_id(params[:proceso_id])#@plantilla.id)#params[:id_plantilla])# .find_all_by_plantilla_id(params[:id_plantilla])
    end

   #  @my_js_tree_id= MyJsTree.last.id+1
    #@all_ous = MyJsTree.where("plantilla_id = ?",params[:id_plantilla])
    respond_to do |format|
       format.json
    end
  end

  def index
    @my_js_trees = MyJsTree.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @my_js_trees }
    end
  end

  # GET /my_js_trees/1
  # GET /my_js_trees/1.json
  def show
    @my_js_tree = MyJsTree.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @my_js_tree }
    end
  end

  # GET /my_js_trees/new
  # GET /my_js_trees/new.json
  def new
    @my_js_tree = MyJsTree.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @my_js_tree }
    end
  end

  # GET /my_js_trees/1/edit
  def edit
    @my_js_tree = MyJsTree.find(params[:id])
  end

  # POST /my_js_trees
  # POST /my_js_trees.json
  def create
    @my_js_tree = MyJsTree.new(params[:my_js_tree])

    respond_to do |format|
      if @my_js_tree.save
        format.html { redirect_to @my_js_tree, notice: 'My js tree was successfully created.' }
        format.json { render json: @my_js_tree, status: :created, location: @my_js_tree }
      else
        format.html { render action: "new" }
        format.json { render json: @my_js_tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /my_js_trees/1
  # PUT /my_js_trees/1.json
  def update
    @my_js_tree = MyJsTree.find(params[:id])

    respond_to do |format|
      if @my_js_tree.update_attributes(params[:my_js_tree])
        format.html { redirect_to @my_js_tree, notice: 'My js tree was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @my_js_tree.errors, status: :unprocessable_entity }
      end
    end
  end

   def updateParent
     #el que movi
     @my_js_tree = MyJsTree.find(params[:nodo_id])


     @my_js_tree.parent_id=params[:parentID]

     #el que quedo debajo
     begin
       @my_js_tree1 = MyJsTree.find(params[:nextID])

       @my_js_tree.position=@my_js_tree1.position

       #  @my_js_tree1.position=@my_js_tree.position+1


       # respond_to do |format|
       if @my_js_tree.save #update_attribute("parent_id", params[:parentID]) #update_attributes(params[:actividad])
         if @my_js_tree1.save
           @ramas=MyJsTree.find_all_by_parent_id(@my_js_tree.parent_id)
           @ramas.each do |rama|
             if(rama.position>=@my_js_tree.position)
               if(rama.id==@my_js_tree.id)
                 {}
               else
                 rama.update_attribute("position",rama.position+1)
               end
             end
           end

           render :text => "true";
         else
           render :text => "false"
         end
       else
         render :text => "false"
       end

     rescue
       @ramas=MyJsTree.find_all_by_parent_id(@my_js_tree.parent_id,:order =>"position")
       @pos=-1;
       @ramas.each do |rama|
         @pos=rama.position
       end
       @my_js_tree.update_attribute("position",@pos+1)
       if @my_js_tree1.save
         render :text => "true";
       else
         render :text => "false";
       end
     end

   # end
  end

  # DELETE /my_js_trees/1
  # DELETE /my_js_trees/1.json
  def destroy
    @my_js_tree = MyJsTree.find(params[:id])
    @my_js_tree.destroy

    respond_to do |format|
      format.html { redirect_to my_js_trees_url }
      format.json { head :no_content }
    end
  end




  def getTipoRecurso

    @data_for_select2 = Proyecto.find(params[:id]).usuarios

    @hash = Hash.new
    Proyecto.find(params[:id]).usuarios.each do |usuario|
      @hash[usuario.tipo_recurso_id] = Array.new
    end

    @hash.inject([]) { |result,h| result << h unless result.include?(h); result }
    @array = Array.new

    @hash.keys.each do |tipo_recurso_id|
      @tipoR=  TipoRecurso.find_by_id(tipo_recurso_id)
      @array.push( @tipoR)
    end


    @data_for_select2=  @array

    #render :json =>"{"+@comilla+"1"+@comilla+":"+@comilla+"Alto Orinoco"+@comilla+","+@comilla+"2"+@comilla+":"+@comilla+"Huachamacare"+@comilla+"}"
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
    #3143216669

    #  @data=@c+"({"+"\""+"1"+"\""+":"+"\""+"Hola"+"\""+","+"\""+"3"+"\""+":"+"\""+"Chao"+"\""+"})"
    #@data=TipoPlantilla.all.map{|p| [p.id.to_s,p.id.to_s+":"+p.nombre] }
    #render :json => @data_for_select2.map{|c| [c.id.to_s(), c.nombre] }
    render :text => @data

  end



  def getdata



    @comilla='"';
    @data_for_select1 = params[:tipo_recurso]

    @data_for_select2 =  Proyecto.find(params[:id]).usuarios.where(:tipo_recurso_id => @data_for_select1).all
    @procesos=  Proyecto.find(params[:id]).procesos

    @c= params[:callback]

    @tam=@data_for_select2.length
    @i=1
    if @tam!=0

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

    else
      @data=""
    end

    render :json => @data

  end

  def jstreedataProyecto

    @id_proyecto=params[:plantilla_id]
    @id_proceso=params[:proceso_id]

    if(@id_plantilla)
      @all_ous =  MyJsTree.find_all_by_plantilla_id(params[:plantilla_id], :order =>"parent_id,position")#@plantilla.id)#params[:id_plantilla])# .find_all_by_plantilla_id(params[:id_plantilla])
    else
      @all_ous =  MyJsTree.find_all_by_proceso_id(params[:proceso_id])#@plantilla.id)#params[:id_plantilla])# .find_all_by_plantilla_id(params[:id_plantilla])
    end

    #  @my_js_tree_id= MyJsTree.last.id+1
    #@all_ous = MyJsTree.where("plantilla_id = ?",params[:id_plantilla])
    respond_to do |format|
      format.json
    end
  end

end
