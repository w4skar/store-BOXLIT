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
    public partial class adminProductosMarcas : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        conexionBaseDatos conn = new conexionBaseDatos();
        DataTable dt = new DataTable();

        //Procedimiento almacenado: Existencia de marca ya existente
        static Int32 existenciaMarcaRegistrada(String marcas)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("existenciaMarcaRegistrada", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@marca", marcas));

                //Creacion del parametro de salida ResultadoSP
                SqlParameter ResultadoSp = new SqlParameter("@resultado", System.Data.DbType.Int16);
                ResultadoSp.Direction = System.Data.ParameterDirection.Output;
                cmd1.Parameters.Add(ResultadoSp);

                conn.Open();
                cmd1.ExecuteNonQuery();
                Int32 ResultadoExistMarca = int.Parse(cmd1.Parameters["@resultado"].Value.ToString());
                conn.Close();

                return ResultadoExistMarca;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
           // if (Session["UsuarioID"] != null)
            //{
                //TextBox bloqueados
                editarCodigo.ReadOnly = true;
                editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
                editarCodigo.ReadOnly = true;
                editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
                eliminarNombreMarca.ReadOnly = true;
                eliminarNombreMarca.ForeColor = ColorTranslator.FromHtml("#756E6C");

                if (!IsPostBack)
                {
                    //Mostrar grid de marcas
                    mostrarMarcas();

                    //Contador de registros
                    string query = "SELECT count(marcaID) FROM ProductosMarcas";
                    SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read() == true)
                        lblContador.Text = dr[0].ToString();
                    conn.CerrarConexion();
                    dr.Close();
                }
          //  }
            //else
              //  Response.Redirect("~/loginUsuarios.aspx");

        }

        protected void mostrarMarcas()
        {
            string query = "SELECT marcaID, marcaNombre, marcaDescripcion FROM ProductosMarcas ORDER BY marcaID DESC";
            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvMarcas.DataSource = dt;
            gvMarcas.DataBind();
            conn.CerrarConexion();
        }
        protected void gvMarcas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectMarca")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Referencia a la fila del grid
                GridViewRow row = gvMarcas.Rows[rowIndex];
                editarCodigo.Text = row.Cells[1].Text;
                editarNombre.Text = row.Cells[2].Text;
                editarDescripcion.Text = row.Cells[3].Text;
                eliminarNombreMarca.Text = row.Cells[2].Text;
            }

            //Mostrar ventana emergente editar marca
            string script = @"<script type='text/javascript'>$('#miModalEditarMarca').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }

        protected void btnAgregarMarca_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente agregar marca
            string scriptModal = @"<script type='text/javascript'>$('#miModalAgregarMarca').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductosMarcas.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductosMarcas.aspx");
        }

        //Agregamos nueva marca
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            //Verificar existencia de marca
            int ResultadoCompareMarca = existenciaMarcaRegistrada(agregarNombre.Text);
            if (agregarNombre.Text != "")
            {
                if (ResultadoCompareMarca == 0)
                {
                    string sql = "INSERT INTO ProductosMarcas (marcaNombre, marcaDescripcion)" + 
                    "VALUES ('" + agregarNombre.Text + "','" + agregarDescripcion.Text + "')";

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
                    //Mostrar ventana emergente de error de marca ya existente
                    string script = @"<script type='text/javascript'>$('#miModalErrorMarca').modal('show');</script>";
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

        //Editamos marca
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;

            if (editarNombre.Text != "")
            {
                string sql = "UPDATE ProductosMarcas SET marcaNombre = '" + editarNombre.Text + "', marcaDescripcion = '" + editarDescripcion.Text + "' WHERE marcaID = " + code;

                if (claseDatos.modificar(sql))
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
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        protected void btnConfirmaEliminar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;
            string sql = "DELETE ProductosMarcas WHERE marcaID = " + code;

            if (claseDatos.eliminar(sql))
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

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente de eliminar
            string scriptModal = @"<script type='text/javascript'>$('#miModalEliminar').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);

        }
    }
}