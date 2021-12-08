<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="clienteProductosDescripcion.aspx.cs" Inherits="store_BOXLIT.paginaTienda.clienteProductosDescripcion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            width: 604px;
        }
        .auto-style4 {
            width: 604px;
            text-align: center;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server">
    <img src="../img/banDescripcion.jpg" style="width:100%" />
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">

   <div class="section">
	    <div class="container">
	        <div class="row">
                <table class="nav-justified">
                        <tr>
                            <td class="auto-style4">
                                <!-- Imagen del producto -->
                                  <asp:Image ID="ImageP" ImageUrl=".." runat="server" Height="300px" Width="300px" />
                            </td>
                            <td>
                                <!-- Detalles del producto -->
                                <h2 class="product-name">
                                 <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
					            </h2>

                                 <!-- Puntuacion del producto -->
                                <div>
								    <div class="product-rating">
									    <i class="fa fa-star"></i>
									    <i class="fa fa-star"></i>
									    <i class="fa fa-star"></i>
									    <i class="fa fa-star"></i>
									    <i class="fa fa-star-o"></i>
								    </div>
							    </div><br />

                                <div class="product-details">
								    <h3 class="product-price">$<asp:Label ID="lblPrecio" runat="server" Text=""></asp:Label> </h3>
								    <span class="product-available">En Stock</span>
							    </div><br />

                                <!-- Cantidad del Producto -->
                               <div class="product-details">
                                 <div class="add-to-cart">
                                    <div class="qty-label">Cantidad
									    <div class="input-number">
                                            <%--<input id="spinnerCantidad" name="value" type="number" runat="server"  min="1" >--%>
                                            <asp:TextBox ID="spCantidad" TextMode="Number" runat="server" class="form-control" min="1" MaxLength="5" onkeypress="return validarNumerosPositivos(event)" oninput="if(this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"></asp:TextBox>
                                            <%--<input id="Number1" name="value" type="number" runat="server" style="height:25px; width:40px; text-align:center">--%>
									    </div>
								    </div><br /><br />
                                     <button runat="server" id="btnComprar" style="font-size:smaller" class="add-to-cart-btn" onserverclick="BtnComprar_Click" ><i class="fa fa-cart-plus"></i>Agregar al carrito</button>
                                     <button runat="server" id="btnSeguirComprando" style="font-size:smaller" class="add-to-cart-btn" onserverclick="btnSeguirComprando_ServerClick" ><i class="fa fa-backward"></i>Volver</button>

                                </div>
                              </div>
                               
                                <!-- Referencias del producto -->
                                <div class="product-details">
                                 <ul class="product-links">
								    <li style="font-weight:bold">Categoria:</li>
								    <li><asp:Label ID="lblCategoria" runat="server" Text=""></asp:Label></li>
                                </ul>
                                <ul class="product-links">
								    <li style="font-weight:bold">Marca:</li>
								    <li><asp:Label ID="lblMarca" runat="server" Text=""></asp:Label></li>
                                </ul>
                                <ul class="product-links">
								    <li style="font-weight:bold">Stock:</li>
								    <li><asp:Label ID="lblStock" runat="server" Text=""></asp:Label></li>
                                </ul>
                                <ul class="product-links">
								    <li style="font-weight:bold">Garantia:</li>
								    <li>6 Meses</li>
                                </ul><br />
                           </div>
                            </td>
                        </tr>
                 </table>
			</div>
		</div>
   </div>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">

     <!-- Control de numeros positivos con selector mas/menos --> 
     <script type="text/javascript">
       function validarNumerosPositivos(evt) {
           var charCode = (evt.which) ? evt.which : event.keyCode;
           return !(charCode > 31 && (charCode < 48 || charCode > 57));
       } 
     </script>

</asp:Content>
