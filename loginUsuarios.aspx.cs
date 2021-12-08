using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using store_BOXLIT.clases; //Importamos nuestra clase

namespace store_BOXLIT
{
    public partial class loginUsuarios : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Permite usar el control para validar el campo
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery",
            new ScriptResourceDefinition
            {
                Path = "/Scripts/jquery-1.8.0.js"
            }
            );
            Session["Usuario"] = null;
        }

        //Variable global para nombre de usuario
        static class Globales
        {
            public static string NombreUsuario;
            public static string NombreUsuarioAdmin;


            public static void Inicializar()
            {
                NombreUsuario = "";

            }
        }
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            Session["OC"] = "0";

            if (usuarioLogin.Value == "" | usuarioPass.Value == "")
            {
                //Mostrar ventana emergente error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }

            else
            {
                if (usuarioLogin.Value == "admin" && usuarioPass.Value == "admin123")
                {
                    Response.Redirect("indexAdministrador.aspx");
                }
                else
                {
                    //Definicion de variables de session y banderas
                    Session["Usuario"] = usuarioLogin.Value;
                    Session["Contraseña"] = usuarioPass.Value;

                    Boolean UserLogOk = false;
                    Boolean PassLogOk = false;
                    String Query = null;

                    //Conexion a la base de datos
                    SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!OK");
                    conn.Open();

                    //Busqueda de usuario
                    Query = "SELECT usuarioLogin FROM Usuarios WHERE usuarioLogin=" + "'" + Session["Usuario"].ToString() + "'";

                    SqlCommand cmd1 = new SqlCommand(Query, conn);

                    using (SqlDataReader reader = cmd1.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            UserLogOk = true;
                        }
                    }

                    //Busqueda de contraseña
                    Query = "SELECT usuarioPass FROM Usuarios WHERE usuarioPass=" + "'" + Session["Contraseña"].ToString() + "'";

                    SqlCommand cmd2 = new SqlCommand(Query, conn);
                    using (SqlDataReader reader = cmd2.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            PassLogOk = true;
                        }
                    }

                    //Verificacion de usuario y contraseña
                    if (UserLogOk && PassLogOk)
                    {
                        //Guardo el UsuarioID para posteriores controles mas sencillos
                        DataTable tabla = claseDatos.consultaTablaConUnSQL("SELECT usuarioID FROM Usuarios WHERE usuarioLogin=" + "'" + Session["Usuario"].ToString() + "'");
                        Session["usuarioID"] = tabla.Rows[0]["usuarioID"].ToString();

                        DataTable tabla1 = claseDatos.consultaTablaConUnSQL("SELECT usuarioTipo FROM Usuarios WHERE usuarioLogin=" + "'" + Session["Usuario"].ToString() + "'");
                        string TipoUsuario = tabla1.Rows[0]["usuarioTipo"].ToString();

                        DataTable tabla2 = claseDatos.consultaTablaConUnSQL("SELECT usuarioEstado FROM Usuarios WHERE usuarioLogin=" + "'" + Session["Usuario"].ToString() + "'");
                        string Estado = tabla2.Rows[0]["usuarioEstado"].ToString();

                        //Borrado de Productos en el carrito por transacciones incompletas
                        if (claseDatos.eliminar("DELETE FROM CarritoCompras WHERE usuarioID = " + Session["usuarioID"].ToString())) { }

                        if (Estado == "Activo")
                        {
                            if (TipoUsuario == "Cliente")
                            {
                                //Redireccionamiento al sitio web
                                Response.Redirect("index.aspx");
                                //Asigno a la variable global el nombre de usuario
                                Globales.NombreUsuario = usuarioLogin.Value;
                                Session["usuarioTipo"] = "Cliente";

                            }
                            else
                            {
                                //Redireccionamiento al dashboard
                                Response.Redirect("indexAdministrador.aspx");
                                Session["usuarioTipo"] = "Administrador";
                            }
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
                        string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }

                    conn.Close();
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (usuarioLogin.Value == "" | usuarioPass.Value == "")
            {
                //Mostrar ventana emergente error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
            else
            {
                usuarioLogin.Value = "";
                usuarioPass.Value = "";
            }
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginUsuarios.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginUsuarios.aspx");
        }
    }
}