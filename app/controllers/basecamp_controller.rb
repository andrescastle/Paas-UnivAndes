require "basecamp"
require "faraday"
require "net/https"
require "uri"


#require "curl"
class BasecampController < ApplicationController

  before_filter :authenticate_user!

  layout 'actividads'

  #DAVID
  #Product Access:Basecamp
  #Client ID:37979dcfe41150061a6b28d36c9df4062bd2b941
  #Client Secret:a728d5950fd3023e8d011a1e25fbb1a539968b55
  #Redirect URI: http://pruebasdavid.virtual.uniandes.edu.co/

  def get_proyectos
    @deposito = Deposito.find(params[:id])
    @basecamp = Basecamp.establish_connection!(@deposito.cuenta, @deposito.usuario, @deposito.contrasena, true)
    @projects = Array.new
    @c= params[:callback]

    begin
      @data_for_select = Basecamp::Project.find(:all)

      @tam=@data_for_select.length
      @i=1
      @data = @c+"({"+"\""
      @data_for_select.each do |select|
        @data  = @data+select.id.to_s+"\""+":"+"\""+select.name+"\""
        if @tam!=@i
          @data=@data+","+"\""
        else
          @data=@data+"})"
        end
        @i=@i+1
      end

    rescue
      url = @deposito.cuenta+'/api/v1/projects.json'
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get::new(uri.path)
      req.basic_auth @deposito.usuario, @deposito.contrasena

      resp = http.request(req)
      @data_for_select = JSON.parse!(resp.body)

      @tam=@data_for_select.length
      @i=1
      @data = @c+"({"+"\""
      @data_for_select.each do |select|
        @data  = @data+select["id"].to_s+"\""+":"+"\""+select["name"]+"\""
        if @tam!=@i
          @data=@data+","+"\""
        else
          @data=@data+"})"
        end
        @i=@i+1
      end

    end


    render :text => @data
  end

  def use

    @deposito = Deposito.find(params[:id])
    @texto = params[:palabra_clave]
    @proyecto = params[:proyecto_id]
    @basecamp = Basecamp.establish_connection!(@deposito.cuenta, @deposito.usuario, @deposito.contrasena, true)

    @tipo_dep = ""

    begin
      #"https://oruga.basecamphq.com/projects/9290623/attachments.xml"#
      url = "https://"+@deposito.cuenta+"/projects/"+@proyecto+"/attachments.xml"
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get::new(uri.path)
      req.basic_auth @deposito.usuario, @deposito.contrasena
      resp = http.request(req)

      require 'rexml/document'
      # include REXML
      xml = resp.body
      @doc = REXML::Document.new(xml)

      @files=Array.new
      @doc.elements.each('attachments/attachment') do |p|
        file=Hash.new
        file["name"]=p.elements["name"].text
        file["url"]=p.elements["download-url"].text

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

        if(@texto != nil) then
          if(file["name"].include?(@texto))
            @files.push(file)
          end
        else
          @files.push(file)
        end
      end

      @tipo_dep=1;

      render json: @files

    rescue

      url = @deposito.cuenta+ '/api/v1/attachments.json'
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get::new(uri.path)
      req.basic_auth @deposito.usuario, @deposito.contrasena

      resp = http.request(req)
      @json = JSON.parse(resp.body)

      @files=Array.new
      @json.each do |atachments|

        if(atachments["bucket"]["id"].to_s == @proyecto) then
          file=Hash.new
          file["name"] = atachments["name"]
          file["url"]  = atachments["url"]

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

          if(@texto != nil) then
            if(file["name"].include?(@texto))
              @files.push(file)
            end
          else
            @files.push(file)
          end
        end
      end

      @tipo_dep=2

      render json: @files

    end
  end

  def comprobar
    #      a=   params[:tipo_deposito]
    # if (params[:tipo_deposito]==1|| params[:tipo_deposito]==2)
    @basecamp = Basecamp.establish_connection!(params[:cuenta], params[:usuario], params[:contrasena], true)

    begin
      @list = Basecamp::TodoList.find(:all)
      render :text => "false"
    rescue
      begin
        url = params[:cuenta]+'/api/v1/attachments.json'
        uri = URI.parse(url)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req = Net::HTTP::Get::new(uri.path)
        req.basic_auth params[:usuario], params[:contrasena]

        resp = http.request(req)
        @json = JSON.parse(resp.body)

        @tipo_dep=2;

        render :text => "false"
      rescue
        render :text => "true"
      end

    end
    #   end
  end

  def import
    @deposito = Deposito.find(params[:basecamp_id])
    @artefactos = params[:artefactos]

    @basecamp = Basecamp.establish_connection!(@deposito.cuenta, @deposito.usuario, @deposito.contrasena, true)

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

      @artefactos.each do |artefacto|
        uri = URI.parse(artefacto)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req = Net::HTTP::Get::new(uri.path)
        req.basic_auth @deposito.usuario, @deposito.contrasena

        resp = http.request(req)

        out = resp.body
        filename = File.basename(artefacto)
        open(filename, mode = 'wb', perm = 0666) {|f| f.write out }

        RestClient.post(
            ENV['url_razuna'] + 'index.cfm',
            :filedata => File.new(filename),
            :destfolderid => @folder_id,
            :api_key => ENV['admindavid_razuna_key'],
            :fa => "c.apiupload"
        )
      end
    end
    redirect_to request.protocol + request.host_with_port + "/depositos"
  end


  private
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = '1000'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
  end


  def access_allowed?
    allowed_sites = [request.env['HTTP_ORIGIN']] #you might query the DB or something, this is just an example
    return allowed_sites.include?(request.env['HTTP_ORIGIN'])
  end

end
