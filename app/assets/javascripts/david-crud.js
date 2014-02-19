function closeDialog () {
    $(nuevoModalId).modal('hide');
    $(editarModalId).modal('hide');
    $(eliminarModalId).modal('hide');

}

/*function okClicked () {
    document.title = document.getElementById ("xlInput").value;

    closeDialog ();
  };*/


function openDialog () {
    $('#error_explanation').modal('show');

}
function closeDialog1 () {
    $('#error_explanation').modal('hide');

}

var nombre_valido = false;
function validar_nombre_unico() {
    var nombre = document.getElementById(nameInputId).value;

    $.ajax({
        type: "GET",
        url: validateNameUrl,
        data: "nombre=" + nombre,
        async: false,
        success:
        function(msg) {
            msg == "true" ? nombre_valido = false : nombre_valido = true
        }
    });

    return nombre_valido;
}

function validar_nit_unico() {
    var nombre = document.getElementById(nitInputId).value;

    $.ajax({
        type: "GET",
        url: validateNitUrl,
        data: "nombre=" + nombre,
        async: false,
        success:
        function(msg) {
            msg == "true" ? nombre_valido = false : nombre_valido = true
        }
    });

    return nombre_valido;
}

function validar_representante_existe() {
    //*********************************************
    var representante = document.getElementById(representanteInputId).value;

    $.ajax({
        type: "GET",
        url: validateRepresentanteExisteUrl,
        data: "representante=" + representante,
        async: false,
        success:
            function(msg) {
                msg == "true" ? representante_valido = true : representante_valido = false
            }
    });

    return representante_valido;
}

function validar_representante_unico() {
    var representante = document.getElementById(representanteInputId).value;

    $.ajax({
        type: "GET",
        url: validateRepresentanteUnicoUrl,
        data: "representante=" + representante,
        async: false,
        success:
            function(msg) {
                msg == "true" ? representante_valido = false : representante_valido = true
            }
    });

    return representante_valido;
}


var passwordValido = false;
function validar_password_iguales() {
    var password = document.getElementById(pwdInputId).value;
    var password_confirm = document.getElementById(pwdConfInputId).value;

    $.ajax({
        type: "GET",
        url: validatePasswordUrl,
        data: {password: password,  password_confirm: password_confirm},
        async: false,
        success:
        function(msg) {
            msg == "true" ? nombre_valido = false : nombre_valido = true
        }
    });

    return nombre_valido;
}

var cuenta_existe = false;
function validar_cuenta_existe() {
    //var id_deposito = document.getElementById("<%= @deposito.id%>").value;
    var usuario = document.getElementById(usuarioInputId).value;
    var contrasena = document.getElementById(contrasenaInputId).value;
    var cuenta = document.getElementById(cuentaInputId).value;
    var tipo_deposito = tipoDepositoInputId;

   if( tipoDepositoInputId=="2"){
      // alert("Es 2 "+tipoDepositoInputId)  ;
    $.ajax({
        type: "POST",
        url: validateCuentaUrl,
        data: {usuario:usuario,contrasena:contrasena,cuenta:cuenta,tipo_deposito:tipo_deposito},
        async: false,
        success:
            function(msg) {
                msg == "true" ? cuenta_existe = false : cuenta_existe = true
            }
    });

    return cuenta_existe;
   }
    else if ( tipoDepositoInputId=="3")
   {
       return false;
       /*alert("Tipo dropbox");
       $.ajax({
           type: "POST",
           url: validateCuentaUrl1,
           data: {usuario:usuario,contrasena:contrasena,cuenta:cuenta,tipo_deposito:tipo_deposito},
           async: false,
           success:
               function(msg) {
                   msg == "true" ? cuenta_existe = false : cuenta_existe = true
               }
       });
     //  alert(tipoDepositoInputId)  ;
        return true;         */
   }
    else
    {
        return true;
    }
}

var actividad_valida = false;
function validar_actividad_unica() {
    var nombre = document.getElementById(nameInputId).value;
    var plantilla = document.getElementById(actiInputId).value;

    $.ajax({
        type: "GET",
        url: validateActUrl,
        data: "nombre=" + nombre +"&plantilla="+plantilla,
        async: false,
        success:
        function(msg) {
            msg == "true" ? actividad_valida = false : actividad_valida = true
        }
    });

    return actividad_valida;
}

var valor;



function mostrardiv() {
    $(eliminarButtonId).removeAttr('disabled');
    $(editarButtonId).removeAttr('disabled');

}
function cerrar() {
    $(eliminarButtonId).attr('disabled', 'disabled');
    $(editarButtonId).attr('disabled', 'disabled');
}

function mostrardiv1() {
    div = document.getElementById('menu_filtro');
    if(div.style.display=="")
    {
        divP = document.getElementById('layout_principal');
        div.style.display='none';
        divP.style.left=' 3px';
    }
    else
    {
        divP = document.getElementById('layout_principal');
        div.style.display = "";
        divP.style.left=' 250px';
    }

}
function cerrar1() {
    div = document.getElementById('menu_filtro');
    div.style.display='none';

}

function pintar(e){

    e=e || window.event;
    o= e.srcElement || e.target;
    colores=['#0088CC','white'];
    color=o.checked?colores[0]:colores[1];

    /*  au=document.getElementsByTagName('input');
    for(i=0,j=0;i<au.length;i++){
      if(au[i].type!='checkbox')continue;
      if(au[i].checked==true){
        if(au[i].name=="'filtro'")
        {
          colores=['white','white'];
          color=o.checked?colores[0]:colores[1];
        }
        else{
          j++;
<%= @var= 1 %>
          colores=['#0088CC','white'];
          color=o.checked?colores[0]:colores[1];
        }
      }
      if(j==0){
        cerrar()
      }
      if(j==1){
        valor=au[i].name;
        mostrardiv()
      }
      if(j>1){
        mostrardiv()
        alert('Seleccione sólo un ítem');
        o.checked=false;
        return;
      }
    }
*/
    o.parentNode.style.backgroundColor=color;

}

function evaluar(obj){
    obj.onclick=function(event){
        pintar(event);
    }
}

window.onload=function(){
    au=document.getElementsByTagName('input');
    for(i=0;i<au.length;i++){
        if(au[i].type!='checkbox')
            continue;
        evaluar(au[i])
    }
}

var sessiontoken = false;
function try_get_razuna_sessiontoken() {

    $.ajax({
        type: "POST",
        url: sessionToken,
        data: {},
        async: false,
        success:
        function(msg) {
            
            sessiontoken = msg
        }
    });

    return sessiontoken;
}



