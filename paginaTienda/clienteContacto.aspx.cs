using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using store_BOXLIT.clases;
using System.Net;
using System.Net.Mail;
using System.Data;
using System.Text.RegularExpressions;

namespace store_BOXLIT.paginaTienda
{
    public partial class clienteContacto : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            if (contactoNombre.Value == "" | contactoAsunto.Value == "" | contactoTelefono.Value == "" | contactoEmail.Value == "" | contactoMessage.Text == "")
            {
                //Mostrar ventana emergente de error
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
            else
            {
                //Datos del emisor
                MailMessage Msg = new MailMessage(); //Creo una instancia
                Msg.From = new MailAddress(contactoEmail.Value); //Mail de quien envia el mensaje
                //Msg.To.Add("ponercorreo@gmail.com"); //Mail de quien recibe al mail
                Msg.To.Add("w4skar@gmail.com");
                Msg.Subject = contactoAsunto.Value; //Asunto 

                //Msg.Body = "Nombre:" + contactoNombre.Value + "\r\n Correo:" + contactoEmail.Value + "\r\n Asunto:" + contactoAsunto.Value + "\r\n Mensaje:" + contactoMessage.Text; //Mensaje
                string cadena = @"<h5 style=""font-family:Helvetica,black;font-size:medium;"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Se ha recibido un mensaje: </h5>;";

                Msg.Body = @"<p style=""font-family:Helvetica,black;font-size:medium;font-weight:bold;"">&nbsp;&nbsp;&nbsp;&nbsp;BOXLIT Computers! Ha recibido un mensaje! </p></p></p>" +
                @"<p style=""font-family:Helvetica,black;font-size:smaller; font-weight:100;"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Remitente: " + contactoNombre.Value + "</p>" +
                @"<p style=""font-family:Helvetica,black;font-size:smaller; font-weight:100;"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Contacto: " + contactoEmail.Value + "</p></p></p>" +
                //@"<p style=""font-family:Helvetica,black;font-size:smaller;font-weight:200;"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Asunto: " + contactoAsunto.Value + "</p>" +
                @"<p style=""font-family:Helvetica,black;font-size:smaller;font-weight:200;"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mensaje: " + contactoMessage.Text + "</p>";

                cadena = cadena + @" <p style=""font-family:Helvetica,black;font-size:medium;text-align: center;"" >Contestar consulta dentro de las 24hs.</p>";

                Msg.IsBodyHtml = true; //Lo que viene en el mensaje es HTML

                //Datos del receptor
                SmtpClient smtp = new SmtpClient();
                NetworkCredential NetworkCred = new NetworkCredential();
                //NetworkCred.UserName = "ponercorreo@gmail.com";
                //NetworkCred.Password = "clave de correo";
                NetworkCred.UserName = "w4skar@gmail.com"; //Tambien podemos usar un email temporal de la web: https://temp-mail.org/es/
                NetworkCred.Password = "Gw8BuYtaT!9ueGB"; //Como es temporal, no tiene password
                //Para el correo de gmail, hotmail u otro, solo coloco los datos correspondientes

                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Host = "smtp.gmail.com"; //Servidor de salida. Segun el dominio se pone: smtp.dominio.com
                smtp.Port = 587; //Puerto SMTP seguro
                smtp.EnableSsl = true; //Seguridad
                smtp.Send(Msg);

                //Mostrar ventana emergente de exito
                string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        protected void evaluarMail_Click(object sender, EventArgs e)
        {
            if (contactoEmail.Value == "")
            {
                Response.Write("<script>alert('Correo no valido. Intente nuevamente.');</script>");
                contactoEmail.Value = "";
            }

            string correo;
            correo = Convert.ToString(contactoEmail.Value);
            if (validar(correo) == true)
            {
                //Si el correo es valido
                string query = "INSERT INTO ClientesNewsletter(newsletterEmail) VALUES('" + contactoEmail.Value + "')";
                if (claseDatos.insertar(query))
                {
                    Response.Write("<script>alert('Gracias por registrarse! Muy pronto recibirá novedades.');</script>");
                    contactoEmail.Value = "";
                }
            }
            else
            {
                Response.Write("<script>alert('Correo no valido. Intente nuevamente.');</script>");
                contactoEmail.Value = "";
            }
        }
        public bool validar(string correo)
        {
            //Validar expresion correo
            return Regex.IsMatch(correo, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            contactoNombre.Value = "";
            contactoAsunto.Value = "";
            contactoTelefono.Value = "";
            contactoEmail.Value = "";
            contactoMessage.Text = "";
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaTienda/clienteContacto.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaTienda/clienteContacto.aspx");
        }
    }
}