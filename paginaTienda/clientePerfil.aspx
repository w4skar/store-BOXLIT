<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="clientePerfil.aspx.cs" Inherits="store_BOXLIT.paginaTienda.clientePerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <!--Estilos para ventana emergente (modal) -->
  <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
  <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
  <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />

  <!-- Otros estilos -->
  <link href="../css/style.css" rel="stylesheet" />

  <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server">
    <img src="../img/banCuenta.jpg" style="width:100%"/>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">

    
   <!-- Ventana emergente: Editar usuario -->
   <div class="modal fade" id="miModalEditarUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="width:700px">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px; background:#4ECDC4">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel" style="color:white; font-size:medium" >Editar cliente</h4>
                    </div>
                    <div class="modal-body">

                         <table >
                             <tr>
                                 <td colspan="7">
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Código de Cliente</h4>
                                      <asp:TextBox ID="editarCodigo" runat="server" class="form-control" Width="650px"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                 </td>
                             </tr>

                              <tr>
                                 <td>
                                    <div class="form-group">
                                        <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Login user</h4>
                                        <asp:TextBox ID="editarUserLogin" runat="server" class="form-control" Width="200px" maxlength="20" ></asp:TextBox>
                                        <div class="validate"></div>
                                    </div>
                                 </td>
                                 <td>&nbsp;</td>
                                 <td>
                                     <div class="form-group">
                                      <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Login password</h4>
                                      <asp:TextBox ID="editarUserPassword" runat="server" class="form-control" Width="200px" MaxLength="20"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                 </td>
                                 <td>&nbsp;</td>
                                 <td></td>
                             </tr>

                              <tr>
                                 <td>
                                    <div class="form-group">
                                         <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Nombre</h4>
                                          <asp:TextBox ID="editarNombre" runat="server" class="form-control" Width="200px" maxlength="20" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                 </td>
                                 <td>&nbsp;</td>
                                 <td>
                                     <div class="form-group">
                                          <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Apellido</h4>
                                          <asp:TextBox ID="editarApellido" runat="server" class="form-control" Width="200px" maxlength="20" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                 </td>
                                 <td>&nbsp;</td>
                                 <td>
                                      <div class="form-group">
                                          <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">DNI</h4>
                                          <asp:TextBox ID="editarDNI" runat="server" class="form-control" Width="200px"></asp:TextBox>
                                          <div class="validate"></div>
                                    </div>
                                 </td>
                                 <td>&nbsp;</td>
                                 <td></td>
                             </tr>

                             <tr>
                                 <td>
                                    <div class="form-group">
                                      <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Correo electrónico</h4>
                                      <asp:TextBox ID="editarEmail" runat="server" class="form-control" Width="200px"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                 </td>
                                 <td>&nbsp;</td>
                                 <td>
                                      <div class="form-group">
                                      <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Teléfono</h4>
                                      <asp:TextBox ID="editarTelefono" runat="server" class="form-control" Width="200px" maxlength="10" onkeypress="javascript:return soloNumeros(event)"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                 </td>
                                 <td>&nbsp;</td>
                                 <td>
                                      <div class="form-group">
                                      <h4 class="title" style="font-size:medium;font-family: 'Ruda', sans-serif; font-size:medium; font-weight:100">Provincia</h4>
                                      <asp:TextBox ID="editarProvincia" runat="server" class="form-control" Width="200px" maxlength="20" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                      <div class="validate"></div>
                                    </div>
                                 </td>
                             </tr>
                          </table>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnActualizarUser" ForeColor="White" runat="server" Text="Actualizar" CssClass="btn btn-theme03" OnClick="btnActualizarUser_Click"/>
                      <asp:Button ID="btnEliminarUser" ForeColor="White" runat="server" Text="Darme de Baja" CssClass="btn btn-theme04" OnClick="btnEliminarUser_Click"  />
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

   <!-- Ventana emergente: Confirmacion de exito modificado -->
   <div class="modal fade" id="miModalExitoUser" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_ok.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">En buena hora! Usuario modificado correctamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="Button1" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnExito_Click" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
              </div>

   <!-- Ventana emergente: Confirmacion de exito usuario eliminado-->
   <div class="modal fade" id="miModalExitoEliminar" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_ok.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Lamentamos que te vayas! Usuario eliminado correctamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnEliminado" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnEliminado_Click" />
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

   <!-- Ventana emergente: Eliminar usuario -->
   <div class="modal fade" id="miModalEliminar" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                       <img src="../img/check_warning.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                       <h4 style="font-size:medium; text-align:center">¿Esta seguro que desea eliminar esta cuenta?</h4>
                        <asp:TextBox ID="eliminarCliente" runat="server" class="form-control"></asp:TextBox>

                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnConfirmaEliminar" ForeColor="White" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnConfirmaEliminar_Click"  />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
    </div>
  
   <!-- Ventana emergente: Detalle de compras de usuario -->
   <div class="modal fade" id="miModalDetalle" tabindex="-1" role="dialog" aria-labelledby="ModalTitle" aria-hidden="true">
       <div class="modal-dialog" style="width:900px">
         <div class="modal-content" >
              <div class="modal-header" style="height:50px; background:#4ECDC4">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h4 class="modal-title" id="ModalTitle" style="color:white; font-size:medium" >Detalle de compra</h4>
              </div>
              <div class="modal-body">
                 <table style="border-color:white">
                  <tr>
                      <td>
                            <label>Codigo de usuario </label>
                            <asp:TextBox ID="detalleCodigoUsuario" runat="server" CssClass="form-control" Height="30px" Width="250px"></asp:TextBox>
                      </td>
                      <td>&nbsp;</td>
                      <td>
                            <label>Codigo de venta </label>
                            <asp:TextBox ID="detalleCodigoVenta" runat="server" CssClass="form-control" Height="30px" Width="250px"></asp:TextBox>
                      </td>
                  </tr>
                  <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                  </tr>
                  <tr>
                      <td>
                            <label>Fecha de compra </label>
                            <asp:TextBox ID="detalleFecha" runat="server" CssClass="form-control" Height="30px" Width="250px"></asp:TextBox>
                      </td>
                      <td>&nbsp;</td>
                      <td>
                            <label>Forma de pago </label>
                            <asp:TextBox ID="detalleFormaPago" runat="server" CssClass="form-control" Height="30px" Width="250px"></asp:TextBox>
                      </td>
                      <td>&nbsp;</td>
                      <td>
                            <label>Total abonado </label>
                            <asp:TextBox ID="detalleAbonado" runat="server" CssClass="form-control" Height="30px" Width="250px"></asp:TextBox>
                      </td>
                  </tr>
                  <tr>
                      <td>&nbsp</td>
                      <td>&nbsp;</td>
                  </tr>
                  <tr>
                      <td>&nbsp</td>
                      <td>&nbsp;</td>
                  </tr>
              </table>
                  
                  <div style="width: 100%; height: 250px; overflow: scroll">
                    <asp:GridView ID="gvDetalleCliente" OnRowCommand="gvDetalleCliente_RowCommand" runat="server" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
                        <Columns>
                            <asp:TemplateField >
                                   <ItemTemplate> 
                                        <asp:Button ID="btnReportarItem" type="button" runat="server" Text="Reportar" CssClass="btn btn-danger "  CommandName="selectReportar" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                             </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                  
                  </div>
              </div>
              <div class="modal-footer">
                 <%--<asp:Button Text="Reportar error en la compra" id="errorCompra" OnClick="errorCompra_Click" CssClass="btn btn-danger" runat="server" />--%>
                 <button type="button" class="btn btn-default" data-dismiss="modal">Volver</button>
             </div>
         </div>
      </div>
    </div>

    <!-- Pestañas del cliente -->
	<div id="product-tab">
		<ul class="tab-nav" >
			    <li class="active"><a data-toggle="tab" href="#tab1">Mis datos</a></li>
								<li><a data-toggle="tab" href="#tab2">Compras realizadas</a></li>
                                <li><a data-toggle="tab" href="#tab3">Reportes de compra</a></li>
		</ul>

        <div class="tab-content">
								    <div id="tab1" class="tab-pane fade in active">
                                        <!-- Panel de datos del cliente -->
                                        <div class="content-panel">
                                                 <div style="width: 100%">
                                                        <asp:gridview ID="gvCliente" runat="server" OnRowCommand="gvCliente_RowCommand" AutoGenerateColumns="false" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White" >
                                                            <columns>

                                                                <asp:TemplateField >
                                                                    <ItemTemplate> 
                                                                        <asp:Button ID="btnEditarCategoria" ForeColor="White" type="button" runat="server" Text="✎ Editar" CssClass="btn btn-theme btn-sm"  CommandName="selectCliente" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:boundfield DataField="usuarioID" HeaderText="CODIGO" ></asp:boundfield>    
                                                                <asp:boundfield DataField="usuarioLogin" HeaderText="Usuario" ></asp:boundfield>
                                                                <asp:boundfield DataField="usuarioPass" HeaderText="Contraseña" ></asp:boundfield>
                                                                <asp:boundfield DataField="nombre" HeaderText="Nombre" ></asp:boundfield>    
                                                                <asp:boundfield DataField="apellido" HeaderText="Apellido" ></asp:boundfield>
                                                                <asp:boundfield DataField="email" HeaderText="Correo electrónico" ></asp:boundfield>    
                                                                <asp:boundfield DataField="usuarioEstado" HeaderText="Estado" ></asp:boundfield>

                                                    </columns>
                                                        </asp:gridview> 
                                                  </div>
                                            </div>
                                        
                                    </div>

                                    <div id="tab2" class="tab-pane fade in">
									    <div class="row">
                                            <!-- Panel de datos de compras del cliente -->
                                            <div class="content-panel">
                                                <div style="width: 100%; height: 600px; overflow: scroll">
                                                    <asp:gridview ID="gvDetalleCompra" runat="server" EmptyDataText="Por el momento no existen compras!" EmptyDataRowStyle-ForeColor="Red" EmptyDataRowStyle-BackColor="White" EmptyDataRowStyle-VerticalAlign="Middle" EmptyDataRowStyle-HorizontalAlign="Center" OnRowCommand="gvDetalleCompra_RowCommand" AutoGenerateColumns="false" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
                                                        <columns>
                                                         <asp:TemplateField >
                                                             <ItemTemplate> 
                                                                  <asp:Button ID="btnDetalleCompra" type="button" runat="server" Text="Detalle" CssClass="btn btn-info "  CommandName="selectDetalleCompra" CommandArgument="<%# Container.DataItemIndex %>" />
                                                             </ItemTemplate>
                                                          </asp:TemplateField>

                                                          <asp:boundfield DataField="VentaID" HeaderText="VentaID" ></asp:boundfield>
                                                          <asp:boundfield DataField="Fecha" HeaderText="Fecha Compra" ></asp:boundfield>
                                                          <asp:boundfield DataField="FormaPago" HeaderText="Forma de pago" ></asp:boundfield>    
                                                          <asp:boundfield DataField="Precio" HeaderText="Precio Total" ></asp:boundfield>

                                                     </columns>
                                                                                             </asp:gridview> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                     <div id="tab3" class="tab-pane fade in">
									    <div class="row">
                                             
                                            <!-- Panel de reportes realizados por el cliente -->
                                            <div class="content-panel">
                                                <div style="width: 100%; height: 600px; overflow: scroll">
                                                    <asp:gridview ID="gvReportesCompra" EmptyDataText="Por el momento no existen reportes! " EmptyDataRowStyle-ForeColor="Red" EmptyDataRowStyle-BackColor="White" EmptyDataRowStyle-VerticalAlign="Middle" EmptyDataRowStyle-HorizontalAlign="Center" runat="server"  CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
                                                    </asp:gridview> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
    </div>
                   
            
  

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
