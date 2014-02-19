#require "dropbox-sdk"
require "rest_client"

class DropboxController < ApplicationController
  before_filter :authenticate_user!

  layout 'actividads'

  require 'dropbox_sdk'
  # Get your app key and secret from the Dropbox developer website
  APP_KEY = 'u3ufaps11mkjwbk'
  APP_SECRET = 'qxyo5b3xqrio7lc'

# ACCESS_TYPE should be ':dropbox' or ':app_folder' as configured for your app
  ACCESS_TYPE = :dropbox


  def comprobar

    autenticar 'comprobar'

    if params[:oauth_token] then

      @old_deposito = Deposito.find_by_nombre(session[:dropbox_nombre])

      if(@old_deposito)
        @old_deposito.delete
      end


      @deposito = Deposito.new(
          :nombre => session[:dropbox_nombre],
          :descripcion => session[:dropbox_descripcion],
          :usuario => session[:dropbox_key],
          :contrasena => session[:dropbox_secret],
          :tipo_deposito_id => TipoDeposito.find_by_nombre("Dropbox").id,
	  :session => session[:dropbox_session]
      )
      @depositos = Deposito.all
      @tipo_depositos = TipoDeposito.all

      if @deposito.save
        redirect_to request.protocol + request.host_with_port + "/artefactos"
      else
        respond_to do |format|
          format.html { render action: "new", :layout => 'depositos' }
          format.json { render json: @deposito.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def autenticar action

    if not params[:oauth_token] then
      dbsession = DropboxSession.new(APP_KEY, APP_SECRET)

      session[:dropbox_session] = dbsession.serialize #serialize and save this DropboxSession
      session[:dropbox_nombre] = params[:deposito_nombre]
      session[:dropbox_descripcion] = params[:deposito_descripcion]

      File.open("dropbox_session.txt", 'wb') { |file| file.write(dbsession.serialize) }
      File.open("dropbox_nombre.txt", 'wb')  { |file| file.write(params[:deposito_nombre]) }
      File.open("dropbox_descripcion.txt", 'wb')  { |file| file.write(params[:deposito_descripcion]) }

      redirect_to dbsession.get_authorize_url url_for(:action => action)

    else
      # the user has returned from Dropbox
      file = File.open("dropbox_session.txt", "rb")
      dbsession = DropboxSession.deserialize(file.read)

      dbsession.get_access_token  #we've been authorized, so now request an access_token

      @key=  dbsession.get_access_token.key
      @secret=  dbsession.get_access_token.secret

      client = DropboxClient.new(dbsession, ACCESS_TYPE)
      info = client.account_info

      session[:dropbox_key] = URI::encode(@key)
      session[:dropbox_secret] = URI::encode(@secret)
      session[:dropbox_session] = dbsession.serialize #serialize and save this DropboxSession

      file = File.open("dropbox_nombre.txt", "rb")
      session[:dropbox_nombre] = file.read
      file = File.open("dropbox_descripcion.txt", "rb")
      session[:dropbox_descripcion] = file.read
      File.open("dropbox_session2.txt", 'wb') { |file| file.write(dbsession.serialize) }
    end
  end

  def use
    @deposito = Deposito.find(params[:id])
    @texto = params[:palabra_clave]

    dbsession = DropboxSession.deserialize(@deposito.session)

    client = DropboxClient.new(dbsession, ACCESS_TYPE)
    path = '/'
    file_metadata = client.metadata(path)

    @files=Array.new
    get_files path, file_metadata["contents"], @texto, client
    render json: @files
  end

  def get_files path, contents, texto, client

    contents.each do |content|
      if(content['is_dir'] == true)
      #  file_metadata = client.metadata(content['path'])
      #  get_files content['path'], file_metadata["contents"], texto, client
      else
        file=Hash.new
        file["name"] = content["path"].sub(path + '/', '')
        file["url"]  = content["path"]

        if(file["url"].match(/\.jpg$/) || file["url"].match(/\.gif$/) || file["url"].match(/\.png$/))
          file["url"]=file["url"] + "_iconoes_" + file["url"]
        elsif(file["url"].match(/\.pdf$/))
          file["url"]=file["url"] + "_iconoes_images/icon_pdf.jpg"
        elsif(file["url"].match(/\.mp3$/) || file["url"].match(/\.wma$/) || file["url"].match(/\.wav$/))
          file["url"]=file["url"] + "_iconoes_images/icon_audio.png"
        elsif(file["url"].match(/\.doc$/) || file["url"].match(/\.docx$/))
          file["url"]=file["url"] + "_iconoes_images/icon_word.jpg"
        elsif(file["url"].match(/\.xls$/) || file["url"].match(/\.xlsx$/))
          file["url"]=file["url"] + "_iconoes_images/icon_excel.jpg"
        elsif(file["url"].match(/\.ppt$/) || file["url"].match(/\.pptx$/))
          file["url"]=file["url"] + "_iconoes_images/icon_ppt.png"
        else
          file["url"]=file["url"] + "_iconoes_images/icon_any.png"
        end

        if(texto != nil) then
          if(file["name"].include?(texto))
            @files.push(file)
          end
        else
          @files.push(file)
        end
      end
    end
  end

  def import

# CREAMOS SESION QUE FUNCIONA
    @deposito = Deposito.find(params[:dropbox_id])
    @artefactos = params[:artefactos]
    dbsession = DropboxSession.deserialize(@deposito.session)

    if @artefactos != nil then

      _url = ENV['root_razuna_api'] + "/global/api2/folder.cfc?method=getfolders&api_key=" + ENV['admindavid_razuna_key']+"&__BDRETURNFORMAT=wddx"
      @wddx = WDDX.load(open(_url))

      @folders_found = @wddx.data.fields
      @folder_id = nil
      _i=0
      until _i >= @folders_found.count()  do
       _folder = @folders_found[_i]
        if(_folder[1] == @deposito.nombre)  then
          @folder_id = _folder[0]
          break
        end
           _i+= 1
      end

      if(@folder_id == nil) then
        _url = ENV['root_razuna_api'] + "/global/api2/folder.cfc?method=setfolder&api_key=" + ENV['admindavid_razuna_key']+"&folder_name="+ URI::encode(@deposito.nombre) + "&__BDRETURNFORMAT=wddx"
        @wddx = WDDX.load(open(_url))

        @folder_id = @wddx.data['folder_id']
      end

      client = DropboxClient.new(dbsession, ACCESS_TYPE)

      @artefactos.each do |artefacto|
        out = client.get_file artefacto 
        filename = File.basename(artefacto)
        open(filename, 'wb') {|f| f.puts out }

        RestClient.post(
              ENV['url_razuna'] + 'index.cfm',
              :filedata => File.new(filename),
              :destfolderid => @folder_id,
              :api_key => ENV['admindavid_razuna_key'],
              :fa => "c.apiupload"
        )
      end
    redirect_to request.protocol + request.host_with_port + "/depositos"
    end 
 end


end



