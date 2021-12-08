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
using System.Text.RegularExpressions;
using System.Text;

namespace store_BOXLIT.paginaAdministrador
{
    public partial class adminProveedores : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        conexionBaseDatos conn = new conexionBaseDatos();
        DataTable dt = new DataTable();

        //Procedimiento almacenado: Existencia de proveedor 
        static Int32 existenciaProveedorRegistrado(String proved)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("existenciaProveedorRegistrado", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@prov", proved));

                //Creacion del parametro de salida ResultadoSP
                SqlParameter ResultadoSp = new SqlParameter("@resultado", System.Data.DbType.Int16);
                ResultadoSp.Direction = System.Data.ParameterDirection.Output;
                cmd1.Parameters.Add(ResultadoSp);

                conn.Open();
                cmd1.ExecuteNonQuery();
                Int32 ResultadoExistProv = int.Parse(cmd1.Parameters["@resultado"].Value.ToString());
                conn.Close();

                return ResultadoExistProv;
            }
        }

        //Procedimiento almacenado: Existencia de email de proveedor 
        static Int32 existenciaEmailProveedor(String emailproved)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("existenciaEmailProveedorRegistrado", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@emailprov", emailproved));

                //Creacion del parametro de salida ResultadoSP
                SqlParameter ResultadoSp = new SqlParameter("@resultado", System.Data.DbType.Int16);
                ResultadoSp.Direction = System.Data.ParameterDirection.Output;
                cmd1.Parameters.Add(ResultadoSp);

                conn.Open();
                cmd1.ExecuteNonQuery();
                Int32 ResultadoExistEmailProv = int.Parse(cmd1.Parameters["@resultado"].Value.ToString());
                conn.Close();

                return ResultadoExistEmailProv;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
           // if (Session["UsuarioID"] != null)
            //{
                //TextBox bloqueados
                editarCodigo.ReadOnly = true;
                editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
                eliminarNombreProveedor.ReadOnly = true;
                eliminarNombreProveedor.ForeColor = ColorTranslator.FromHtml("#756E6C");

                if (!IsPostBack)
                {
                    //Mostrar grid de proveedores
                    mostrarProveedores();

                    //Contador de registros
                    string query = "SELECT count(proveedorID) FROM Proveedores";
                    SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read() == true)
                        lblContador.Text = dr[0].ToString();
                    conn.CerrarConexion();
                    dr.Close();

                }
           // }
            //else
              //  Response.Redirect("~/loginUsuarios.aspx");

        }

        protected void mostrarProveedores()
        {
            string query = "SELECT proveedorID, proveedorNombre, proveedorCUIT, proveedorEmail, proveedorProvincia FROM Proveedores ORDER BY proveedorID DESC";
            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvProveedores.DataSource = dt;
            gvProveedores.DataBind();
            conn.CerrarConexion();
        }
        protected void gvProveedores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectProveedor")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Referencia a la fila del grid
                GridViewRow row = gvProveedores.Rows[rowIndex];
                editarCodigo.Text = row.Cells[1].Text;
                editarNombre.Text = row.Cells[2].Text;
                editarCUIT.Text = row.Cells[3].Text;
                editarEmail.Text = row.Cells[4].Text;
                editarProvincia.Text = row.Cells[5].Text;
                eliminarNombreProveedor.Text = row.Cells[2].Text;
            }

            //Mostrar ventana emergente editar proveedor
            string script = @"<script type='text/javascript'>$('#miModalEditarProveedor').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }

        protected void btnAgregarProveedor_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente agregar proveedor
            string scriptModal = @"<script type='text/javascript'>$('#miModalAgregarProveedor').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProveedores.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProveedores.aspx");
        }

        //Agregamos nuevo proveedor
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            //Verificamos existencia de nombre e email de proveedor
            int ResultadoCompareProv = existenciaProveedorRegistrado(agregarNombre.Text);
            int ResultadoCompareEmail = existenciaEmailProveedor(agregarEmail.Text);
            
            //Validamos formato de correo
            string correo;
            correo = Convert.ToString(agregarEmail.Text);

            if (agregarNombre.Text != "" && agregarCUIT.Text != "" && agregarEmail.Text != "" && agregarProvincia.Text != "")
            {
                if (ResultadoCompareProv == 0)
                {
                    if (ResultadoCompareEmail == 0 && validar(correo) == true)
                    {
                        string sql = "INSERT INTO Proveedores (proveedorNombre, proveedorCUIT, proveedorEmail, proveedorProvincia)" + 
                        "VALUES ('" + agregarNombre.Text + "','" + agregarCUIT.Text + "','" + agregarEmail.Text + "', '" + agregarProvincia.Text + "')";
                        
                        if (claseDatos.insertar(sql))
                        {
                            //Mostrar ventana emergente de exito
                            string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
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
                        string script = @"<script type='text/javascript'>$('#miModalErrorProvEmail').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }
                }
                else
                {
                    //Mostrar ventana emergente de error
                    string script = @"<script type='text/javascript'>$('#miModalErrorProv').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }
            }
            else
            {
                //Mostrar ventana emergente Error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }
        public bool validar(string correo)
        {
            //Validar expresion correo
            return Regex.IsMatch(correo, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
        }

        //Editamos proveedor
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;
            
            //Validamos formato de correo
            string correo;
            correo = Convert.ToString(editarEmail.Text);

            if (editarNombre.Text != "" && editarCUIT.Text != "" && editarEmail.Text != "" && editarProvincia.Text != "")
            {
                if (validar(correo) == true)
                {
                    string sql = "UPDATE Proveedores SET proveedorNombre = '" + editarNombre.Text + "', proveedorCUIT = '" + editarCUIT.Text + "', proveedorEmail='" + editarEmail.Text + "', proveedorProvincia = '" + editarProvincia.Text + "' WHERE proveedorID = " + code;

                    if (claseDatos.modificar(sql))
                    {
                        //Mostrar ventana emergente Exito
                        string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }
                    else
                    {
                        //Mostrar ventana emergente Error
                        string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }
                }
                else
                {
                    //Mostrar ventana emergente Error
                    string script = @"<script type='text/javascript'>$('#miModalErrorProvEmail').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }
            }
            else
            {
                //Mostrar ventana emergente Error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        protected void btnConfirmaEliminar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;
            string sql = "DELETE Proveedores WHERE proveedorID = " + code;

            if (claseDatos.eliminar(sql))
            {
                //Mostrar ventana emergente de exito
                string script = @"<script type='text/javascript'>$('#miModalExitoProveedorEliminado').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
            else
            {
                //Mostrar ventana emergente de error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente eliminar
            string scriptModal = @"<script type='text/javascript'>$('#miModalEliminar').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }
    }
}