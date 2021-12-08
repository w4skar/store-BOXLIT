using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases; //Importamos nuestra clase
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text.RegularExpressions;
using System.IO;
using System.Text;

namespace store_BOXLIT.paginaAdministrador
{
    public partial class adminUsuarios : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        conexionBaseDatos conn = new conexionBaseDatos();
        DataTable dt = new DataTable();

        //Procedimiento almacenado: Existencia de usuario ya registrado
        static Int32 existenciaUsuarioRegistrado(String user)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("existenciaUsuarioRegistrado", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@usuario", user));

                //Creacion del parametro de salida ResultadoSP
                SqlParameter ResultadoSp = new SqlParameter("@resultado", System.Data.DbType.Int16);
                ResultadoSp.Direction = System.Data.ParameterDirection.Output;
                cmd1.Parameters.Add(ResultadoSp);

                conn.Open();
                cmd1.ExecuteNonQuery();
                Int32 ResultadoExist = int.Parse(cmd1.Parameters["@resultado"].Value.ToString());
                conn.Close();

                return ResultadoExist;
            }
        }

        //Procedimiento Almacenado (SP): Existencia de email de usuario ya registrado
        static Int32 existenciaUsuarioEmailRegistrado(String emailusers)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("existenciaUsuarioEmailRegistrado", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@Email", emailusers));

                //Creacion del parametro de salida ResultadoSP
                SqlParameter ResultadoSp = new SqlParameter("@resultadoemail", System.Data.DbType.Int16);
                ResultadoSp.Direction = System.Data.ParameterDirection.Output;
                cmd1.Parameters.Add(ResultadoSp);

                conn.Open();
                cmd1.ExecuteNonQuery();
                Int32 ResultadoExistEmail = int.Parse(cmd1.Parameters["@resultadoemail"].Value.ToString());
                conn.Close();

                return ResultadoExistEmail;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //TextBox bloqueados
            editarCodigo.ReadOnly = true;
            editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
            editarLogin.ReadOnly = true;
            editarLogin.ForeColor = ColorTranslator.FromHtml("#756E6C");
            editarSector.ReadOnly = true;
            editarSector.ForeColor = ColorTranslator.FromHtml("#756E6C");
            eliminarUser.ReadOnly = true;
            eliminarUser.ForeColor = ColorTranslator.FromHtml("#756E6C");

            if (!IsPostBack)
            {
                //Mostrar grid de marcas
                mostrarUsuarios();

                ListItem i;
                i = new ListItem("Compras", "1");
                agregarDropSector.Items.Add(i);
                i = new ListItem("Ventas", "2");
                agregarDropSector.Items.Add(i);

                //Contador de registros
                string query = "SELECT count(UsuarioID) FROM Usuarios WHERE usuarioTipo='Empleado'";
                SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read() == true)
                    lblContador.Text = dr[0].ToString();
                conn.CerrarConexion();
                dr.Close();

                //Mostrar clientes de la web
                DataTable dtc = new DataTable();
                string query2 = "SELECT usuarioID, usuarioLogin, usuarioPass, usuarioTipo, nombre, apellido, email, usuarioEstado FROM Usuarios WHERE usuarioTipo='Cliente' ORDER BY usuarioID DESC";
                SqlCommand cmd2 = new SqlCommand(query2, conn.AbrirConexion());
                SqlDataAdapter da = new SqlDataAdapter(query2, conn.AbrirConexion());
                da.Fill(dtc);
                gvClientes.DataSource = dtc;
                gvClientes.DataBind();
                conn.CerrarConexion();

                mostrarClientesFile();
            }
        }

        protected void mostrarUsuarios()
        {
            string query = "SELECT usuarioID, usuarioLogin, usuarioPass, nombre, apellido, email, usuarioSector, usuarioEstado FROM Usuarios "+
            "WHERE usuarioTipo='Empleado' ORDER BY usuarioID DESC";
            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvUsuarios.DataSource = dt;
            gvUsuarios.DataBind();
            conn.CerrarConexion();
        }
        protected void gvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectUsuario")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Referencia a la fila del grid
                //Traemos todos los datos y lo cargamos
                GridViewRow row = gvUsuarios.Rows[rowIndex];
                editarCodigo.Text = row.Cells[1].Text;
                editarLogin.Text = row.Cells[2].Text;
                editarPass.Text = row.Cells[3].Text;
                editarNombre.Text = row.Cells[4].Text;
                editarApellido.Text = row.Cells[5].Text;
                editarEmail.Text = row.Cells[6].Text;
                editarSector.Text = row.Cells[7].Text;
                eliminarUser.Text = row.Cells[2].Text;
            }

            //Mostrar ventana emergente editar usuario
            string script = @"<script type='text/javascript'>$('#miModalEditarUsuario').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }

        protected void btnAgregarUsuario_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente agregar
            string scriptModal = @"<script type='text/javascript'>$('#miModalAgregarUsuario').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminUsuarios.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminUsuarios.aspx");
        }

        //Agregamos nuevo usuario
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            int ResultadoCompare = existenciaUsuarioRegistrado(agregarLogin.Text);
            int ResultadoCompareEmail = existenciaUsuarioEmailRegistrado(agregarEmail.Text);

            string correo;
            correo = Convert.ToString(agregarEmail.Text);

            string pass = "BOXLIT!"; //Solo el administrador con este password puede crear usuarios

            if (agregarLogin.Text != "" & agregarPass.Text != "" & agregarNombre.Text != "" & agregarApellido.Text != "" & agregarDropSector.SelectedItem.ToString() != "" & agregarEmail.Text != "" & agregarPassAdmin.Text != "")
            {
                if (ResultadoCompare == 0)
                {
                    if (ResultadoCompareEmail == 0 && validar(correo) == true)
                    {
                        if (agregarPassAdmin.Text == pass)
                        {
                            string tipo = "Empleado";
                            string estado = "Activo";
                            string sector = agregarDropSector.SelectedItem.ToString();
                            string sql = "INSERT INTO Usuarios (usuarioLogin, usuarioPass, usuarioTipo, nombre, apellido, email, usuarioSector, usuarioEstado)" + "VALUES ('" + agregarLogin.Text + "','" + agregarPass.Text + "','" + tipo + "','" + agregarNombre.Text + "','" + agregarApellido.Text + "','" + agregarEmail.Text + "','" + sector + "','" + estado + "')";

                            if (claseDatos.insertar(sql))
                            {
                                //Mostrar ventana emergente exito
                                string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                            }
                            else
                            {
                                //Mostrar ventana emergente error
                                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                            }
                        }
                        else
                        {
                            //Mostrar ventana emergente error
                            string script = @"<script type='text/javascript'>$('#miModalAdmin').modal('show');</script>";
                            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                        }
                    }
                    else
                    {
                        //Mostrar ventana emergente error
                        string script = @"<script type='text/javascript'>$('#miModalErrorEmail').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }
                }
                else
                {
                    //Mostrar ventana emergente errorr: nombre de usuario existente
                    string script = @"<script type='text/javascript'>$('#miModalErrorUser').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }
            }
            else
            {
                //Mostrar ventana emergente error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        //Editamos usuario
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            int ResultadoCompareEmail = existenciaUsuarioEmailRegistrado (editarEmail.Text);
            string correo;
            correo = Convert.ToString(editarEmail.Text);

            string code = editarCodigo.Text;
            if (editarPass.Text != "" & editarNombre.Text != "" & editarApellido.Text != "" & editarEmail.Text != "")
            {
                if (ResultadoCompareEmail == 0 && validar(correo) == true)
                {
                    //Solo se editara ciertos parametros
                    string sql = "UPDATE Usuarios SET usuarioPass = '" + editarPass.Text +
                    "', Nombre='" + editarNombre.Text +
                    "', Apellido='" + editarApellido.Text +
                    "', Email='" + editarEmail.Text +
                    "' WHERE UsuarioID = " + editarCodigo.Text;

                    if (claseDatos.modificar(sql))
                    {
                        //Mostrar ventana emergente exito
                        string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }
                    else
                    {
                        //Mostrar ventana emergente error
                        string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }
                }
                else
                {
                    //Mostrar ventana emergente error
                    string script = @"<script type='text/javascript'>$('#miModalErrorEmail').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }

            }
            else
            {
                //Mostrar ventana emergente error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        public bool validar(string correo)
        {
            //Validar expresion correo
            return Regex.IsMatch(correo, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
        }

        protected void btnConfirmaEliminar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;
            string sql = "DELETE Usuarios WHERE usuarioID = " + code;

            if (claseDatos.eliminar(sql))
            {
                //Mostrar ventana emergente exito
                string script = @"<script type='text/javascript'>$('#miModalExitoUsuarioEliminado').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
            else
            {
                //Mostrar ventana emergente error
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

        protected void btnVerClientes_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente ver clientes
            string scriptModal = @"<script type='text/javascript'>$('#miModalVerClientes').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            mostrarClientesFile();
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Clientes.txt");
            Response.Charset = "";
            Response.ContentType = "application/text";
            gvClientes.AllowPaging = false;
            gvClientes.DataBind();

            DateTime dateTime = new DateTime();
            dateTime = DateTime.Now;
            string fech = Convert.ToDateTime(dateTime).ToString("yyyy-MM-dd");

            StringBuilder Rowbind = new StringBuilder();
            Rowbind.Append("\r\r ** DATOS CLIENTES **");
            Rowbind.Append("\r\n");
            Rowbind.Append("Fecha Exp: " + fech);
            Rowbind.Append("\r\n");
            Rowbind.Append("\r\n");
            Rowbind.Append("\r\n");

            //Columnas
            for (int k = 0; k < gvClientes.Columns.Count; k++)
            {

                Rowbind.Append(gvClientes.Columns[k].HeaderText + ' ');
            }

            //Filas
            Rowbind.Append("\r\n");
            for (int i = 0; i < gvClientes.Rows.Count; i++)
            {
                for (int k = 0; k < gvClientes.Columns.Count; k++)
                {

                    Rowbind.Append(gvClientes.Rows[i].Cells[k].Text + ' ');
                }

                Rowbind.Append("\r\n");
            }
            Response.Output.Write(Rowbind.ToString());
            Response.Flush();
            Response.End();

        }
        protected void mostrarClientesFile()
        {
            string query = "SELECT *FROM Usuarios WHERE usuarioTipo ='Cliente'";
            SqlCommand com = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            DataSet ds = new DataSet();
            da.Fill(ds);
            gvClientes.DataSource = ds;
            gvClientes.DataBind();
            conn.CerrarConexion();
        }
    }
}