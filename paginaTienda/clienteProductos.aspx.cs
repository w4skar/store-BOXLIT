using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases;
using System.Data;

namespace store_BOXLIT.paginaTienda
{
    public partial class clienteProductos : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();

        protected void Page_Load(object sender, EventArgs e)
        {
            mostrarlvProductos();
        }

        private void mostrarlvProductos()
        {
            DataTable tablaV = claseDatos.consultaTablaConUnSQL("SELECT P.productoID, P.productoNombre, P.productoPrecio, P.productoImagenURL FROM Productos P");

            lvProductos.DataSource = tablaV;
            lvProductos.DataBind();
        }
        protected void lvProductos_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "btnProd")
            {
                string CategoriaID = ((LinkButton)e.CommandSource).CommandArgument;
                Response.Redirect("~/paginaTienda/clienteProductosDescripcion.aspx?Id=" + CategoriaID);
            }
        }
    }
}