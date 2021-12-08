<%@ Page Title="" Language="C#" MasterPageFile="~/indexTienda.Master" AutoEventWireup="true" CodeBehind="clienteNosotros.aspx.cs" Inherits="store_BOXLIT.paginaTienda.clienteNosotros" %>


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
    <img src="../img/banNosotros.jpg" style="width:100%" />
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="regionContenido" runat="server">
    
    <section class="bgwhite p-t-66 p-b-38">
		<div class="container">
			<div class="row">
				<div class="col-md-4 p-b-30">
					<div class="hov-img-zoom">
						<img src="../img/wallpapers/img_nosotros.jpg" style="-webkit-filter: grayscale(100%); filter: grayscale(100%);" alt="" class="auto-style3">
					</div>
				</div>

				<div class="col-md-8 p-b-30">
					<%--<h2 class="product-name">
                             <asp:Label ID="lblNombre" runat="server" Text="">Nuestra Historia</asp:Label>
					     </h2>--%>
					<p class="p-b-28" style="text-align:justify">
                        Con más de 10 años de experiencia y junto con una gran experiencia profesional y un equipo de trabajo, nos dedicamos principalmente al e-Commerce de Productos Tecnológicos en Hardware y Periféricos High End, ofreciendo así las mejores marcas y especializándonos en el ensamble profesional de los mejores equipos para Entusiastas, Gamers y Profesionales, adaptando cada sistema a sus necesidades y entregando las últimas tecnologías tan pronto como estén disponibles, cubriendo así todas sus necesidades de Calidad, Confiabilidad y Rendimiento Extremo.
                        
					</p>
                    <p class="p-b-28">
                        &nbsp;</p>
                    <p class="p-b-28" style="text-align:justify">
                        BOXLIT, proviene del idioma Uzbeko, cuyo significando es Caja de Luz y este nombre fue dado porque creemos que cada PC personalizada merece tener su marca y algo significativo que la haga destacar del resto. De esta forma, nos definimos simplemente como Personalización de Case, ya que todo se reduce a toda la Potencia Extrema que se almacena en el interior.
                    <br />

					</p>

					<div class="bo13 p-l-29 m-l-9 p-b-10">
						<p class="p-b-11">
                        
                            &nbsp;<p class="p-b-11">
                        
                        El espacio perfecto para aquellos usuarios que buscan equipos con calidad, confiabilidad y rendimiento extremo. ¡Buscas Potencia, Busca BOXLIT!.</div>
				</div>
			</div>
		</div>
	</section>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="regionScripts" runat="server">
</asp:Content>
