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
using System.Globalization;
using System.IO; //Para obtener datos del archivo

namespace store_BOXLIT.paginaAdministrador
{
    public partial class adminProductos : System.Web.UI.Page
    {
        conexionTablas claseDatos = new conexionTablas();
        conexionBaseDatos conn = new conexionBaseDatos();
        DataTable dt = new DataTable();

        //Procedimiento almacenado: Existencia de un producto ya registrado
        static Int32 existenciaProductoRegistrado(String product)
        {
            //Conexion a la base de datos SQL
            SqlConnection conn = new SqlConnection("Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!");

            using (conn)
            {
                //Creacion del parametro usuario
                SqlCommand cmd1 = new SqlCommand("existenciaProductoRegistrado", conn);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@prod", product));

                //Creacion del parametro de salida ResultadoSP
                SqlParameter ResultadoSp = new SqlParameter("@resultado", System.Data.DbType.Int16);
                ResultadoSp.Direction = System.Data.ParameterDirection.Output;
                cmd1.Parameters.Add(ResultadoSp);

                conn.Open();
                cmd1.ExecuteNonQuery();
                Int32 ResultadoExistProd = int.Parse(cmd1.Parameters["@resultado"].Value.ToString());
                conn.Close();

                return ResultadoExistProd;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
           // if (Session["UsuarioID"] != null)
            //{
                //TextBox bloqueados
                editarCodigo.ReadOnly = true;
                editarCodigo.ForeColor = ColorTranslator.FromHtml("#756E6C");
                eliminarNombreProducto.ReadOnly = true;
                eliminarNombreProducto.ForeColor = ColorTranslator.FromHtml("#756E6C");
                lblModal.Visible = false;

                if (!IsPostBack)
                {
                    //Mostrar grid de productos
                    mostrarProductos();

                    //Contador de registros
                    string query = "SELECT count(productoID) FROM Productos";
                    SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read() == true)
                        lblContador.Text = dr[0].ToString();
                    conn.CerrarConexion();
                    dr.Close();

                    //Cargamos dropdownlist ordernado para el modal editar
                    DataTable tablaMarcas = claseDatos.consultaTabla("ProductosMarcas");
                    DataView dvOrderMarca = new DataView(tablaMarcas);
                    dvOrderMarca.Sort = "marcaNombre";
                    editarDropMarca.DataSource = dvOrderMarca;
                    editarDropMarca.DataTextField = "marcaNombre";
                    editarDropMarca.DataValueField = "marcaID";
                    editarDropMarca.DataBind();

                    DataTable tablaCategorias = claseDatos.consultaTabla("ProductosCategorias");
                    DataView dvOrderCategoria = new DataView(tablaCategorias);
                    dvOrderCategoria.Sort = "categoriaNombre";
                    editarDropCategoria.DataSource = dvOrderCategoria;
                    editarDropCategoria.DataValueField = "categoriaID";
                    editarDropCategoria.DataTextField = "categoriaNombre";
                    editarDropCategoria.DataBind();

                    //Cargamos dropdownlist ordernado para el modal agregar
                    DataTable tablaMarcas2 = claseDatos.consultaTabla("ProductosMarcas");
                    DataView dvOrderMarca2 = new DataView(tablaMarcas2);
                    dvOrderMarca2.Sort = "marcaNombre";
                    agregarDropMarca.DataSource = dvOrderMarca2;
                    agregarDropMarca.DataValueField = "marcaID";
                    agregarDropMarca.DataTextField = "marcaNombre";
                    agregarDropMarca.DataBind();
                    agregarDropMarca.Items.Insert(0, new ListItem("--Seleccionar marca --", "0"));

                    DataTable tablaCategorias2 = claseDatos.consultaTabla("ProductosCategorias");
                    DataView dvOrderCategoria2 = new DataView(tablaCategorias2);
                    dvOrderCategoria2.Sort = "categoriaNombre";
                    agregarDropCategoria.DataSource = dvOrderCategoria2;
                    agregarDropCategoria.DataValueField = "categoriaID";
                    agregarDropCategoria.DataTextField = "categoriaNombre";
                    agregarDropCategoria.DataBind();
                    agregarDropCategoria.Items.Insert(0, new ListItem("--Seleccionar categoria --", "0"));
                }
            //}
            //else
              //  Response.Redirect("~/loginUsuarios.aspx");

        }

        protected void mostrarProductos()
        {
            string query = "SELECT productoID, productoNombre, productoPrecio, categoriaNombre, marcaNombre FROM Productos INNER JOIN ProductosCategorias ON (categoria = categoriaID)"+
            "INNER JOIN ProductosMarcas ON (marca = marcaID) ORDER BY productoID DESC";

            SqlCommand cmd = new SqlCommand(query, conn.AbrirConexion());
            SqlDataAdapter da = new SqlDataAdapter(query, conn.AbrirConexion());
            da.Fill(dt);
            gvProductos.DataSource = dt;
            gvProductos.DataBind();
            conn.CerrarConexion();
        }

        protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "selectProducto")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Referencia a la fila del grid
                GridViewRow row = gvProductos.Rows[rowIndex];
                editarCodigo.Text = row.Cells[1].Text;
                editarNombre.Text = row.Cells[2].Text;
                editarPrecio.Text = row.Cells[3].Text;
                editarDropCategoria.SelectedItem.Text = row.Cells[4].Text;
                editarDropMarca.SelectedItem.Text = row.Cells[5].Text;
                eliminarNombreProducto.Text = row.Cells[2].Text;
            }

            //Mostrar ventana emergente editar
            string script = @"<script type='text/javascript'>$('#miModalEditar').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string code = editarCodigo.Text;

            string sql = "UPDATE Productos SET productoNombre = '" + editarNombre.Text + "', categoria='" + editarDropCategoria.SelectedValue + "', productoPrecio = '" + editarPrecio.Text + "', marca='" + editarDropMarca.SelectedValue + "' WHERE productoID = " + code;

            if (claseDatos.modificar(sql))
            {
                agregarNombre.Text = "";
                agregarPrecio.Text = "";
                agregarDropCategoria.SelectedIndex = 0;
                agregarDropMarca.SelectedIndex = 0;

                //Volver a poner el error vacio
                lblModal.Visible = false;

                //Mostrar ventana emergente de exito
                string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);

            }
            else
            {
                //Mostrar ventana emergente de exito
                string script = @"<script type='text/javascript'>$('#miModalError').modal('show');</script>";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
            }
        }

        protected void btnExito_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductos.aspx");
        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            Response.Redirect("../paginaAdministrador/adminProductos.aspx");
        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente de agregar
            string scriptModal = @"<script type='text/javascript'>$('#miModalAgregar').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            //Imagen
            Boolean fileOK = false;
            //Verificar existencia del producto
            int ResultadoCompare = existenciaProductoRegistrado(agregarNombre.Text);

            //Para evitar algún conflicto cuando no se seleccione ningún archivo, verificamos que el control FileUpload este cargado
            //Ademas verificamos que los campos no esten vacios
            if (miArchivo.HasFile & agregarNombre.Text != "" & agregarPrecio.Text != "" & Convert.ToInt32(agregarDropCategoria.SelectedValue) != 0 & Convert.ToInt32(agregarDropMarca.SelectedValue) != 0)
            {
                if (ResultadoCompare == 0)
                {
                    String fileExtension =
                    System.IO.Path.GetExtension(miArchivo.FileName).ToLower();
                    String[] allowedExtensions = {".jpeg", ".jpg"};
                    for (int i = 0; i < allowedExtensions.Length; i++)
                    {
                        if (fileExtension == allowedExtensions[i])
                        {
                            fileOK = true;
                        }

                        if (fileOK)
                        {
                            string categoria = agregarDropCategoria.SelectedItem.ToString();
                            string marca = agregarDropMarca.SelectedItem.ToString();
                            
                            //Guardamos imagen
                            int punto = miArchivo.FileName.IndexOf(".");
                            string nameDoc = miArchivo.FileName.Substring(0, punto);
                            string typeDoc = miArchivo.FileName.Substring(punto);
                            //Crear previamente directorio donde se guardaran las imagenes de los productos
                            string filePathdb = "/img/Productos/" + nameDoc + "_" + System.DateTime.Now.ToString("HH'_'mm'_'ss") + typeDoc;
                            string filePath = Server.MapPath(filePathdb);
                            string html = string.Empty;
                            string a = filePathdb;

                            //Insertamos el producto en la base de datos
                            string sql = "INSERT INTO Productos (productoNombre, productoPrecio, categoria, marca, productoImagenURL)" +
                            "VALUES ('" + agregarNombre.Text + "','" + agregarPrecio.Text + "','"+ agregarDropCategoria.SelectedValue + "','" + agregarDropMarca.SelectedValue + "', '" + filePathdb + "')";

                            if (claseDatos.insertar(sql))
                            {
                                //Mostrar ventana emergente de eito
                                string script = @"<script type='text/javascript'>$('#miModalExito').modal('show');</script>";
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);

                                agregarNombre.Text = "";
                                agregarPrecio.Text = "";
                                agregarDropCategoria.SelectedIndex = 0;
                                agregarDropMarca.SelectedIndex = 0;

                                //Mostrar imagen
                                miArchivo.PostedFile.SaveAs(filePath);

                                //Volver a poner el error vacio
                                lblModal.Visible = false;
                            }
                            else
                            {
                                lblModal.Visible = true;
                                lblModal.Text = "Error al insertar los datos en la tabla Productos.";
                            }
                        }
                        else
                        {
                            lblModal.Visible = true;
                            lblModal.Text = "Por favor seleccione un formato válido";
                        }
                    }
                }
                else
                {
                    //Mostrar ventana emergente producto ya existente
                    string script = @"<script type='text/javascript'>$('#miModalErrorProd').modal('show');</script>";
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

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            //Mostrar ventana emergente eliminar
            string scriptModal = @"<script type='text/javascript'>$('#miModalEliminar').modal('show');</script>";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", scriptModal, false);
        }

        protected void btnConfirmaEliminar_Click(object sender, EventArgs e)
        {
            //Una vez agregado un producto XXXX, no se puede eliminar de inmediato, se debe asignar stock 
            //El producto una vez ingresado solo puede modificarse 

            string code = editarCodigo.Text;
            //Elimino el stock primero
            string sql = "DELETE DepositosProductos WHERE productoID = " + code;

            if (claseDatos.eliminar(sql))
            {
                //Elimino producto
                string query = "DELETE Productos WHERE productoID = " + code;

                if (claseDatos.eliminar(query))
                {
                    //Mostrar ventana emergente de exito
                    string script = @"<script type='text/javascript'>$('#miModalEliminarExito').modal('show');</script>";
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

        protected void btnStock_Click(object sender, EventArgs e)
        {
            Response.Redirect("/paginaAdministrador/adminProductosStock.aspx");
        }
    }
}