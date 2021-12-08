<%@ Page Title="" Language="C#" MasterPageFile="~/indexAdministrador.Master" AutoEventWireup="true" CodeBehind="adminUsuarios.aspx.cs" Inherits="store_BOXLIT.paginaAdministrador.adminUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <!-- Estilos para ventana emergente (modal) -->
    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />

    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server"> 
    Usuarios/ Clientes
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">
 
    <form id="form1" runat="server">

   <!-- Ventana emergente: Editar usuarios -->
   <div class="modal fade" id="miModalEditarUsuario" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="width:600px">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" style="font-size:medium" id="myModalLabel">Editar Usuario</h4>
                    </div>
                    <div class="modal-body">

                        <table class="auto-style1">
                            <tr>
                                <td colspan="2">
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium">Código de Usuario</h4>
                                      <asp:TextBox ID="editarCodigo" runat="server" class="form-control" Width="250"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2">
                                  
                                </td>
                                 <td>&nbsp;</td>
                                 <td colspan="2">
                                 </td>
                              
                            </tr>
                            <tr>
                                <td colspan="2">
                                     <div class="form-group">
                                        <h4 class="title" style="font-size:medium">Login user</h4>
                                        <asp:TextBox ID="editarLogin" runat="server" class="form-control" Width="250"></asp:TextBox>
                                        <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2">
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium">Login password</h4>
                                      <asp:TextBox ID="editarPass" runat="server" class="form-control" Width="250"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                 <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                     <div class="form-group">
                                         <h4 class="title" style="font-size:medium">Nombre</h4>
                                          <asp:TextBox ID="editarNombre" runat="server" class="form-control" Width="250" maxlength="20" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>

                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2">
                                     <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Apellido</h4>
                                          <asp:TextBox ID="editarApellido" runat="server" class="form-control" Width="250" maxlength="20" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                  <td colspan="2">
                                  
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium">Sector</h4>
                                      <asp:TextBox ID="editarSector" runat="server" class="form-control" Width="250"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                    
                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2">
                                     <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Correo electrónico</h4>
                                          <asp:TextBox ID="editarEmail" runat="server" class="form-control" Width="250"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div> 
                                </td>
                            </tr>
                            </table>
                                        
                    <label style="color:gray; margin:6px; font-style:italic"> NOTA: Modifique los campos habilitados. Evite usar acentos, letra ñ o caracteres especiales.</label>

                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-theme03" OnClick="btnActualizar_Click" />
                      <%-- Solo el administrador puede eliminar usuarios, pero lo ponemos como practico --%>
                      <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-theme04" OnClick="btnEliminar_Click"/>
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Administrador usuarios  -->
   <div class="modal fade" id="miModalAdmin" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-body" style="font-size: medium">
                         <br />
                         <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display: block; margin: auto" />
                         <h4 style="font-size: medium; text-align: center">Ocurrió un error! Solo el administrador puede crear usuarios.</h4>
                     </div>
                     <div class="modal-footer">
                         <asp:Button ID="Button3" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                     </div>
                 </div>
             </div>
   </div>

   <!-- MoVentana emergentedal: Confirmacion de error email -->
   <div class="modal fade" id="miModalErrorEmail" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-body" style="font-size: medium">
                         <br />
                         <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display: block; margin: auto" />
                         <h4 style="font-size: medium; text-align: center">Ocurrió un error! El email ingresado del usuario ya existe o es inválido.</h4>
                     </div>
                     <div class="modal-footer">
                         <asp:Button ID="Button2" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                     </div>
                 </div>
             </div>
    </div>

   <!-- Ventana emergente: Ver clientes -->
   <div class="modal fade" id="miModalVerClientes" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="width:800px">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" style="font-size:medium">Clientes registrados en la web</h4>
                        
                    </div>
                    <div class="modal-body">

                       <!--  Buscador inteligente -->
                       <input type="text" id="text1" runat="server" maxlength="50" style=" margin:6px; width:450px"  class="form-control"  onkeyup="buscarGridViewClientes(this)" placeholder="Buscar cliente ... " />
                       <br />

                    <div style="width: 100%; height: 300px; overflow: scroll">
                        <asp:gridview ID="gvClientes" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
                         <columns>
                            <asp:boundfield DataField="usuarioID" HeaderText="CODIGO" ></asp:boundfield>    
                            <asp:boundfield DataField="usuarioLogin" HeaderText="Usuario" ></asp:boundfield>    
                            <asp:boundfield DataField="usuarioPass" HeaderText="Contraseña" ></asp:boundfield>
                            <asp:boundfield DataField="usuarioTipo" HeaderText="Tipo" ></asp:boundfield>
                            <asp:boundfield DataField="nombre" HeaderText="Nombre" ></asp:boundfield>    
                            <asp:boundfield DataField="apellido" HeaderText="Apellido" ></asp:boundfield>
                            <asp:boundfield DataField="email" HeaderText="Correo electrónico" ></asp:boundfield>
                            <asp:boundfield DataField="usuarioEstado" HeaderText="Estado" ></asp:boundfield>
                        </columns>
                    </asp:gridview> 
                    </div>

                    </div>
                    <div class="modal-footer">
                       <asp:Button ID="btnExportar" runat="server" Text="Exportar clientes a TXT" CssClass="btn btn-theme03" OnClick="btnExportar_Click" />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Eliminar usuario -->
   <div class="modal fade" id="miModalEliminar" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                       <img src="../img/check_warning.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                       <h4 style="font-size:medium; text-align:center">¿Esta seguro que desea eliminar este usuario?</h4>
                        <asp:TextBox ID="eliminarUser" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                       <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                      <asp:Button ID="btnConfirmaEliminar" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnConfirmaEliminar_Click" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Agregar nuevo usuario -->
   <div class="modal fade" id="miModalAgregarUsuario" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" style="width:600px">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" style="font-size:medium" >Agregar nuevo usuario</h4>
                    </div>
                    <div class="modal-body">

                        <table class="auto-style1">
                            <tr>
                                <td colspan="2">
                                     <div class="form-group">
                                        <h4 class="title" style="font-size:medium">Nombre de usuario (login user)</h4>
                                        <asp:TextBox ID="agregarLogin" runat="server" class="form-control" Width="250px"></asp:TextBox>
                                        <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2">
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium">Contraseña (login password)</h4>
                                      <asp:TextBox ID="agregarPass" runat="server" class="form-control" Width="250px"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                 <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                     <div class="form-group">
                                         <h4 class="title" style="font-size:medium">Nombre</h4>
                                          <asp:TextBox ID="agregarNombre" runat="server" class="form-control" Width="250px" maxlength="20" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>

                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2">
                                     <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Apellido</h4>
                                          <asp:TextBox ID="agregarApellido" runat="server" class="form-control" Width="250px" maxlength="20" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" >
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium">Sector</h4>
                                        <asp:DropDownList ID="agregarDropSector" runat="server" CssClass="form-control" Width="250px"></asp:DropDownList>
                                      <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2">
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium">Correo electrónico</h4>
                                      <asp:TextBox ID="agregarEmail" runat="server" class="form-control" Width="250px"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                     <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Clave de autorización</h4>
                                          <asp:TextBox ID="agregarPassAdmin" TextMode="Password" runat="server" class="form-control" Width="250px" maxlength="20" ></asp:TextBox>
                                          <div class="validate"></div>
                                           <label style="color:gray; margin:6px; font-style:italic"> Password: BOXLIT! (Solo para uso academicos).</label>
                                     </div>
                                </td>
                                <td>&nbsp;</td>
                                <td colspan="2"></td>
                            </tr>
                        </table>
                   
                    <label style="color:gray; margin:6px; font-style:italic"> NOTA: Complete todos los campos. Evite usar acentos, letra ñ o caracteres especiales.</label>

                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-theme03" OnClick="btnAgregar_Click"  />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
    </div>

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
                      <asp:Button ID="btnExito" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnExito_Click" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
    </div>

   <!-- Ventana emergente: Confirmacion de exito de usuario eliminado-->
   <div class="modal fade" id="miModalExitoUsuarioEliminado" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_ok.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Usuario eliminado correctamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="Button4" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnExito_Click" CommandName="selectUpdate" />
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
                         <h4 style="font-size:medium; text-align:center">Ocurrió un error! Complete datos o intente nuevamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnError" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
    </div>

   <!-- Ventana emergente: Confirmacion de error nombre de usuario existente-->
   <div class="modal fade" id="miModalErrorUser" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Ocurrió un error! El nombre de usuario ingresado ya existe.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="Button1" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
    </div>

   <!-- Panel de botones externos -->
   <div class="content-panel">
       <div style="margin:6px">
           <table class="auto-style1" >
                <tr>
                    <td>
                        <button type="button" onclick="window.location.href='../indexAdministrador.aspx'" class="btn btn-warning"><i class="fa fa-home"></i> Inicio</button>
                        <asp:Button ID="btnAgregarUsuario" runat="server" Text="✚ Nuevo usuario" CssClass="btn btn-theme" OnClick="btnAgregarUsuario_Click" />
                        <asp:Button ID="btnVerClientes" runat="server" Text="Mostrar clientes registrados" CssClass="btn btn-theme" OnClick="btnVerClientes_Click" />
                    </td>
                    <td style="width:85px">
                        <span style="height:30px; cursor:default" class="btn btn-default"> Registros: <asp:Label ID="lblContador" runat="server" ></asp:Label></span>
                    </td>
                </tr>
            </table>
       </div>
   </div>

   <br />

   <!-- Panel gridview usuarios -->
   <div class="content-panel">

           <!-- Buscador inteligente -->
           <input type="text" id="textBuscar" runat="server" maxlength="50" style=" margin:6px; width:450px"  class="form-control"  onkeyup="buscarGridView(this)" placeholder="Que desea buscar ... " />
           <br />

        <div style="width: 100%; height: 800px; overflow: scroll">
            <asp:gridview ID="gvUsuarios" runat="server" OnRowCommand="gvUsuarios_RowCommand" AutoGenerateColumns="False" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
             <columns>

                <asp:TemplateField >
                    <ItemTemplate> 
                        <asp:Button ID="btnEditarUsuario" type="button" runat="server" Text="✎ Editar" CssClass="btn btn-theme btn-sm"  CommandName="selectUsuario" CommandArgument="<%# Container.DataItemIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:boundfield DataField="usuarioID" HeaderText="CODIGO" ></asp:boundfield>    
                <asp:boundfield DataField="usuarioLogin" HeaderText="Usuario" ></asp:boundfield>    
                <asp:boundfield DataField="usuarioPass" HeaderText="Contraseña" ></asp:boundfield>
                <asp:boundfield DataField="nombre" HeaderText="Nombre" ></asp:boundfield>    
                <asp:boundfield DataField="apellido" HeaderText="Apellido" ></asp:boundfield>
                <asp:boundfield DataField="email" HeaderText="Correo electrónico" ></asp:boundfield>
                <asp:boundfield DataField="usuarioSector" HeaderText="Sector" ></asp:boundfield>
                <asp:boundfield DataField="usuarioEstado" HeaderText="Estado" ></asp:boundfield>
            </columns>
        </asp:gridview> 
        </div>
    </div>

 </form>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">
    
    <!-- Buscador inteligente en tiempo real de Usuarios en gridview -->
    <script type="text/javascript">
       function buscarGridView(strKey) {
                var strData = strKey.value.toLowerCase().split(" ");
                var tblData = document.getElementById("<%=gvUsuarios.ClientID %>");
                var rowData;
                for (var i = 1; i < tblData.rows.length; i++) {
                    rowData = tblData.rows[i].innerHTML;
                    var styleDisplay = 'none';
                    for (var j = 0; j < strData.length; j++) {
                        if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                            styleDisplay = '';
                        else {
                            styleDisplay = 'none';
                            break;
                        }
                    }
                    tblData.rows[i].style.display = styleDisplay;
                }
            }  
    </script>
           
    <!-- Buscador inteligente en tiempo real de Clientes en gridview -->
    <script type="text/javascript">
            function buscarGridViewClientes(strKey) {
                var strData = strKey.value.toLowerCase().split(" ");
                var tblData = document.getElementById("<%=gvClientes.ClientID %>");
                var rowData;
                for (var i = 1; i < tblData.rows.length; i++) {
                    rowData = tblData.rows[i].innerHTML;
                    var styleDisplay = 'none';
                    for (var j = 0; j < strData.length; j++) {
                        if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                            styleDisplay = '';
                        else {
                            styleDisplay = 'none';
                            break;
                        }
                    }
                    tblData.rows[i].style.display = styleDisplay;
                }
            }  
    </script>

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
