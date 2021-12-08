using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace store_BOXLIT.paginaAdministrador
{
    public partial class adminProductosStock : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        conexionBaseDatos conn = new conexionBaseDatos();
        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
           // if (Session["UsuarioID"] != null)
            //{
                //TextBox bloqueados
                editarCodigo.ReadOnly = true;
                editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
                agregarNombre.ReadOnly = true;
                agregarNombre.ForeColor = ColorTranslator.FromHtml("#756E6C");
                agregarDeposito.ReadOnly = true;
                agregarDeposito.ForeColor = ColorTranslator.FromHtml("#756E6C");

                if (!IsPostBack)
                {
                    //Mostrar grid de stock
                    mostrarProductos();

                    //Cargar deposito
                    string dep = "SELECT depositoNombre FROM Depositos WHERE depositoID='" + 1 + "'";
                    SqlCommand cmd = new SqlCommand(dep, conn.AbrirConexion());
                    SqlDataReader dr;
                    dr = cmd.ExecuteReader();
                    while (dr.Read() == true)
                        agregarDeposito.Text = dr[0].ToString(); //Pongo BOXLIT COMPUTERS SALTA sino usar un dropdown
                    conn.CerrarConexion();
                    dr.Close();

                    //Mostrar productos con stock en ventana emergente (modal)
                    conn.CerrarConexion();
                    string query = "SELECT depoID, DD.depositoNombre, PP.productoNombre, DP.depoStock FROM DepositosProductos DP "+
                    "INNER JOIN Depositos DD ON (DP.depositoID = DD.depositoID) "+
                    "INNER JOIN Productos PP ON (DP.productoID = PP.productoID) ORDER BY depoID DESC";

                    SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    this.gvStockModal.DataSource = dt;
                    this.gvStockModal.DataBind();
                    conn.CerrarConexion();
                }
           // }
            //else
              //  Response.Redirect("~/loginUsuarios.aspx");
        }

        protected void mostrarProductos()
        {
            string query = "SELECT P.productoID, P.productoNombre, C.categoriaNombre, M.marcaNombre FROM Productos P " +
            "INNER JOIN ProductosCategorias C ON (C.categoriaID = P.categoria)" +
            "INNER JOIN ProductosMarcas M ON (M.marcaID = P.marca) ORDER BY P.productoID DESC";

            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvStock.DataSource = dt;
            gvStock.DataBind();
            conn.CerrarConexion();
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductosStock.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductosStock.aspx");
        }

        protected void gvStock_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectStock")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Referencia a la fila del grid
                GridViewRow row = gvStock.Rows[rowIndex];
                editarCodigo.Text = row.Cells[1].Text;
                agregarNombre.Text = row.Cells[2].Text;

                //Traer stock del producto
                string dep = "SELECT depoStock FROM DepositosProductos WHERE productoID='" + editarCodigo.Text + "'";
                SqlCommand cmd = new SqlCommand(dep, conn.AbrirConexion());
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read() == true)
                    agregarStock.Text = dr[0].ToString();
                conn.CerrarConexion();
                dr.Close();
            }

            //Mostrar ventana emergente editar stock
            string script = @"<script type='text/javascript'>$('#miModalAsignarStock').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }

        protected void btnStock_Click(object sender, EventArgs e)
        {
            string codeProducto = editarCodigo.Text;

            if (agregarStock.Text != "")
            {
                //Verifico existencias
                DataTable ProdDepMejorado = claseDatos.consultaTablaConUnSQL("IF EXISTS (SELECT *FROM DepositosProductos WHERE depoID = "+ 1 +" AND productoID = "+ codeProducto +") BEGIN SELECT 1 AS Resp END ELSE BEGIN SELECT 0 AS Resp END");

                foreach (DataRow row in ProdDepMejorado.Rows)
                {
                    lblResp.Text = row["Resp"].ToString();

                    if (Convert.ToInt32(row["Resp"]) == 1)
                    {
                        if (claseDatos.modificar("UPDATE DepositosProductos SET depoStock = " + agregarStock.Text + " WHERE depoID = " + 1 +
                            " AND productoID = " + codeProducto + ""))
                        {
                            //Mostrar ventana emergente de exito
                            string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                        }
                    }
                    else
                    {
                        if (claseDatos.insertar("INSERT INTO DepositosProductos VALUES(" + 1 + "," + codeProducto + "," + agregarStock.Text + ", " + 0 + ")"))
                        {
                            //Mostrar ventana emergente de exito
                            string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                        }
                    }
                }
            }
            else
            {
                //Mostrar ventana emergente de error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        protected void btnMostrarExistencias_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente stocks
            string script = @"<script type='text/javascript'>$('#miModalStock').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }
    }
}