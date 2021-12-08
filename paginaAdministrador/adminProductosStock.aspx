<%@ Page Title="" Language="C#" MasterPageFile="~/indexAdministrador.Master" AutoEventWireup="true" CodeBehind="adminProductosStock.aspx.cs" Inherits="store_BOXLIT.paginaAdministrador.adminProductosStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
    <!-- Estilos para ventana emergente (modal) -->
    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server">
    Asignación de stock
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">

  <form id="form1" runat="server">

   <!-- Ventana emergente: Asignacion de stock de un producto -->
   <div class="modal fade" id="miModalAsignarStock" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Asignación de stock</h4>
                    </div>
                    <div class="modal-body">

                         <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Código del producto</h4>
                                  <asp:TextBox ID="editarCodigo" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

                         <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Nombre</h4>
                                  <asp:TextBox ID="agregarNombre" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                         </div>

                         <div class="form-group">
                           <h4 class="title" style="font-size:medium; margin:3px"> Depósito</h4>
                                  <asp:TextBox ID="agregarDeposito" runat="server" class="form-control"></asp:TextBox>
                           <div class="validate"></div>
                         </div>
                                                                          
                         <div class="form-group" >
                                 <h4 class="title" style="font-size:medium">Ingrese cantidad (stock)</h4>
                                 <asp:TextBox ID="agregarStock" runat="server" Width="200px" class="form-control" MaxLength="4"  onkeypress="javascript:return controlNumeros(event)"></asp:TextBox>
                                 <div class="validate"></div>
                       </div>

                       <div class="modal-footer">
                            <asp:Button ID="btnStock" runat="server" Text="Asignar stock" CssClass="btn btn-theme03" OnClick="btnStock_Click" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                            <asp:Label ID="lblResp" runat="server" Visible="False"></asp:Label><br />
                        </div>
                    </div>
                    </div>
                </div>
    </div>

   <!-- Ventana emergente: Mostrar stocks asignados -->
   <div class="modal fade" id="miModalStock" tabindex="-1" role="dialog" aria-hidden="true" >
                <div class="modal-dialog" style="width:900px" >
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title">Stock de productos</h4>
                    </div>
                    <div class="modal-body" >

                        <!-- Buscador inteligente -->
                       <input type="text" id="textBuscarModal" runat="server" maxlength="50" style=" margin:6px; width:450px"  class="form-control"  onkeyup="buscarGridViewModal(this)" placeholder="Que desea buscar ... " />
                       <br />
                         
                         <div class="content-panel">
                            <div style="width: 100%; height: 350px; overflow: scroll">
                               <asp:GridView ID="gvStockModal" runat="server" AutoGenerateColumns="false" AutoGenerateSelectButton="False" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
                                <Columns>
                                    <asp:BoundField DataField="depoID" HeaderText="CODIGO" />
                                    <asp:BoundField DataField="depositoNombre" HeaderText="Deposito" />
                                    <asp:BoundField DataField="productoNombre" HeaderText="Nombre del producto" />
                                    <asp:BoundField DataField="depoStock" HeaderText="Stock actual" />                                    
                               </Columns>
                               </asp:GridView><br />
                            </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                       <asp:Button ID="btnCerrarBusqueda" class="btn btn-default" runat="server" Text="Volver"  />
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

   <!-- Panel botones externos -->
   <div class="content-panel">
       <div style="margin:6px">
            <button type="button" onclick="window.location.href='../paginaAdministrador/adminProductos.aspx'" class="btn btn-warning"><i class="fa fa-reply"></i> Volver</button>
             <asp:Button ID="btnMostrarExistencias" runat="server" Text="✚ Mostrar stock" CssClass="btn btn-theme" OnClick="btnMostrarExistencias_Click" />
           </div>
   </div>
   <br />

   <!-- Gridview: Detalle de stock -->
   <div class="content-panel">
         <!-- Buscador inteligente -->
           <input type="text" id="textBuscar" runat="server" maxlength="50" style=" margin:6px; width:450px"  class="form-control"  onkeyup="buscarGridView(this)" placeholder="Que desea buscar ... " />
           <br />

    <div style="width: 100%; height: 700px; overflow: scroll">
        <asp:GridView ID="gvStock" runat="server"  OnRowCommand="gvStock_RowCommand" AutoGenerateColumns="False" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">         
            <Columns>
                 <asp:TemplateField >
                    <ItemTemplate> 
                        <asp:Button ID="btnAsignarStock" type="button" runat="server" Text="✎ Asignar Stock" CssClass="btn btn-theme btn-sm" CommandName="selectStock" CommandArgument="<%# Container.DataItemIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="productoID" HeaderText="CODIGO" />
                <asp:BoundField DataField="productoNombre" HeaderText="Nombre del producto" />
                <asp:BoundField DataField="categoriaNombre" HeaderText="Categoria" />
                <asp:BoundField DataField="marcaNombre" HeaderText="Marca" />     
           </Columns>
        </asp:GridView>
    </div>
    </div>

    </form>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">
    
    <!--  Control para que se ingrese solo numeros positivos -->
    <script type="text/javascript">
     function controlNumeros(e){
	     var key = window.Event ? e.which : e.keyCode
	     return (key >= 48 && key <= 57)
        }
    </script>

    <!-- Buscador inteligente en tiempo real de stock modal 1 -->
    <script type="text/javascript">
            function buscarGridView(strKey) {
                var strData = strKey.value.toLowerCase().split(" ");
                var tblData = document.getElementById("<%=gvStock.ClientID %>");
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

    <!-- Buscador inteligente en tiempo real de stock modal 2 -->
    <script type="text/javascript">
        function buscarGridViewModal(strKey) {
                var strData = strKey.value.toLowerCase().split(" ");
                var tblData = document.getElementById("<%=gvStockModal.ClientID %>");
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
