<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="clienteProductos.aspx.cs" Inherits="store_BOXLIT.paginaTienda.clienteProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server">
    <img src="../img/banProductos.jpg" style="width:100%" />
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">
    
   <!-- Productos a mostrar en la web principal--> 
   <table id="table">
       <asp:ListView ID="lvProductos" GroupItemCount="4" runat="server" OnItemCommand="lvProductos_ItemCommand">
          <ItemTemplate>
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">
                                        <td>
                                            <div class="product">
                                                <div class="product-img">
                                                    <img src='<%# Eval("productoImagenURL") %>' alt="">
                                                    <div class="product-label">
                                                    </div>
                                                </div>
                                                <div class="product-body">
                                                    <p class="product-category">BOXLIT Computers</p>
                                                    <h3 class="product-name"><%#Eval("productoNombre") %></h3>
                                                    <h4 class="product-price">$<%#Eval("productoPrecio") %><del class="product-old-price"></del></h4>
                                                    <div class="product-btns">
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="btnProd" class="quick-view" CommandArgument='<%# Eval("productoID") %>'><i class="fa fa-eye"></i><span class="tooltipp">Ver Detalle</span></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>

          <GroupTemplate>
                    <tr>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                    </tr>
          </GroupTemplate>

          <LayoutTemplate>
                    <table class="table" >
                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder" />
                    </table>
           </LayoutTemplate>
       </asp:ListView>
    </table>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">
</asp:Content>
