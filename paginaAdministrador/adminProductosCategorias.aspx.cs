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
    public partial class adminProductosCategorias : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        conexionBaseDatos conn = new conexionBaseDatos();
        DataTable dt = new DataTable();

        //Procedimiento almacenado: Existencia de categoria ya existente
        static Int32 existenciaCategoriaRegistrada(String categ)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!OK");

            using (conn)
            {
                //Creacion del parametro usuario
                SqlCommand cmd1 = new SqlCommand("existenciaCategoriaRegistrada", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@categoria", categ));

                //Creacion del parametro de salida ResultadoSP
                SqlParameter ResultadoSp = new SqlParameter("@resultado", System.Data.DbType.Int16);
                ResultadoSp.Direction = System.Data.ParameterDirection.Output;
                cmd1.Parameters.Add(ResultadoSp);

                conn.Open();
                cmd1.ExecuteNonQuery();
                Int32 ResultadoExistCategoria = int.Parse(cmd1.Parameters["@resultado"].Value.ToString());
                conn.Close();

                return ResultadoExistCategoria;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UsuarioID"] != null)
            //{
                //TextBox bloqueados
                editarCodigo.ReadOnly = true;
                editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
                eliminarNombreCategoria.ReadOnly = true;
                eliminarNombreCategoria.ForeColor = ColorTranslator.FromHtml("#756E6C");

                if (!IsPostBack)
                {
                    //Mostrar grid de categorias
                    mostrarCategorias();

                    //Contador de registros
                    string query = "SELECT count(categoriaID) FROM ProductosCategorias";
                    SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read() == true)
                        lblContador.Text = dr[0].ToString();
                    conn.CerrarConexion();
                    dr.Close();

                }
            //}
            //else
              //  Response.Redirect("~/loginUsuarios.aspx");
        }

        protected void mostrarCategorias()
        {
            string query = "SELECT categoriaID, categoriaNombre, categoriaDescripcion FROM ProductosCategorias ORDER BY categoriaID DESC";
            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvCategorias.DataSource = dt;
            gvCategorias.DataBind();
            conn.CerrarConexion();
        }
        protected void gvCategorias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectCategoria")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Referencia a la fila del grid
                GridViewRow row = gvCategorias.Rows[rowIndex];
                editarCodigo.Text = row.Cells[1].Text;
                editarNombre.Text = row.Cells[2].Text;
                editarDescripcion.Text = row.Cells[3].Text;
                eliminarNombreCategoria.Text = row.Cells[2].Text;
            }

            //Mostrar ventana emergente editar categoria
            string script = @"<script type='text/javascript'>$('#miModalEditarCategoria').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente agregar categoria
            string scriptModal = @"<script type='text/javascript'>$('#miModalAgregarCategoria').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductosCategorias.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductosCategorias.aspx");
        }

        //Agregamos nueva categoria
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            //Verificar existencia de categoria
            int ResultadoCompareCategoria = existenciaCategoriaRegistrada(agregarNombre.Text);
            if (agregarNombre.Text != "" & agregarDescripcion.Text != "")
            {
                if (ResultadoCompareCategoria == 0)
                {
                    string sql = "INSERT INTO ProductosCategorias (categoriaNombre, categoriaDescripcion)" + 
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
                    //Mostrar ventana emergente error de nombre de categoria existente
                    string script = @"<script type='text/javascript'>$('#miModalErrorCategoria').modal('show');</script>";
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

        //Editamos categoria
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;

            if (editarNombre.Text != "" & editarDescripcion.Text != "")
            {
                string sql = "UPDATE ProductosCategorias SET categoriaNombre = '" + editarNombre.Text + "', categoriaDescripcion = '" + editarDescripcion.Text + "' WHERE categoriaID = " + code;

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
            string sql = "DELETE ProductosCategorias WHERE categoriaID = " + code;

            if (claseDatos.eliminar(sql))
            {
                //Mostrar ventana emergente de xito
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
            //Mostrar ventana emergente eliminar
            string scriptModal = @"<script type='text/javascript'>$('#miModalEliminar').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }
    }
}