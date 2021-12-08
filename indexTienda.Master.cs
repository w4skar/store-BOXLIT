using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases; //Importamos nuestra clase
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using System.Data.SqlClient;

namespace store_BOXLIT
{
    public partial class indexTienda : System.Web.UI.MasterPage
    {
        conexionTablas claseDatos = new conexionTablas();
        conexionBaseDatos conn = new conexionBaseDatos();
        DataTable dt = new DataTable();

        //Procedimiento almacenado: Existencia de email de newsletter 
        static Int32 ExistenciaMail(String email)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!OK");

            using (conn)
            {
                //Creacion del parametro Usuario
                SqlCommand cmd1 = new SqlCommand("registrarEmailNewsletter", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@email", email));

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
            if (Session["Usuario"] == null)
            {
                PanelCart.Visible = false;
                string a = "Iniciar Sesion";
                nombreusuario.InnerText = a;
                nombreusuario.HRef = "loginUsuarios.aspx";
            }
            else
            {
                PanelCart.Visible = true;
                nombreusuario.InnerText = Session["Usuario"].ToString();
                Cerrar.Visible = true;
                BindRepeater();
            }

        }
        private void BindRepeater()
        {
            /*
            DataTable tablaV = claseDatos.consultaTablaConUnSQL("SELECT CC.CarritoID, P.PrecioUnitario, P.ImagenUrl, U.UsuarioNombre, U.Apellidos, P.ProductoNombre, CC.Cantidad, CC.Estado FROM CarritoCompras CC INNER JOIN Usuarios U ON U.UsuarioID = CC.UsuarioID INNER JOIN Productos P ON P.ProductoID = CC.ProductoID WHERE CC.Estado = 0 AND CC.UsuarioID = " + Session["UsuarioID"].ToString());

            Repeater1.DataSource = tablaV;
            Repeater1.DataBind();
            */
        }

        protected void btnNewsletter_Click(object sender, EventArgs e)
        {
            int ResultadoCompareEmail = ExistenciaMail(textNewsletter.Value);
            string correo = Convert.ToString(textNewsletter.Value);

            if (textNewsletter.Value != "")
            {
                if ((ResultadoCompareEmail == 0 && validar(correo) == true))
                {
                    //Si el correo es valido
                    string query = "INSERT INTO ClientesNewsletter(newsletterEmail) VALUES('" + textNewsletter.Value + "')";
                    if (claseDatos.insertar(query))
                    {
                        Response.Write("<script>alert('Gracias por registrarse! Muy pronto recibirá novedades.');</script>");
                        textNewsletter.Value = "";
                    }
                    else
                    {
                        Response.Write("<script>alert('Ocurrio un error. Intente nuevamente.');</script>");
                        textNewsletter.Value = "";
                    }
                }
                else
                {
                    Response.Write("<script>alert('El correo ingresado ya existente o ya esta registrado. Intente nuevamente.');</script>");
                    textNewsletter.Value = "";
                }
            }

            else
            {
                Response.Write("<script>alert('Campo vacio. Intente nuevamente.');</script>");
                textNewsletter.Value = "";
            }
        }

        public bool validar(string correo)
        {
            //Validar expresion correo
            return Regex.IsMatch(correo, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("../index.aspx");

        }

        protected void btnBuscarWeb_Click(object sender, EventArgs e)
        {
            //Buscador principal de la pagina
            if (textBuscarWeb.Value != "")
            {
                string query = "SELECT*FROM Productos WHERE Store_Name LIKE '%A%'"; //Busca palabras que contengan AN
                //string query = "SELECT * FROM Productos WHERE ProductoNombre LIKE ?mouse";

                SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());

                cmd.Parameters.AddWithValue("?A", string.Format("'%{0}%'", textBuscarWeb.Value));
                conn.AbrirConexion();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

            }
            else
            {
                Response.Write("<script>alert('El campo no puede estar vacio. Intente nuevamente.');</script>");

            }
        }
    }
}