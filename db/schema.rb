# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131112230743) do

  create_table "actividad_revisions", :force => true do |t|
    t.string   "nombre"
    t.integer  "actividad_id"
    t.integer  "tipo_recurso_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "turno"
  end

  create_table "actividad_rols", :force => true do |t|
    t.integer  "actividad_id"
    t.integer  "rol_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "actividad_rols", ["actividad_id"], :name => "index_actividad_rols_on_actividad_id"
  add_index "actividad_rols", ["rol_id"], :name => "index_actividad_rols_on_rol_id"

  create_table "actividad_tipoartefactos", :force => true do |t|
    t.integer  "actividad_id"
    t.integer  "tipo_artefacto_id"
    t.string   "modo"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "actividad_tipoartefactos", ["actividad_id"], :name => "index_actividad_tipoartefactos_on_actividad_id"
  add_index "actividad_tipoartefactos", ["tipo_artefacto_id"], :name => "index_actividad_tipoartefactos_on_tipo_artefacto_id"

  create_table "actividad_tiporecursos", :force => true do |t|
    t.integer  "actividad_id"
    t.integer  "tipo_recurso_id"
    t.integer  "cantidad",        :default => 1, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "actividad_tiporecursos", ["actividad_id", "tipo_recurso_id"], :name => "index_actividad_tiporecursos_on_actividad_id_and_tipo_recurso_id", :unique => true
  add_index "actividad_tiporecursos", ["actividad_id"], :name => "index_actividad_tiporecursos_on_actividad_id"
  add_index "actividad_tiporecursos", ["tipo_recurso_id"], :name => "index_actividad_tiporecursos_on_tipo_recurso_id"

  create_table "actividads", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "modoejecucion"
    t.integer  "duracion"
    t.integer  "plantilla_id"
    t.integer  "my_js_tree_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "proceso_id"
    t.string   "estado"
    t.integer  "num_instancias"
    t.integer  "responsable_id"
    t.integer  "horas_estimadas"
    t.string   "tipocontrol"
    t.string   "modo_revision"
  end

  add_index "actividads", ["plantilla_id"], :name => "index_actividads_on_plantilla_id"
  add_index "actividads", ["proceso_id"], :name => "index_actividads_on_proceso_id"

  create_table "archivo_proyectos", :force => true do |t|
    t.integer  "archivo_id"
    t.integer  "proyecto_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "archivo_proyectos", ["archivo_id", "proyecto_id"], :name => "index_archivo_proyectos_on_archivo_id_and_proyecto_id", :unique => true
  add_index "archivo_proyectos", ["archivo_id"], :name => "index_archivo_proyectos_on_archivo_id"
  add_index "archivo_proyectos", ["proyecto_id"], :name => "index_archivo_proyectos_on_proyecto_id"

  create_table "archivos", :force => true do |t|
    t.string   "nombre"
    t.integer  "tipo_archivo_id"
    t.integer  "tipo_artefacto_id"
    t.date     "fcreado"
    t.string   "descripcion"
    t.integer  "deposito_id"
    t.string   "blob"
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "archivos", ["deposito_id"], :name => "index_archivos_on_deposito_id"
  add_index "archivos", ["tipo_archivo_id"], :name => "index_archivos_on_tipo_archivo_id"
  add_index "archivos", ["tipo_artefacto_id"], :name => "index_archivos_on_tipo_artefacto_id"

  create_table "artefactos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "razuna_key"
  end

  create_table "compuerta_desicions", :force => true do |t|
    t.integer  "compuerta_id"
    t.integer  "ruta_id"
    t.boolean  "elegida"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "tarea_desicion_id"
  end

  create_table "compuerta_pre_desicions", :force => true do |t|
    t.integer  "compuerta_id"
    t.integer  "ruta_id"
    t.boolean  "elegida"
    t.integer  "tarea_desicion_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "compuertus", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "tipo"
    t.integer  "desicion"
    t.integer  "plantilla_id"
    t.integer  "my_js_tree_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "proceso_id"
  end

  add_index "compuertus", ["plantilla_id"], :name => "index_compuertus_on_plantilla_id"
  add_index "compuertus", ["proceso_id"], :name => "index_compuertus_on_proceso_id"

  create_table "deposito_proyectos", :force => true do |t|
    t.integer  "deposito_id"
    t.integer  "proyecto_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "deposito_proyectos", ["deposito_id", "proyecto_id"], :name => "index_deposito_proyectos_on_deposito_id_and_proyecto_id", :unique => true
  add_index "deposito_proyectos", ["deposito_id"], :name => "index_deposito_proyectos_on_deposito_id"
  add_index "deposito_proyectos", ["proyecto_id"], :name => "index_deposito_proyectos_on_proyecto_id"

  create_table "depositos", :force => true do |t|
    t.string   "nombre"
    t.integer  "tipo_deposito_id"
    t.date     "fcreado"
    t.string   "descripcion"
    t.string   "usuario"
    t.string   "contrasena"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "cuenta"
    t.string   "session"
  end

  add_index "depositos", ["tipo_deposito_id"], :name => "index_depositos_on_tipo_deposito_id"

  create_table "estado_actividads", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "imagen"
    t.integer  "columna"
  end

  create_table "estado_tareas", :force => true do |t|
    t.integer  "tareas_id"
    t.integer  "estado_actividads_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "usuario_id"
  end

  add_index "estado_tareas", ["estado_actividads_id"], :name => "index_estado_tareas_on_estado_actividads_id"
  add_index "estado_tareas", ["tareas_id"], :name => "index_estado_tareas_on_tareas_id"

  create_table "eventos", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "tipo"
    t.integer  "plantilla_id"
    t.integer  "my_js_tree_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "proceso_id"
  end

  add_index "eventos", ["my_js_tree_id"], :name => "index_eventos_on_my_js_tree_id"
  add_index "eventos", ["plantilla_id"], :name => "index_eventos_on_plantilla_id"
  add_index "eventos", ["proceso_id"], :name => "index_eventos_on_proceso_id"

  create_table "my_js_trees", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "left"
    t.integer  "right"
    t.integer  "level"
    t.string   "title"
    t.string   "type"
    t.integer  "plantilla_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "proceso_id"
  end

  add_index "my_js_trees", ["proceso_id"], :name => "index_my_js_trees_on_proceso_id"

  create_table "organizacions", :force => true do |t|
    t.string   "nit"
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "naturaleza"
    t.string   "representante"
    t.string   "direccion"
    t.string   "telefono"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "tipo_organizacion_id"
  end

  create_table "plantillas", :force => true do |t|
    t.string   "nombre"
    t.integer  "tipo_plantilla_id"
    t.text     "descripcion"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "plantillas", ["nombre"], :name => "index_plantillas_on_nombre", :unique => true
  add_index "plantillas", ["tipo_plantilla_id"], :name => "index_plantillas_on_tipo_plantilla_id"

  create_table "proceso_validacions", :force => true do |t|
    t.integer  "proceso_id"
    t.string   "error_message"
    t.string   "tipo"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "procesos", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "tipo_plantilla_id"
    t.integer  "proyecto_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "filename"
    t.string   "estado"
  end

  add_index "procesos", ["proyecto_id"], :name => "index_procesos_on_proyecto_id"

  create_table "proyecto_artefactos", :force => true do |t|
    t.integer  "proyecto_id"
    t.integer  "artefacto_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "proyecto_artefactos", ["artefacto_id"], :name => "index_proyecto_artefactos_on_artefacto_id"
  add_index "proyecto_artefactos", ["proyecto_id"], :name => "index_proyecto_artefactos_on_proyecto_id"

  create_table "proyecto_organizacions", :force => true do |t|
    t.integer  "proyecto_id"
    t.integer  "organizacion_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "proyecto_organizacions", ["organizacion_id"], :name => "index_proyecto_organizacions_on_organizacion_id"
  add_index "proyecto_organizacions", ["proyecto_id"], :name => "index_proyecto_organizacions_on_proyecto_id"

  create_table "proyecto_recursos", :force => true do |t|
    t.integer  "proyecto_id"
    t.integer  "recurso_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "proyecto_recursos", ["proyecto_id"], :name => "index_proyecto_recursos_on_proyecto_id"
  add_index "proyecto_recursos", ["recurso_id"], :name => "index_proyecto_recursos_on_recurso_id"

  create_table "proyecto_usuarios", :force => true do |t|
    t.integer  "proyecto_id"
    t.integer  "usuario_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "proyecto_usuarios", ["proyecto_id"], :name => "index_proyecto_usuarios_on_proyecto_id"
  add_index "proyecto_usuarios", ["usuario_id"], :name => "index_proyecto_usuarios_on_usuario_id"

  create_table "proyectos", :force => true do |t|
    t.string   "nombre"
    t.integer  "tipo_producto_id"
    t.date     "fcreado"
    t.string   "descripcion"
    t.binary   "logo"
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "director"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.float    "presupuesto"
    t.integer  "organizacion_id"
  end

  add_index "proyectos", ["director"], :name => "index_proyectos_on_director"
  add_index "proyectos", ["tipo_producto_id"], :name => "index_proyectos_on_tipo_producto_id"

  create_table "recursos", :force => true do |t|
    t.string   "nombre"
    t.integer  "tipo_recurso_id"
    t.decimal  "costo",           :precision => 10, :scale => 0
    t.integer  "unidades"
    t.text     "descripcion"
    t.integer  "organizacion_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "recursos", ["nombre", "organizacion_id"], :name => "index_recursos_on_nombre_and_organizacion_id", :unique => true
  add_index "recursos", ["organizacion_id"], :name => "index_recursos_on_organizacion_id"
  add_index "recursos", ["tipo_recurso_id"], :name => "index_recursos_on_tipo_recurso_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "usuarios_id"
  end

  create_table "rols", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ruta", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "tipo"
    t.integer  "plantilla_id"
    t.integer  "my_js_tree_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "proceso_id"
  end

  add_index "ruta", ["my_js_tree_id"], :name => "index_ruta_on_my_js_tree_id"
  add_index "ruta", ["plantilla_id"], :name => "index_ruta_on_plantilla_id"
  add_index "ruta", ["proceso_id"], :name => "index_ruta_on_proceso_id"

  create_table "tarea_aprobacions", :force => true do |t|
    t.integer  "tarea_id"
    t.boolean  "aprobado"
    t.string   "comentario"
    t.integer  "usuario_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tarea_artefactos", :force => true do |t|
    t.integer  "tarea_id"
    t.integer  "artefacto_id"
    t.string   "modo"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tarea_participantes", :force => true do |t|
    t.integer  "tarea_id"
    t.integer  "usuario_id"
    t.integer  "dedicacion"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ejecutadas"
    t.integer  "prioridad"
  end

  create_table "tarea_presedencia", :force => true do |t|
    t.integer  "predecesora_id"
    t.integer  "sucesora_id"
    t.string   "tipo_relacion"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "proceso_id"
  end

  create_table "tarea_recursos", :force => true do |t|
    t.integer  "tarea_id"
    t.integer  "recurso_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "unidades"
  end

  create_table "tarea_revisions", :force => true do |t|
    t.integer  "tarea_id"
    t.integer  "usuario_id"
    t.string   "comentario"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "aprobado"
    t.integer  "turno"
  end

  create_table "tareas", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "actividad_id"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.integer  "responsable_id"
    t.integer  "prioridad"
    t.string   "comentarios"
    t.float    "avance"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "duracion"
    t.integer  "horas_planeadas"
    t.integer  "horas_ejecutadas"
    t.integer  "inst_num"
    t.integer  "proceso_id"
    t.integer  "estado"
    t.integer  "columna"
    t.boolean  "hito"
    t.integer  "horas_acumuladas"
    t.boolean  "activada"
    t.boolean  "es_aprobacion"
    t.integer  "tarea_revisar_id"
    t.boolean  "es_desicion"
    t.integer  "compuerta_id"
  end

  add_index "tareas", ["actividad_id"], :name => "index_tareas_on_actividad_id"
  add_index "tareas", ["proceso_id"], :name => "index_tareas_on_proceso_id"
  add_index "tareas", ["responsable_id"], :name => "index_tareas_on_responsable_id"

  create_table "tipo_archivos", :force => true do |t|
    t.string   "nombre"
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tipo_artefactos", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tipo_depositos", :force => true do |t|
    t.string   "nombre"
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tipo_organizacions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tipo_plantillas", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tipo_plantillas", ["nombre"], :name => "index_tipo_plantillas_on_nombre", :unique => true

  create_table "tipo_productos", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tipo_recursos", :force => true do |t|
    t.string   "nombre",                                    :default => "", :null => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.decimal  "cost",       :precision => 10, :scale => 0
    t.integer  "unit"
  end

  add_index "tipo_recursos", ["nombre"], :name => "nombre", :unique => true

  create_table "transicions", :force => true do |t|
    t.string   "nombre"
    t.string   "tipo_inicio"
    t.integer  "incio_id"
    t.string   "tipo_fin"
    t.integer  "fin_id"
    t.integer  "proceso_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "transicions", ["proceso_id"], :name => "index_transicions_on_proceso_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "password_confirm"
    t.integer  "tipo_recurso_id"
    t.string   "login"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "login"
    t.integer  "tipo_recurso_id"
    t.string   "imagen"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "organizacion_id"
    t.string   "password"
    t.string   "password_confirm"
    t.string   "apellidos"
    t.string   "email"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["organizacion_id"], :name => "index_usuarios_on_organizacion_id"
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["tipo_recurso_id"], :name => "index_usuarios_on_tipo_recurso_id"

end
