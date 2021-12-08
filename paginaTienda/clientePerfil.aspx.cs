using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;

namespace store_BOXLIT.paginaTienda
{
    public partial class clientePerfil : System.Web.UI.Page
    {
        conexionBaseDatos conn = new conexionBaseDatos();
        conexionTablas claseDatos = new conexionTablas();
        conexionTablas dt = new conexionTablas();

        protected void Page_Load(object sender, EventArgs e)
        {
            //TextBox bloqueados
            editarCodigo.ReadOnly = true;
            editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
            editarUserLogin.ReadOnly = true;
            editarUserLogin.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            editarEmail.ReadOnly = true;
            editarEmail.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            editarDNI.ReadOnly = true;
            editarDNI.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            eliminarCliente.ReadOnly = true;
            eliminarCliente.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            detalleCodigoUsuario.ReadOnly = true;
            detalleCodigoUsuario.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            detalleCodigoVenta.ReadOnly = true;
            detalleCodigoVenta.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            detalleFecha.ReadOnly = true;
            detalleFecha.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            detalleFormaPago.ReadOnly = true;
            detalleFormaPago.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;
            detalleAbonado.ReadOnly = true;
            detalleAbonado.ForeColor = ColorTranslator.FromHtml("#756E6C"); editarCodigo.ReadOnly = true;

            string IDVENTA = Request.Params["Ventaid"];
            //Session["UsuarioID"] = 11;

            if (!Page.IsPostBack)
            {
                //Mostrar datos de cliente
                mostrarCliente();

                /* FALTA EDITAR
                //Mostrar listado de compras realizadas por el cliente
                DataTable dtt = new DataTable();
                string query = "SELECT VV.VentaID, VV.Fecha, VV.FormaPago, DV.Precio FROM Venta VV INNER JOIN DetVenta DV ON(VV.VentaID = DV.VentaID)   WHERE VV.UsuarioID ='" + Session["UsuarioID"].ToString() + "' ORDER BY VV.Fecha DESC";
                SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
                SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
                da.Fill(dtt);
                gvDetalleCompra.DataSource = dtt;
                gvDetalleCompra.DataBind();
                conn.CerrarConexion();

                //Mostrar reportes
                mostrarReportesCompra();
                */
            }

        }

        protected void mostrarCliente()
        {
            DataTable dt = new DataTable();
            string query = "SELECT usuarioID, usuarioLogin, usuarioPass, nombre, apellido, email, usuarioEstado FROM Usuarios WHERE usuarioID= '" + Session["usuarioID"].ToString() + "'";
            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvCliente.DataSource = dt;
            gvCliente.DataBind();
            conn.CerrarConexion();
        }

        protected void mostrarReportesCompra()
        {
            /* FALTA EDITAR
            DataTable dt = new DataTable();
            string query = @" select ev.EVID as 'Nro de reporte',ev.Fecha as 'Fecha', ev.motivo as 'Motivo', p.ProductoNombre as 'Producto'  from detventa dt
                                inner join errorventa ev on ev.DetVentaID = dt.DVID
                                inner join Productos p on dt.ProductoID = p.ProductoID
                                WHERE ev.UsuarioID = " + Session["UsuarioID"].ToString() + "Order by ev.EVID desc";
            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvReportesCompra.DataSource = dt;
            gvReportesCompra.DataBind();
            conn.CerrarConexion();
            */
        }

        protected void errorCompra_Click(object sender, EventArgs e)
        {
            //GridViewRow row = gvDetalleCompra.SelectedRow;
            //Response.Redirect("~/PaginaVenta/clienteReporteCompra.aspx?Ventaid=" + row.Cells[1].Text);
            //Response.Write("~/PaginaVenta/clienteReporteCompra.aspx.aspx?Ventaid=" + row.Cells[1].Text);
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/paginaTienda/clientePerfil.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/paginaTienda/clientePerfil.aspx");
        }

        protected void gvCliente_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectCliente")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Referencia a la fila del grid
                GridViewRow row = gvCliente.Rows[rowIndex];
                editarCodigo.Text = row.Cells[1].Text;
                editarNombre.Text = row.Cells[4].Text;
                editarApellido.Text = row.Cells[5].Text;
                editarEmail.Text = row.Cells[6].Text;
                editarUserLogin.Text = row.Cells[2].Text;
                editarUserPassword.Text = row.Cells[3].Text;
                eliminarCliente.Text = row.Cells[2].Text;
            }

            //Mostrar ventana emergente editar cliente
            string script = @"<script type='text/javascript'>$('#miModalEditarUser').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }

        protected void btnActualizarUser_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;

            if (editarUserPassword.Text != "" & editarNombre.Text != "" & editarApellido.Text != "" & editarTelefono.Text != "" & editarProvincia.Text != "")
            {
                string paiss = "Argentina";
                string sql = "UPDATE Usuarios SET Nombres = '" + editarNombre.Text + "', Apellidos='" + editarApellido.Text + "', Telefono='" + editarTelefono.Text + "', Provincia = '" + editarProvincia.Text + "', Pais='" + paiss + "' , UsuarioContraseña = '" + editarUserPassword.Text + "' WHERE UsuarioID = " + code;

                if (claseDatos.modificar(sql))
                {
                    //Mostrar ventana emergente de exito
                    string script = @"<script type='text/javascript'>$('#miModalExitoUser').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }
                else
                {
                    //Mostrar ventana emergente de error
                    string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }
            }
            else
            {
                //Mostrar ventana emergente de error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        protected void btnEliminarUser_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente eliminar
            string scriptModal = @"<script type='text/javascript'>$('#miModalEliminar').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void btnConfirmaEliminar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;
            string sql = "DELETE ProductosCategorias WHERE categoriaID = " + code;

            string passwordeliminar = editarUserPassword.Text;
            if (passwordeliminar == Session["Contraseña"].ToString())
            {
                //Ponemos usuario en estado inactivo                      
                string query = "UPDATE Usuarios SET usuarioEstado ='Inactivo' WHERE usuarioLogin =" + "'" + Session["Usuario"].ToString() + "'";
                if (claseDatos.modificar(query))
                {
                    //Mostrar ventana emergente de exito
                    string script = @"<script type='text/javascript'>$('#miModalExitoEliminar').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);

                }
                else
                {
                    //Mostrar ventana emergente de error
                    string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }
            }
            else
            {
                //Mostrar ventana emergente de error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }

        }

        protected void btnEliminado_Click(object sender, EventArgs e)
        {
            //Cerramos sesion de usuario y redireccionamos
            Session.Abandon();
            Response.Redirect("~/index.aspx");
        }

        protected void gvDetalleCompra_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            /* FALTA EDITAR
            if (e.CommandName == "selectDetalleCompra")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvDetalleCompra.Rows[rowIndex];
                detalleCodigoUsuario.Text = Session["UsuarioID"].ToString();
                detalleCodigoVenta.Text = row.Cells[1].Text;
                detalleFecha.Text = row.Cells[2].Text;
                detalleFormaPago.Text = row.Cells[3].Text;

                //Obtenemos suma total de la orden
                string pago = "SELECT sum(precio*Cantidad) as Totales FROM DetVenta WHERE VentaID= '" + detalleCodigoVenta.Text + "'";
                SqlCommand cmd = new SqlCommand(pago, conn.AbrirConexion());
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read() == true)
                    detalleAbonado.Text = dr[0].ToString();
                conn.CerrarConexion();
                dr.Close();

                //Mostramos productos solo de esa orden
                DataTable dt = new DataTable();
                string query2 = "select dt.DVID as 'Codigo' , P.ProductoNombre as 'Nombre del Producto' , dt.Cantidad, dt.Precio, dt.Precio*dt.Cantidad as SubTotal from Venta v inner join DetVenta dt on dt.VentaID=v.VentaID inner join Productos p on p.ProductoID=dt.ProductoID where v.VentaID='" + detalleCodigoVenta.Text + "'";
                SqlCommand cmd2 = new SqlCommand(query2, conn.AbrirConexion());
                SqlDataAdapter da = new SqlDataAdapter(query2, conn.AbrirConexion());
                da.Fill(dt);
                gvDetalleCliente.DataSource = dt;
                gvDetalleCliente.DataBind();
                conn.CerrarConexion();

                //Mostrar ventana emergente Editar Usuario
                string script = @"<script type='text/javascript'>$('#miModalDetalle').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
            */
        }

        protected void gvDetalleCliente_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            /* FALTA EDITAR
            //string reportProductoID = "";
            if (e.CommandName == "selectReportar")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvDetalleCliente.Rows[rowIndex];

                // En reportProductoID guardo el id del producto que quiero reportar
                Response.Redirect("~/PaginaVenta/clienteReporteCompraRegistro.aspx?reportProductoID=" + row.Cells[1].Text);
            }
            */
        }
    }
}