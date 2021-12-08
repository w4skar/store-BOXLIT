<%@ Page Title="" Language="C#" MasterPageFile="~/indexAdministrador.Master" AutoEventWireup="true" CodeBehind="adminProductos.aspx.cs" Inherits="store_BOXLIT.paginaAdministrador.adminProductos" %>

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
    Productos
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">

    <form id="form1" runat="server">

   <!-- Ventana emergente: Editar producto -->
   <div class="modal fade" id="miModalEditar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Editar producto</h4>
                    </div>
                    <div class="modal-body">

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Codigo del Producto</h4>
                                  <asp:TextBox ID="editarCodigo" runat="server" class="form-control"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Nombre del Producto</h4>
                                  <asp:TextBox ID="editarNombre" runat="server" class="form-control" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Precio Unitario</h4>
                                  <asp:TextBox ID="editarPrecio"  runat="server" class="form-control" onkeypress="javascript:return soloNumeros(event)"></asp:TextBox>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Categoria</h4>
                                  <div class="btn-group">
                                     <asp:DropDownList ID="editarDropCategoria" runat="server"  CssClass="form-control" data-toggle="dropdown" ></asp:DropDownList>
                                  </div>
                            </div>
                            
                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Marca</h4>
                                  <div class="btn-group">
                                     <asp:DropDownList ID="editarDropMarca" runat="server" CssClass="form-control" data-toggle="dropdown" ></asp:DropDownList>
                                  </div>
                            </div>
                        
                    <label style="color:gray; margin:6px; font-style:italic"> NOTA: Si quiere eliminar un producto, primero debe asignar un stock.</label>

                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-theme03" OnClick="btnActualizar_Click" CommandName="selectUpdate" />
                      <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-theme04" OnClick="btnEliminar_Click" />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Agregar producto -->
   <div class="modal fade" id="miModalAgregar" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header" style="height:50px">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" >Agregar nuevo producto</h4>
                    </div>
                    
                      <div class="modal-body">

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Nombre del producto</h4>
                                  <asp:TextBox ID="agregarNombre" runat="server" MaxLength="50" class="form-control" onkeypress="javascript:return soloLetras(event)"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="agregarNombre" ForeColor="Red"  runat="server" ErrorMessage="Debe ingresar un nombre. "></asp:RequiredFieldValidator>--%>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group" style="width:250px">
                                 <h4 class="title" style="font-size:medium">Precio unitario</h4>
                                  <asp:TextBox ID="agregarPrecio" runat="server" MaxLength="6" class="form-control" onkeypress="javascript:return soloNumeros(event)"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="agregarPrecio" ForeColor="Red" ErrorMessage="Debe un ingresar un precio."></asp:RequiredFieldValidator>--%>
                                  <div class="validate"></div>
                            </div>

                            <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Categoria</h4>
                                  <div class="btn-group">
                                     <asp:DropDownList ID="agregarDropCategoria" runat="server" style="width:250px" CssClass="form-control" data-toggle="dropdown" ></asp:DropDownList>
                                     <%--</asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" ControlToValidate="agregarDropCategoria" ErrorMessage="Debe seleccionar una categoria."></asp:RequiredFieldValidator>--%>
                                  </div>
                            </div>
                            
                            <div class="form-group" >
                                 <h4 class="title" style="font-size:medium">Marca</h4>
                                  <div class="btn-group">
                                     <asp:DropDownList ID="agregarDropMarca" runat="server" style="width:250px" CssClass="form-control" data-toggle="dropdown" ></asp:DropDownList>
                                      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="agregarDropMarca" ForeColor="Red" ErrorMessage="Debe seleccionar una marca."></asp:RequiredFieldValidator>--%>
                                  </div>
                            </div>

                          <div class="form-group">
                                 <h4 class="title" style="font-size:medium">Imagen</h4>
                                  <div class="btn-group" style="width:550px">
                                      <!-- Control FileUpload para seleccionar el archivo imagen -->
                                      <asp:FileUpload ID="miArchivo" runat="server" />
                                  </div>
                         </div>
                    
                    <label style="color:gray; margin:6px; font-style:italic"> NOTA: Complete todos los campos. Evite usar acentos, letra ñ o caracteres especiales.</label>

                    </div>

                    <div class="modal-footer">
                      <asp:Label ID="lblModal" ForeColor="Red" runat="server" Text="Label"></asp:Label>
                      <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-theme03" OnClick="btnAgregar_Click" CommandName="selectAgregar" />
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Eliminar producto -->
   <div class="modal fade" id="miModalEliminar" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                       <img src="../img/check_warning.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                       <h4 style="font-size:medium; text-align:center">¿Esta seguro que desea eliminar este producto?</h4>
                        <asp:TextBox ID="eliminarNombreProducto" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnConfirmaEliminar" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnConfirmaEliminar_Click" CommandName="selectUpdate" />
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
                         <h4 style="font-size:medium; text-align:center">Producto registrado con exito!</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnExito" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnExito_Click" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
    </div>

   <!-- Ventana emergente: Confirmacion eliminacion exitosa  -->
   <div class="modal fade" id="miModalEliminarExito" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_ok.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Producto eliminado con exito!</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="Button2" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnExito_Click" CommandName="selectUpdate" />
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
                         <h4 id="errorProd" style="font-size:medium; text-align:center">Ocurrió un error! Complete los datos o intente nuevamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnError" runat="server" Text="Aceptar" OnClick="btnError_Click" CssClass="btn btn-theme03" CommandName="selectUpdate" />
                    </div>
                  </div>
                </div>
   </div>

   <!-- Ventana emergente: Producto existente -->
   <div class="modal fade" id="miModalErrorProd" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="../img/check_error.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 id="errorProdNombre" style="font-size:medium; text-align:center">Ocurrió un error! Ya existe un producto con el mismo nombre.</h4>
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
            <table class="auto-style1">
                <tr>
                    <td>
                        <button type="button" onclick="window.location.href='../indexAdministrador.aspx'" class="btn btn-warning"><i class="fa fa-home"></i> Inicio</button>
                      
                        <asp:Button ID="btnAgregarProducto" runat="server" Text="✚ Nuevo Producto" CssClass="btn btn-theme" OnClick="btnAgregarProducto_Click" />
                        <asp:Button ID="btnStock" runat="server" Text="✚ Asignar stock" CssClass="btn btn-theme" OnClick="btnStock_Click"  />
                          
                        <div class="btn-group">
                            <button type="button" class="btn btn-theme">✚ Agregar</button>
                                <button type="button" class="btn btn-theme dropdown-toggle" data-toggle="dropdown">
                                  <span class="caret"></span>
                                  <span class="sr-only">Toggle Dropdown</span>
                                </button>
                            <ul class="dropdown-menu" role="menu">
                              <li><a href="../paginaAdministrador/adminProductosCategorias.aspx">✚ Categorias</a></li>
                              <li><a href="../paginaAdministrador/adminProductosMarcas.aspx">✚ Marcas</a></li>
                            </ul>
                        </div>
                    </td>
                    <td style="width:85px">
                         <span style="height:30px; cursor:default" class="btn btn-default"> Registros: <asp:Label ID="lblContador" runat="server" ></asp:Label></span>
                    </td>
                </tr>
            </table>

       </div>
   </div>

   <br />
   <!-- Panel gridview productos -->
   <div class="content-panel">
           <!-- Buscador inteligente -->
           <input type="text" id="textBuscar" runat="server" maxlength="50" style=" margin:6px; width:450px"  class="form-control"  onkeyup="buscarGridView(this)" placeholder="Que desea buscar ... " />
           <br /> 

        <div style="width: 100%; height: 900px; overflow: scroll">
            <asp:gridview ID="gvProductos" runat="server" OnRowCommand="gvProductos_RowCommand" AutoGenerateColumns="False" CssClass="table table-striped table-advance table-hover" BorderColor="White" EditRowStyle-BorderColor="White" EmptyDataRowStyle-BorderColor="White" HeaderStyle-BorderColor="White">
             <columns>
                  <asp:TemplateField >
                    <ItemTemplate> 
                        <asp:Button ID="btnEditarProducto" type="button" runat="server" Text="✎ Editar" CssClass="btn btn-theme btn-sm"  CommandName="selectProducto" CommandArgument="<%# Container.DataItemIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:boundfield DataField="productoID" HeaderText="CODIGO" ></asp:boundfield>    
                <asp:boundfield DataField="productoNombre" HeaderText="Nombre del producto" ></asp:boundfield>    
                <asp:boundfield DataField="productoPrecio" HeaderText="Precio unitario" ></asp:boundfield>
                <asp:boundfield DataField="categoriaNombre" HeaderText="Categoria" ></asp:boundfield>    
                <asp:boundfield DataField="marcaNombre" HeaderText="Marca" ></asp:boundfield>
            </columns>
        </asp:gridview> 
        </div>
    </div>

 </form>

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

    <!-- Buscador inteligente en tiempo real de productos -->
    <script type="text/javascript">
      function buscarGridView(strKey) {
                var strData = strKey.value.toLowerCase().split(" ");
                var tblData = document.getElementById("<%=gvProductos.ClientID %>");
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
