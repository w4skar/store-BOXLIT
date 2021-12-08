using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases; //Importamos nuestra clase 
using System.Data;

namespace store_BOXLIT
{
    public partial class index : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();

        protected void Page_Load(object sender, EventArgs e)
        {
            BindListView();
        }

        private void BindListView() 
        {
            DataTable tablaV = claseDatos.consultaTablaConUnSQL("SELECT P.productoID, P.productoNombre, P.productoPrecio, P.productoImagenURL FROM Productos P "+
            "INNER JOIN DepositosProductos DP ON P.productoID = DP.productoID WHERE (DP.depoStock - DP.depoStockOrden) > 0 "+
            "GROUP BY P.productoID, P.productoNombre, P.productoPrecio, P.productoImagenURL ORDER BY P.productoID DESC ");

            ListView.DataSource = tablaV;
            ListView.DataBind();
        }

        protected void ListView_ItemCommand1(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "btnProd")
            {
                string CategoriaID = ((LinkButton)e.CommandSource).CommandArgument;
                //Response.Redirect("~/Admin/DescripcionProducto.aspx?Id=" + CategoriaID);
                Response.Redirect("paginaTienda/clienteProductoDescripcion.aspx?Id=" + CategoriaID);
            }
        }
    }
}