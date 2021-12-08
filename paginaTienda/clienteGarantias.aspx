<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="clienteGarantias.aspx.cs" Inherits="store_BOXLIT.paginaTienda.clienteGarantias" %>

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
						<img src="../img/wallpapers/support.jpg" style="-webkit-filter: grayscale(100%); filter: grayscale(100%);" alt="" class="auto-style3">
					</div>
				</div>

				<div class="col-md-8 p-b-30">
					<%--<h2 class="product-name">
                             <asp:Label ID="lblNombre" runat="server" Text="">Nuestra Historia</asp:Label>
					     </h2>--%>
					<p class="p-b-28" style="text-align:justify">
						<h3> Garantias </h3>

						La garantía de los productos vendidos por BOXLIT Computers se rige por el Real Decreto Legislativo 1/2007, de 16 de noviembre, de garantías en la Venta de Bienes de Consumo, marco legal que tiene por objeto facilitar al consumidor distintas opciones para exigir el saneamiento cuando el bien adquirido no sea conforme con el contrato.
						De forma general la garantía para los consumidores finales es de dos años a partir del día de la entrega.
					</p>

					<p class="p-b-28">
                        &nbsp;</p>
                    <p class="p-b-28" style="text-align:justify">
						Sin embargo, cuando la falta de conformidad se manifiesta con posterioridad a los 6 meses y en casos dudosos, el fabricante se reserva el derecho de exigir un informe pericial independiente para tramitar la garantía. En casos obvios de mal funcionamiento en período de garantía no hay ningún tipo de problema.
						En cualquier caso, durante el tiempo que el consumidor se vea privado del producto se suspende el cómputo del plazo de la garantía.
						Los fabricantes pueden ofrecer garantías adicionales, cuya extensión y duración difieren según los productos y las marcas. Dichas garantías serán exclusivamente de cargo del fabricante que se obliga a ellas. Siempre se deberá hacer siguiendo las instrucciones indicadas por BOXLIT Computers, previa solicitud y aceptación.
						Los gastos de envío generados por la tramitación de la garantía del producto serán gratuitos para el cliente en aquellos casos donde se supone que la falta de conformidad existe en el bien adquirido.                        
                    <br />

					</p>
				</div>
			</div>
		</div>
	</section>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">
</asp:Content>
