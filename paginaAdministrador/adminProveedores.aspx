<%@ Page Title="" Language="C#" MasterPageFile="~/indexAdministrador.Master" AutoEventWireup="true" CodeBehind="adminProveedores.aspx.cs" Inherits="store_BOXLIT.paginaAdministrador.adminProveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <!-- En caso de error: WebForms UnobtrusiveValidationMode requires a ScriptResourceMapping for jquery 
     Modificar el archivo: Web.config y agregar estas lineas dentro de configuration
       <appSettings>
	      <add key="ValidationSettings:UnobtrusiveValidationMode" value="None" />
       </appSettings>
    -->

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
    Proveedores
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">

         <form id="form1" runat="server">
   
   <!-- Ventana emergente: Editar proveedor -->
   <div class="modal fade" id="miModalEditarProveedor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Editar proveedor</h4>
                    </div>
                    <div class="modal-body">

                        <table class="auto-style1">
                            <tr>
                                <td>
                                     <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Código del proveedor</h4>
                                          <asp:TextBox ID="editarCodigo" runat="server" class="form-control"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Nombre del proveedor</h4>
                                          <asp:TextBox ID="editarNombre" runat="server" class="form-control" MaxLength="30" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                                <td>
                                    <div class="form-group">
                                          <h4 class="title" style="font-size:medium">CUIT</h4>
                                          <asp:TextBox ID="editarCUIT" runat="server" MaxLength="11" class="form-control" onkeypress="javascript:return soloNumeros(event)"> </asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                                <td>
                                  
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Correo electrónico</h4>
                                          <asp:TextBox ID="editarEmail" runat="server" class="form-control"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Provincia</h4>
                                          <asp:TextBox ID="editarProvincia" runat="server" MaxLength="30" class="form-control" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                            </tr>
                        </table>

                    <!-- Control de expresiones y digitos -->
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="editarCUIT" ValidationExpression="^([\S\s]{0,11})$" runat="server" ErrorMessage="Ingrese solo 11 digitos"></asp:RegularExpressionValidator>

                    <label style="color:gray; margin:6px; font-style:italic"> NOTA: Modifique los campos habilitados. Evite usar acentos, letra ñ o caracteres especiales.</label>

                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-theme03" OnClick="btnActualizar_Click" />
                      <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-theme04" OnClick="btnEliminar_Click" />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
              </div>

   <!-- Ventana emergente: Eliminar proveedor -->
  <div class="modal fade" id="miModalEliminar" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                       <img src="../img/check_warning.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                       <h4 style="font-size:medium; text-align:center">¿Esta seguro que desea eliminar este proveedor?</h4>
                        <asp:TextBox ID="eliminarNombreProveedor" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnConfirmaEliminar" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnConfirmaEliminar_Click" CommandName="selectUpdate" />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
              </div>

   <!-- Ventana emergente: Agregar nuevo proveedor -->
   <div class="modal fade" id="miModalAgregarProveedor" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" >Agregar nuevo proveedor</h4>
                    </div>
                    <div class="modal-body" >

                    <table class="auto-style1">
                            <tr>
                                <td >
                                    <div class="form-group" >
                                          <h4 class="title" style="font-size:medium">Nombre del proveedor</h4>
                                          <asp:TextBox ID="agregarNombre" runat="server" MaxLength="30" class="form-control" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td>
                                    <div class="form-group">
                                         <h4 class="title" style="font-size:medium">CUIT</h4>
                                         <asp:TextBox ID="agregarCUIT" runat="server" class="form-control" MaxLength="11" onkeypress="javascript:return soloNumeros(event)"></asp:TextBox>
                                         <div class="validate"></div>
                                    </div>

                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <div class="form-group">
                                         <h4 class="title" style="font-size:medium">Correo electrónico</h4>
                                         <asp:TextBox ID="agregarEmail" runat="server" class="form-control" ></asp:TextBox>
                                         <div class="validate"></div>
                                    </div>
                                </td>
                                <td>&nbsp;</td>
                            </tr>

                            <tr>
                                <td>
                                     <div class="form-group">
                                          <h4 class="title" style="font-size:medium">Provincia</h4>
                                          <asp:TextBox ID="agregarProvincia" runat="server" MaxLength="30" class="form-control" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                     </div>
                                </td>
                                <td>&nbsp;</td>
                            </tr>

                         </table>

                    <!-- Control de expresiones y digitos -->
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="agregarCUIT" ValidationExpression="^([\S\s]{0,11})$" runat="server" ErrorMessage="Ingrese solo 11 digitos"></asp:RegularExpressionValidator>

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

   <!-- Ventana emergente: Confirmacion de exito de proveedor eliminado-->
   <div class="modal fade" id="miModalExitoProveedorEliminado" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_ok.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Proveedor eliminado correctamente.</h4>
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
                         <h4 style="font-size:medium; text-align:center">Ocurrió un error! Complete los datos o intente nuevamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnError" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
              </div>

   <!-- Ventana emergente: Confirmacion de error de proveedor ya existente -->
   <div class="modal fade" id="miModalErrorProv" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-body" style="font-size: medium">
                         <br />
                         <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display: block; margin: auto" />
                         <h4 style="font-size: medium; text-align: center">Ocurrió un error! El nombre del proveedor ya existe.</h4>
                     </div>
                     <div class="modal-footer">
                         <asp:Button ID="Button1" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                     </div>
                 </div>
             </div>
         </div>

   <!-- Ventana emergente: Confirmacion de error de email de proveedor ya existente -->
   <div class="modal fade" id="miModalErrorProvEmail" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-body" style="font-size: medium">
                         <br />
                         <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display: block; margin: auto" />
                         <h4 style="font-size: medium; text-align: center">Ocurrió un error! El email ingresado del proveedor ya existe o es inválido.</h4>
                     </div>
                     <div class="modal-footer">
                         <asp:Button ID="Button2" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                     </div>
                 </div>
             </div>
         </div>

   <!-- Panel de botones externos -->
   <div class="content-panel">
       <div style="margin:6px">
           <table class="auto-style1">
                <tr>
                    <td>
                        <button type="button" onclick="window.location.href='../indexAdministrador.aspx'" class="btn btn-warning"><i class="fa fa-home"></i> Inicio</button>
                        <asp:Button ID="btnAgregarProveedor" runat="server" Text="✚ Nuevo proveedor" CssClass="btn btn-theme" OnClick="btnAgregarProveedor_Click" />
                    </td>
                    <td style="width:85px">
                         <span style="height:30px;cursor:default" class="btn btn-default"> Registros: <asp:Label ID="lblContador" runat="server" ></asp:Label></span>
                    </td>
                </tr>
            </table>
       </div>
   </div>

   <br />
   <!-- Panel gridview proveedores -->
   <div class="content-panel">
           <!--  Buscador inteligente -->
           <input type="text" id="textBuscar" runat="server" maxlength="50" style=" margin:6px; width:450px"  class="form-control"  onkeyup="buscarGridView(this)" placeholder="Que desea buscar ... " />
           <br />

        <div style="width: 100%; height: 900px; overflow: scroll">
            <asp:gridview ID="gvProveedores" runat="server" OnRowCommand="gvProveedores_RowCommand" AutoGenerateColumns="False" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
          <columns>
                <asp:TemplateField >
                    <ItemTemplate> 
                        <asp:Button ID="btnEditarProveedor" type="button" runat="server" Text="✎ Editar" CssClass="btn btn-theme btn-sm"  CommandName="selectProveedor" CommandArgument="<%# Container.DataItemIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:boundfield DataField="proveedorID" HeaderText="CODIGO" ></asp:boundfield>    
                <asp:boundfield DataField="proveedorNombre" HeaderText="Nombre" ></asp:boundfield>    
                <asp:boundfield DataField="proveedorCUIT" HeaderText="CUIT " ></asp:boundfield>    
                <asp:boundfield DataField="proveedorEmail" HeaderText="Correo electrónico" ></asp:boundfield>
                <asp:boundfield DataField="proveedorProvincia" HeaderText="Provincia" ></asp:boundfield>
           </columns>
        </asp:gridview> 
        </div>
    </div>

 </form>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">

    <!-- Buscador inteligente en tiempo real de proveedores -->
    <script type="text/javascript">
            function buscarGridView(strKey) {
                var strData = strKey.value.toLowerCase().split(" ");
                var tblData = document.getElementById("<%=gvProveedores.ClientID %>");
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
