<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="store_BOXLIT.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Estilos slider -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server">
  
  <!-- Slider de imagenes/ Banners -->
  <div style=" margin-left: auto; margin-right: auto">
     <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
          <div class="item active">
            <img src="img/slider/1.jpg" alt="Los Angeles" style="width:100%;">
            <div class="carousel-caption">
                <%--<h3>Los Angeles</h3>--%>
                <%--<p>LA is always so much fun!</p>--%>
            </div>
          </div>

          <div class="item">
            <img src="img/slider/2.jpg" alt="Chicago" style="width:100%;">
            <div class="carousel-caption">
                <%--<h3>Chicago</h3>--%>
                <%--<p>Thank you, Chicago!</p>--%>
            </div>
          </div>
    
          <div class="item">
            <img src="img/slider/3.jpg" alt="New York" style="width:100%;">
                <div class="carousel-caption">
                <%--<h3>New York</h3>--%>
                <%--<p>We love the Big Apple!</p>--%>
             </div>
          </div>
    </div>

    <!-- Controles izquierdo y derecho del slider -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  </div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">
  
    <!-- Ponemos en tablas para organizar el contenido -->
    <table id="table">
       <h2 class="product-name"><asp:Label ID="lblNombre" runat="server" Font-Size="Smaller">Ultimos productos agregados</asp:Label></h2>
           <asp:ListView ID="ListView" GroupItemCount="4" runat="server" OnItemCommand="ListView_ItemCommand1">
                                          
               <ItemTemplate>
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">
                                        <td>
                                            <div class="product">
                                                <!-- Vinculamos imagen del producto -->
                                                <div class="product-img">
                                                    <img src='<%# Eval("productoImagenURL") %>' alt="">
                                                    <div class="product-label"></div>
                                                </div>

                                                <!-- Datos del producto -->
                                                <div class="product-body">
                                                    <p class="product-category">BOXLIT Computers</p>
                                                    <h3 class="product-name"><%#Eval("ProductoNombre") %></h3>
                                                    <h4 class="product-price">$<%#Eval("productoPrecio") %><del class="product-old-price"></del></h4>
                                                    
                                                    <!-- Botoneras que aparecen junto al producto -->
                                                    <div class="product-btns">
                                                        <%--<button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>--%>
                                                        <%--<button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>--%>
                                                        <%--<button class="quick-view" ><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>--%>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="btnProd" class="quick-view" CommandArgument='<%# Eval("ProductoID") %>'><i class="fa fa-eye"></i><span class="tooltipp">Ver Detalle</span></asp:LinkButton>
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
