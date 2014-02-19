CMS::Application.routes.draw do

  resources :compuerta_pre_desicions

  resources :compuerta_desicions

  resources :tarea_aprobacions

  resources :tarea_revisions

  resources :actividad_revisions

  devise_for :users

  resources :tarea_artefactos

  resources :estado_tareas

  resources :tarea_participantes

  resources :tarea_presedencia

  resources :tarea_recursos

  resources :tareas

  resources :tipo_organizacions

  resources :proyecto_artefactos

  resources :artefactos

  resources :proyecto_usuarios

  resources :proyecto_recursos

  resources :proyecto_organizacions

  resources :transicions

  resources :procesos

  resources :usuarios

  resources :actividad_rols

  resources :actividad_tipoartefactos

  resources :tipo_artefactos

  resources :ruta

  resources :eventos

  resources :my_js_trees

  resources :actividad_tiporecursos

  resources :compuertus

  resources :compuerta

  resources :actividads

  resources :plantillas

  resources :tipo_plantillas

  resources :recursos

  resources :tipo_recursos

  resources :organizacions

  resources :rols

  resources :proyectos

  resources :tipo_productos

  resources :archivo_proyectos

  resources :archivos

  resources :tipo_archivos

  resources :deposito_proyectos

  resources :depositos

  resources :tipo_depositos

  resources :assignments

  resources :workers

  resources :projects

  match '*all' => 'application#cors_preflight_check', :constraints => {:method => 'OPTIONS'}



  #match '*all' => 'application#cor', :constraints => {:method => 'OPTIONS'}
  match '/local/:id/use' => 'local#use'
  match '/local/:id/upload' => 'local#upload'
  match '/mediabrowser' => 'mediabrowser#list', :as => :discolocal
  match '/mediabrowser' => 'mediabrowser#list', :as => :mediabrowser
  match '/mediabrowser/delete' => 'mediabrowser#delete', :as => :delete_file_mediabrowser
  match '/mediabrowser/dir/create'  => 'mediabrowser#create_dir',  :as => :create_dir_mediabrowser
  match '/mediabrowser/file/create'  => 'mediabrowser#create_file',  :as => :create_file_mediabrowser

  match '/indexUsuario' => 'index#indexUsuario', :as => 'indexUsuario'
  match '/graficas' => 'index#graficas', :as => 'graficas'


  # Validaciones de AJAX
  match '/tipo_recursos/existe/nombre' => 'tipo_recursos#existe', :as => :validacion_existe
  match '/recursos/existe/nombre' => 'recursos#existe', :as => :validacion_existe
  match '/tipo_plantillas/existe/nombre' => 'tipo_plantillas#existe', :as => :validacion_existe
  match '/tipo_organizacions/existe/nombre' => 'tipo_organizacions#existe', :as => :validacion_existe
  match '/plantillas/existe/nombre' => 'plantillas#existe', :as => :validacion_existe
  match '/tipo_artefactos/existe/nombre' => 'tipo_artefactos#existe', :as => :validacion_existe
  match '/actividads/existe/:nombre/:plantilla' => 'plantillas#existe', :as => :validacion_existe
  match '/actividads_turnos' => 'actividads#turnos', :as => :turnos # agregar turnos
  match '/actividad_revisor' => 'tarea_revisions#revisor', :as => :revisor # asignar revisores
  match '/compuerta_options' => 'compuerta_desicions#options', :as => :options #opciones compuerta
  match '/proyectos/existe/nombre' => 'proyectos#existe', :as => :validacion_existe
  match '/actividad_tiporecursos/existe/nombre' => 'actividad_tiporecursos#existe', :as => :validacion_existe
  match '/actividad_tipoartefactos/existe/nombre' => 'actividad_tipoartefactos#existe', :as => :validacion_existe
  match '/usuarios/existe/login' => 'usuarios#existe', :as => :validacion_existe
  match '/usuarios/password_iguales/pasword' => 'usuarios#password_iguales', :as => :validacion_password_iguales
  match '/rols/existe/nombre' => 'rols#existe', :as => :validacion_existe
  match '/organizacions/existe/nombre' => 'organizacions#existe', :as => :validacion_existe
  match '/organizacions/existe/nit' => 'organizacions#existenit', :as => :validacion_existenit
  match 'organizacions/existe/representante' => 'organizacions#existerepresentante', :as => :validacion_existerepresentante
  match 'organizacions/unico/representante' => 'organizacions#unicorepresentante', :as => :validacion_unicorepresentante

  match '/depositos/existe/nombre' => 'depositos#existe', :as => :validacion_existe

  match '/proyectos/:id/configu' => 'proyectos#configu', :as => :configu
  match '/proyectos/:id/configuempr' => 'proyectos#configuempr', :as => :configuempr
  match '/proyectos/:id/configupart' => 'proyectos#configupart', :as => :configupart
  match '/proyectos/:id/overview' => 'proyectos#overview', :as => :overview
  match '/proyectos/:id/priorizar' => 'proyectos#priorizar', :as => :priorizar
  match '/proyectos/:id/actualizarPriorizacion' => 'proyectos#actualizarPriorizacion', :as => :actualizarPriorizacion
  match '/proyectos/:id/actualizarPrior' => 'proyectos#actualizarPrior', :as => :actualizarPrior

  match '/proyectos/:id/priorizarTareas/:idusuario' => 'proyectos#priorizarTareas', :as => :priorizarTareas
  match '/proyectos/:id/arbol' => 'proyectos#arbol', :as => :arbol

  match   '/trees', :to => 'my_js_trees#jstree'
  match   '/treedata', :to => 'my_js_trees#jstreedata'


  match '/actividads/:id/destroy' => 'actividads#destroy', :as => :destroy
  match '/compuertus/:id/destroy' => 'compuertus#destroy', :as => :destroy
  match '/eventos/:id/destroy' => 'eventos#destroy', :as => :destroy
  match '/ruta/:id/destroy' => 'ruta#destroy', :as => :destroy

  match '/actividads/:id/updateName' => 'actividads#updateName', :as => :update
  match '/compuertus/:id/updateName' => 'compuertus#updateName', :as => :update
  match '/eventos/:id/updateName' => 'eventos#updateName', :as => :update
  match '/ruta/:id/updateName' => 'ruta#updateName', :as => :update
  match '/my_js_trees/:id/updateParent' => 'my_js_trees#updateParent', :as => :update

  match '/tarea_participantes/:id/updateEstado' => 'tarea_participantes#updateEstado', :as => :updateEstado
  match '/tarea_participantes/:id/updateHoras' => 'tarea_participantes#updateHoras', :as => :updateHoras

  #match '/tarea_participantes' => 'tarea_participantes#index', :as => :indexTareaP

  match '/procesos/clonar_plantilla/:id_plantilla/:id_proyecto' => 'procesos#clonar_plantilla', :as => :clonar_plantilla

  # JCombo
  match '/procesos/getTipoPlantilla/all' => 'procesos#getTipoPlantilla', :as => :getTipoPlantilla
  match '/procesos/getdata/:tipo_plantilla' => 'procesos#getdata', :as => :getdata
  match '/proyecto_organizacions/get_tipo_organizacions/all' => 'proyecto_organizacions#get_tipo_organizacions', :as => :get_tipo_organizacions
  match '/proyecto_organizacions/get_organizacions/:tipo_organizacion_id' => 'proyecto_organizacions#get_organizacions', :as => :get_organizacions
  match '/proyectos/get_organizaciones/all' => 'proyectos#get_organizaciones', :as => :get_organizaciones
  match '/proyectos/get_usuarios_org/:organizacion_id' => 'proyectos#get_usuarios_org', :as => :get_usuarios_org
  match '/depositos/get_tipo_depositos/all' => 'depositos#get_tipo_depositos', :as => :get_tipo_depositos
  match '/proyectos/getTipoRecurso/:id' => 'proyectos#getTipoRecurso', :as => :getTipoRecurso
  match '/proyectos/getdata/:id/:tipo_recurso' => 'proyectos#getdata', :as => :getdata

  match '/proyectos/listar_procesos/:id/:proy_id' => 'proyectos#listar_procesos', :as => :listar_procesos

  match '/procesos/:id_proceso/Reportes' => 'procesos#Reportes', :as => :Reportes, :action => 'Reportes'
  #match '/procesos/:id_proceso/Overview' => 'procesos#Overview', :as => :Overview
  #match '/procesos/:id_proceso/Status' => 'procesos#Status', :as => :Status
  #match '/procesos/:id_proceso/ResourceGraph' => 'procesos#ResourceGraph', :as => :ResourceGraph
  #match '/procesos/:id_proceso/Work package 1' => 'procesos#Workpackage1', :as => :Workpackage1
  #match '/procesos/:id_proceso/Work package 2' => 'procesos#Workpackage2', :as => :Workpackage2
  #match '/procesos/:id_proceso/ContactList' => 'procesos#ContactList', :as => :ContactList
  #match '/procesos/:id_proceso/Deliveries' => 'procesos#Deliveries', :as => :Deliveries
  #match '/procesos/:id_proceso/Development' => 'procesos#Development', :as => :Development


  match "/procesos/:id_proceso/icons/:id", :to => redirect("/assets/%{id}.png")
  match "/procesos/:id_proceso/css/:id", :to => redirect("/assets/%{id}.css")
  match "/procesos/:id_proceso/scripts/:id", :to => redirect("/assets/%{id}.js")


  match '/procesos/:id_proceso/Reportes' => 'procesos#Reportes', :as => :Reportes
  match '/procesos/:id_proceso/Overview' => 'procesos#Overview', :as => :Overview
  match '/procesos/:id_proceso/Status' => 'procesos#Status', :as => :Status
  match '/procesos/:id_proceso/ResourceGraph' => 'procesos#ResourceGraph', :as => :ResourceGraph
  match '/procesos/:id_proceso/resourcesM' => 'procesos#resourcesM', :as => :resourcesM
  match '/procesos/:id_proceso/Work package 1' => 'procesos#Workpackage1', :as => :Workpackage1
  match '/procesos/:id_proceso/Work package 2' => 'procesos#Workpackage2', :as => :Workpackage2
  match '/procesos/:id_proceso/ContactList' => 'procesos#ContactList', :as => :ContactList
  match '/procesos/:id_proceso/Deliveries' => 'procesos#Deliveries', :as => :Deliveries
  match '/procesos/:id_proceso/Development' => 'procesos#Development', :as => :Development
  match '/procesos/:id_proceso/BurndownChart' => 'procesos#BurndownChart', :as => :BurndownChart
  match '/procesos/:id_proceso/xpdl' => 'procesos#GenerateXPDL', :as => :GenerateXPDL



  match '/procesos/:id_proceso/icons/:pag', :to => redirect('/assets/'||:pag)
  match '/procesos/:id_proceso/css/:pag', :to => redirect('/assets/'||:pag)
  match '/procesos/:id_proceso/scripts/:pag', :to => redirect('assets/'||:pag)

  match '/procesos/:id_proceso/crear_programa' => 'procesos#crear_programa', :as => :crear_programa
  match '/procesos/:id_proceso/aprobaciones' => 'procesos#aprobaciones', :as => :aprobaciones
  match '/tareas/:id_tarea/asignar_responsable' => 'tareas#asignar_responsable', :as => :asignar_responsable
  match '/tareas/:id_tarea/actualizar_tarea' => 'tareas#actualizar_tarea', :as => :actualizar_tarea
  match '/tareas/:id_tarea/get_json_data' => 'tareas#get_json_data', :as => :get_json_data

  match '/artefactos/:dummy/search_assets' => 'artefactos#search_assets', :as => :search_assets
  match '/basecamp/:id/get_proyectos' => 'basecamp#get_proyectos', :as => :get_proyectos
  match '/deposito_proyectos/:id/new' => 'deposito_proyectos#new', :as => :nuevoDeposito
  match '/archivo_proyectos/:id/new' => 'archivo_proyectos#new', :as => :nuevoArchivo
  match '/dropbox/:id/autenticar' => 'dropbox#autenticar',:as => :dropbox
  match '/dropbox/use' => 'dropbox#use'   ,:as => :dropboxU ,:layout => 'actividads'
  match '/basecamp/:id/use' => 'basecamp#use' ,:as => :basecamp
  match '/dropbox/:id/use' => 'dropbox#use' ,:as => :dropbox
  match '/basecamp/comprobar' => 'basecamp#comprobar' ,:as => :basecamp_comprobar
  match '/dropbox/comprobar' => 'dropbox#comprobar' ,:as => :dropbox_comprobar          #
  match '/artefactos/razuna/sessiontoken' => 'artefactos#get_razuna_sessiontoken', :as => :try_get_razuna_sessiontoken
  match '/dropbox/import' => 'dropbox#import' ,:as => :dropbox_import
  match '/basecamp/import' => 'basecamp#import' ,:as => :basecamp_import
  match '/process_rules/validate_process' => 'process_rules#validate_process', :as => :validate_process_rules ,:layout => 'actividads'
  match '/process_rules/publicar_proceso' => 'process_rules#publicar_proceso', :as => :publish_process_rules ,:layout => 'actividads'

  #match '/treedata/:plantilla' => 'my_js_trees#jstreedata', :as => :id_plantilla
    # resources :workers do |worker|
    #   worker.resources :projects, :member => { :confirm => :get, :add => :post }
    #end

    # The priority is based upon order of creation:
    # first created -> highest priority.

    # Sample of regular route:
    #   match 'products/:id' => 'catalog#view'
    # Keep in mind you can assign values other than :controller and :action

    # Sample of named route:
    #   match 'workers/:id/assignment' => 'project#assignment', :as => :assigment
    # This route can be invoked with purchase_url(:id => product.id)

    # Sample resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Sample resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Sample resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Sample resource route with more complex sub-resources
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', :on => :collection
    #     end
    #   end

    # Sample resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end

    # You can have the root of your site routed with "root"
    # just remember to delete public/index.html.

     root :to => 'proyectos#index'
    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id))(.:format)'

end
