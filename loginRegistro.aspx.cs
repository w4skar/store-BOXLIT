using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using store_BOXLIT.clases; //Importamos nuestra clase

namespace store_BOXLIT
{
    public partial class loginRegistro : System.Web.UI.Page
    {
        //Procedimiento Almacenado: existencia de usuario 
        static Int32 ExistenciaUser(String usuario)
        {
            //Conexion a la base de datos
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!OK");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("loginUsuarioRegistrado", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@usuario", usuario));

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

        //Procedimiento Almacenado: existencia de email 
        static Int32 ExistenciaEmail(String email)
        {
            //Conexion a la base de datos
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!OK");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("loginEmailRegistrado", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@Email", email));

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
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            String UserName;
            if (registrarLogin.Value == "" | registrarPass.Value == "" | registrarNombre.Value == "" | registrarApellido.Value == "" | registrarEmail.Value == "")
            {
                //Mostrar ventana emergente error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
            else
            {
                //Definicion de la conexion
                SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!OK");

                //Verificar existencia de usuario
                int ResultadoCompare = ExistenciaUser(registrarLogin.Value);
                int EmailCompare = ExistenciaEmail(registrarEmail.Value);
                if (ResultadoCompare == 0)
                {
                    if (EmailCompare == 0)
                    {
                        UserName = "'" + registrarLogin.Value + "'";
                        string Estado = "Activo";
                        string tipo = "Cliente";
                        string sql = "INSERT INTO USUARIOS (usuarioLogin, usuarioPass, usuarioTipo, nombre, apellido, email, usuarioEstado)" +
                           "VALUES ('" + registrarLogin.Value + "','" + registrarPass.Value + "','" + tipo + "','" + registrarNombre.Value + "','" + registrarApellido.Value + "','" + registrarEmail.Value + "', '" + Estado + "')";

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
                        string script = @"<script type='text/javascript'>$('#miModalErrorUser').modal('show');</script>";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                    }
                }
                else
                {
                    //Mostrar ventana emergente error
                    string script = @"<script type='text/javascript'>$('#miModalErrorUser').modal('show');</script>";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                }

                //Limpieza de campos de registro
                registrarNombre.Value = "";
                registrarApellido.Value = "";
                registrarEmail.Value = "";
                registrarLogin.Value = "";
                registrarPass.Value = "";
            }
        }
        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginUsuarios.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginRegistro.aspx");
        }
        protected void btnErrorUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginRegistro.aspx");
        }

        protected void evaluarMail_Click(object sender, EventArgs e)
        {
            if (registrarEmail.Value == "")
            {
                Response.Write("<script>alert('Correo no valido. Intente nuevamente.');</script>");
                registrarEmail.Value = "";

            }

            string correo;
            correo = Convert.ToString(registrarEmail.Value);
            if (validar(correo) == true)
            {
                //Si el correo es valido
                string query = "INSERT INTO ClienteSuscripcion(Email) VALUES('" + registrarEmail.Value + "')";
                if (claseDatos.insertar(query))
                {
                    Response.Write("<script>alert('Gracias por registrarse! Muy pronto recibirá novedades.');</script>");
                    registrarEmail.Value = "";

                }
            }
            else
            {
                Response.Write("<script>alert('Correo no valido. Intente nuevamente.');</script>");
                registrarEmail.Value = "";

            }
        }
        public bool validar(string correo)
        {
            //Validar expresion correo
            return Regex.IsMatch(correo, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
        }
    }
}