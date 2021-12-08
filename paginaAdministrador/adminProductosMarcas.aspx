<%@ Page Title="" Language="C#" MasterPageFile="~/indexAdministrador.Master" AutoEventWireup="true" CodeBehind="adminProductosMarcas.aspx.cs" Inherits="store_BOXLIT.paginaAdministrador.adminProductosMarcas" %>

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
    Marcas
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">
    
 <form id="form1" runat="server">

   <!-- Ventana emergente: Editar marca -->
   <div class="modal fade" id="miModalEditarMarca" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Editar Marca</h4>
                    </div>
                    <div class="modal-body">

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Código de la Marca</h4>
                                  <asp:TextBox ID="editarCodigo" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Nombre de la Marca</h4>
                                  <asp:TextBox ID="editarNombre" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Descripción</h4>
                                  <asp:TextBox ID="editarDescripcion" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>
                     
                    <label style="color:gray; margin:6px; font-style:italic"> NOTA: Modifique los campos que desee. Evite usar acentos, letra ñ o caracteres especiales.</label>

                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-theme03" OnClick="btnActualizar_Click" />
                      <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-theme04" OnClick="btnEliminar_Click"/>
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Eliminar marca -->
  <div class="modal fade" id="miModalEliminar" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                       <img src="../img/check_warning.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                       <h4 style="font-size:medium; text-align:center">¿Esta seguro que desea eliminar esta marca?</h4>
                        <asp:TextBox ID="eliminarNombreMarca" runat="server" class="form-control"></asp:TextBox>
                    </div>

                    <div class="modal-footer">
                      <asp:Button ID="btnConfirmaEliminar" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnConfirmaEliminar_Click" CommandName="selectUpdate" />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Agregar marca -->
   <div class="modal fade" id="miModalAgregarMarca" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" >Agregar nueva marca</h4>
                    </div>
                    <div class="modal-body">

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Nombre de la Marca</h4>
                                  <asp:TextBox ID="agregarNombre" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Descripción</h4>
                                  <asp:TextBox ID="agregarDescripcion" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

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

   <!-- Ventana emergente: Confirmacion de error de nombre de marca existente -->
   <div class="modal fade" id="miModalErrorMarca" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Ocurrió un error! El nombre ingresado de la marca ya existe.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="Button1" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
    </div>

   <!-- Panel botones externos -->
   <div class="content-panel">
       <div style="margin:6px">
            <table class="auto-style1" >
                <tr>
                    <td>
                        <button type="button" onclick="window.location.href='../paginaAdministrador/adminProductos.aspx'" class="btn btn-warning"><i class="fa fa-reply"></i> Volver</button>
                        <asp:Button ID="btnAgregarMarca" runat="server" Text="✚ Nueva marca" CssClass="btn btn-theme" OnClick="btnAgregarMarca_Click" />
                    </td>
                    <td style="width:85px">
                        <span style="height:30px; cursor:default" class="btn btn-default"> Registros: <asp:Label ID="lblContador" runat="server" ></asp:Label></span>
                    </td>
                </tr>
            </table>
       </div>
   </div>

   <br />
   <!-- Panel gridview marcas -->
   <div class="content-panel">
            <!--  Buscador inteligente -->
           <input type="text" id="textBuscar" runat="server" maxlength="50" style=" margin:6px; width:450px"  class="form-control"  onkeyup="buscarGridView(this)" placeholder="Que desea buscar ... " />
           <br />

        <div style="width: 100%; height: 800px; overflow: scroll">
            <asp:gridview ID="gvMarcas" runat="server" OnRowCommand="gvMarcas_RowCommand" AutoGenerateColumns="False" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
             <columns>

                <asp:TemplateField >
                    <ItemTemplate> 
                        <asp:Button ID="btnEditarMarca" type="button" runat="server" Text="✎ Editar" CssClass="btn btn-theme btn-sm"  CommandName="selectMarca" CommandArgument="<%# Container.DataItemIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:boundfield DataField="marcaID" HeaderText="CODIGO" ></asp:boundfield>    
                <asp:boundfield DataField="marcaNombre" HeaderText="Nombre de la marca" ></asp:boundfield>    
                <asp:boundfield DataField="marcaDescripcion" HeaderText="Descripcion general" ></asp:boundfield>
            </columns>
        </asp:gridview> 
        </div>
    </div>

 </form>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">

   <!-- Buscador inteligente en tiempo real de marcas -->
   <script type="text/javascript">
      function buscarGridView(strKey) {
                var strData = strKey.value.toLowerCase().split(" ");
                var tblData = document.getElementById("<%=gvMarcas.ClientID %>");
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

</asp:Content>
