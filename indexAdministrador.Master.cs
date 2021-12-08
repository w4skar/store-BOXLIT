using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace store_BOXLIT
{
    public partial class indexAdministrador : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Para mostrar el usuario admin logueado
            //Solo el user admin no muestra datos de sesion
            if (Session["Usuario"] == null)
            {
                string a = "Iniciar Sesion";
                nombreAdmin.InnerText = a;
                nombreAdmin.HRef = "loginUsuarios.aspx";
            }
            else
            {
                nombreAdmin.InnerText = Session["Usuario"].ToString();
                //Muestra el usuario logueado
            }

            //Habilito color en items seleccionados del menu lateral
            string path = HttpContext.Current.Request.Url.AbsolutePath;

            if (path == "/paginaAdministrador/adminUsuarios.aspx")
            {
                usuarios.Attributes["class"] = "active";
            }
            else if (path == "/indexAdministrador.aspx")
            {
                inicio.Attributes["class"] = "active";
            }
            else if (path == "/paginaAdministrador/adminProductos.aspx")
            {
                productos.Attributes["class"] = "active";
            }
            else if (path == "/paginaAdministrador/adminProveedores.aspx")
            {
                proveedores.Attributes["class"] = "active";
            }
            /*
            //Si no esta logueado
            if (Session["Usuario"] == null)
            {
                Response.Redirect("loginUsuarios.aspx");

            }

            //Si esta logueado
            else
            {
                empleado.InnerText = (Session["Usuario"].ToString());
            }

            string path = HttpContext.Current.Request.Url.AbsolutePath;

            if (path == "indexAdministrador.aspx")
            {
                inicio.Attributes["class"] = "active";
            }

            else if (path == "/paginaAdministrador/adminUsuarios.aspx")
            {
                usuarios.Attributes["class"] = "active";
            }
            */
        }
    }
}