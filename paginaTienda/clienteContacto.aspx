<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="clienteContacto.aspx.cs" Inherits="store_BOXLIT.paginaTienda.clienteContacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
    <!-- Estilos para ventana emergente (modal) -->
    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />
    
    <!-- Otros estilos -->
    <link href="../css/style.css" rel="stylesheet" />

    <style>
        .map-container{
        overflow:hidden;
        padding-bottom:56.25%;
        position:relative;
        height:0;
        }
        .map-container iframe{
        top:0;
        height:100%;
        width:100%;
        position:absolute;
        left:0;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server">
    <img src="../img/banContacto.jpg" style="width:100%"/>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">

   <!-- Ventana emergente: Confirmacion de exito -->
   <div class="modal fade" id="miModalExito" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_ok.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">En buena hora! Proceso realizado correctamente.</h4>
                    </div>
                    <div class="modal-footer">
                             <asp:Button ID="btnExito" runat="server" ForeColor="White" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnExito_Click" />
                    </div>
                  </div>
                </div>
    </div>

   <!-- Ventana emergente: Confirmacion de error -->
   <div class="modal fade" id="miModalError" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Ocurrió un error! Complete los datos o intente nuevamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnError" runat="server" ForeColor="White" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03"  />
                    </div>
                  </div>
                </div>
    </div>
   
   <!-- Formulario de contacto -->
   <section class="bgwhite p-t-66 p-b-38">
		<div class="container">
			<div class="row">
				<div class="col-md-4 p-b-30">
                    <!--Google maps/ Colocar en iframe la ubicacion que uno desea-->
                    <div id="map-container-google-1" class="z-depth-1-half map-container" style="height: 500px">
                      <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d28985.801989518983!2d-65.387234!3d-24.753465!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x69dac60239564277!2sUCASAL!5e0!3m2!1ses!2sus!4v1571865607089!5m2!1ses!2sus" frameborder="0"
                        style="border:0" allowfullscreen></iframe>
                    </div>
				</div>

                <!-- Datos de contacto -->
				<div class="col-md-8 p-b-30">
						<h2 class="product-name">
                             <asp:Label ID="lblNombre" runat="server" Text="">Envianos tu mensaje</asp:Label>
					     </h2>
						<div class="form-group">
                            <input id="contactoNombre" runat="server" class="input form-control" type="text" name="first-name" placeholder="Nombre" onkeypress="javascript:return soloLetras(event)">
						</div>     
                        <div class="form-group">
                            <input id="contactoAsunto" runat="server" class="input form-control" type="text" name="first-name" placeholder="Asunto">
						</div>                        
						<div class="form-group">
                            <input id="contactoTelefono" maxlength="10" runat="server" class="input form-control"  type="text" name="first-name" placeholder="Telefono" onkeypress="javascript:return soloNumeros(event)">
						</div>
						<div class="form-group">
                            <input id="contactoEmail" runat="server" class="input form-control" type="email" name="first-name" placeholder="Correo electrónico" onclick="evaluarMail_Click" >
						</div>
						<div class="form-group">
                            <asp:TextBox TextMode="MultiLine" Style=" margin-top: 5px; clear: right; margin-bottom: 5px; width: 100%; height: 150px;" runat="server" ID="contactoMessage" MaxLength="200" CssClass="form-control" />
						</div>
                        <div class="product-details">
                           <div class="add-to-cart">
                               <asp:Button ID="btnEnviar" runat="server" Text="Enviar" CssClass="add-to-cart-btn"  OnClick="btnEnviar_Click" Font-Size="Smaller"/>
                               <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Mensaje" CssClass="add-to-cart-btn" OnClick="btnNuevo_Click" Font-Size="Smaller"/>
                           </div>
                        </div> 
				</div>
			</div>
		</div>
	</section>
    
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">

    <!-- Control solo letras -->
    <script type="text/javascript">
       function soloLetras(e){
       key = e.keyCode || e.which;
       tecla = String.fromCharCode(key).toLowerCase();
       letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
       especiales = "8-37-39-46";

       tecla_especial = false
       for(var i in especiales){
            if(key == especiales[i]){
                tecla_especial = true;
                break;
            }
        }

        if(letras.indexOf(tecla)==-1 && !tecla_especial){
            return false;
        }
    }
    </script>

    <!-- Control solo numeros -->
    <script type="text/javascript">
     function soloNumeros(e){
	     var key = window.Event ? e.which : e.keyCode
	     return (key >= 48 && key <= 57)
        }
     </script>
</asp:Content>
