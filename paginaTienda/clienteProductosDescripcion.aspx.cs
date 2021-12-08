using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace store_BOXLIT.paginaTienda
{
    public partial class clienteProductosDescripcion : System.Web.UI.Page
    {
		conexionTablas claseDatos = new conexionTablas();

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Request.QueryString["Id"] != null)
					Bind();
				else
					Response.Redirect("~/index.aspx");
			}
		}

		protected void Bind()
		{
			DataTable tabla = claseDatos.consultaTablaConUnSQL("SELECT P.productoNombre, P.productoPrecio, C.categoriaNombre, M.marcaNombre, P.productoImagenURL, DP.depoStock FROM Productos P " +
		    "INNER JOIN ProductosCategorias C ON (C.categoriaID = P.categoria)"+
			"INNER JOIN ProductosMarcas M ON (M.marcaID = P.marca)" +
			"INNER JOIN DepositosProductos DP ON (DP.productoID = P.productoID) WHERE P.productoID = " + Request.QueryString["Id"]);

			ViewState["precio"] = tabla.Rows[0]["productoPrecio"].ToString();
			ViewState["prodName"] = tabla.Rows[0]["productoNombre"].ToString();

			lblNombre.Text += "" + tabla.Rows[0]["productoNombre"].ToString() + "<br />";
			lblPrecio.Text += "" + tabla.Rows[0]["productoPrecio"].ToString() + "<br />";
			lblCategoria.Text += "" + tabla.Rows[0]["categoriaNombre"].ToString() + "<br />";
			lblMarca.Text += "" + tabla.Rows[0]["marcaNombre"].ToString();
			lblStock.Text += "" + tabla.Rows[0]["depoStock"].ToString();
			ImageP.ImageUrl = tabla.Rows[0]["productoImagenURL"].ToString();
		}

		protected void BtnComprar_Click(object sender, EventArgs e)
		{
		}
			/*
			protected void BtnComprar_Click(object sender, EventArgs e)
			{
				if (Session["UsuarioID"] != null)
				{
					DataTable carritoexiste = claseDatos.consultaTablaConUnSQL("IF EXISTS (SELECT * FROM CarritoCompras CC INNER JOIN Usuarios U ON U.UsuarioID = CC.UsuarioID INNER JOIN Productos P ON P.ProductoID = CC.ProductoID WHERE CC.Estado = 0 AND P.ProductoNombre = '" + ViewState["prodName"].ToString() + "' AND CC.UsuarioID = " + Session["UsuarioID"].ToString() + ") BEGIN  SELECT 1 as Resp END ELSE BEGIN SELECT 0 as Resp END");
					if (carritoexiste.Rows[0]["Resp"].ToString() == "0")
					{
						try
						{
							if (Convert.ToInt32(spCantidad.Text) <= Convert.ToInt32(lblStock.Text) && Convert.ToInt32(spCantidad.Text) > 0)
							{
								lblMarca.Text = "INSERT INTO CarritoCompras VALUES (" + Session["UsuarioID"].ToString() + ", " + Request.QueryString["Id"] + ", " + spCantidad.Text + ", 0,'" + ViewState["precio"].ToString().Replace(',', '.') + "')";

								//Conexion a la base de datos INSERT
								string cadena = ("Data Source=34.74.72.235;Initial Catalog=boxlit;Persist Security Info=True;User ID=sa;Password=SQLucasal2019.");
								SqlConnection cn;
								DataSet ds = new DataSet();
								SqlCommand comando;
								cn = new SqlConnection(cadena);
								cn.Open();
								string sql = "INSERT INTO CarritoCompras VALUES (" + Session["UsuarioID"].ToString() + ", " + Request.QueryString["Id"] + ", '" + spCantidad.Text + "', 0,'" + ViewState["precio"].ToString().Replace(',', '.') + "')";
								comando = new SqlCommand(sql, cn);
								int i = comando.ExecuteNonQuery();
								cn.Close();

								if (i > 0)
								{
									Response.Redirect("~/PaginaTienda/clienteCarritoCompras.aspx");
								}
								else
								{
									Response.Write("<script>alert('Algo salio mal');</script>");
								}
								//Termina la conexion
							}
							else
							{
								Response.Write("<script>alert('El campo cantidad no puede ser cero, vacío, negativo o mayor al stock');</script>");
							}
						}
						catch
						{
							Response.Write("<script>alert('El campo cantidad no puede ser cero, vacío, negativo o mayor al stock');</script>");
						}
					}
					else
					{
						//Response.Write("<script>alert('Este producto ya se encuentra en su carrito de compras');</script>");
						Response.Redirect("~/PaginaTienda/clienteCarritoCompras.aspx");
					}
				}
				else
				{
					Response.Redirect("~/loginUsuarios.aspx");
				}
			}

			*/

			protected void seguirComprando_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/index.aspx");
		}

		protected void verCarrito_Click(object sender, EventArgs e)
		{
			Response.Redirect("paginaTienda/clienteCarritoCompras.aspx");
		}

		protected void btnSeguirComprando_ServerClick(object sender, EventArgs e)
		{
			Response.Redirect("~/index.aspx");

		}
	}
}