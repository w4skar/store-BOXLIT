<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="clientePedidoInfo.aspx.cs" Inherits="store_BOXLIT.paginaTienda.clientePedidoInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

       <!-- Dimensionamos tamaño de la imagen lateral izquierda -->
    <style type="text/css">
        .auto-style3 {
            width: 280px;
            height: 384px;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="regionTitulo" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">

   <section class="bgwhite p-t-66 p-b-38">
		<div class="container">
			<div class="row">
				<div class="col-md-4 p-b-30">
					<div class="hov-img-zoom">
						<img src="../img/wallpapers/box.jpg" style="-webkit-filter: grayscale(100%); filter: grayscale(100%);" alt="" class="auto-style3">
					</div>
				</div>

				<div class="col-md-8 p-b-30">
					<%--<h2 class="product-name">
                             <asp:Label ID="lblNombre" runat="server" Text="">Nuestra Historia</asp:Label>
					     </h2>--%>
					<p class="p-b-28" style="text-align:justify">
						<h3> Mi pedido </h3>

						Básicamente el plazo viene determinado por el indicador de disponibilidad de los componentes adquiridos. Si por ejemplo, hacemos un pedido de un procesador, una placa base y unas memorias RAM, habrá que ver cual de estos artículos tiene el plazo de disponibilidad mayor y ese será el plazo final para la entrega del pedido.                        
					</p>
                    <p class="p-b-28">
                        &nbsp;</p>
                    <p class="p-b-28" style="text-align:justify">
						Para los pedidos de equipos completos, el plazo estimado es de un máximo de 7 días laborales ya que algunos componentes pueden tener un plazo de disponibilidad de hasta 5 días laborales y además hay que sumar montaje y testeo del equipo. El proceso anteriormente descrito, normalmente suele llevar unos 5-6 días a lo que hay que sumar también las 24 horas del envío.                    <br />

					</p>

				</div>
			</div>
		</div>
   </section>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">
</asp:Content>
