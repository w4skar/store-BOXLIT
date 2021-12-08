using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace store_BOXLIT.clases
{
    public class conexionTablas
    {
        //Cadena de conexion a DigitalOcean para la base de datos SQL
        private string cadena = "Data Source = 165.227.87.112; Initial Catalog = store-BOXLIT; Persist Security Info=True; User ID = sa; Password = w4skar2045!OK";

        //Conexiones
        public SqlConnection cn;
        public SqlDataAdapter da;
        public DataSet ds = new DataSet();
        public SqlCommand comando;
        private conexionBaseDatos Conexion = new conexionBaseDatos();
        private SqlCommand Comando = new SqlCommand();
        private SqlDataReader LeerFilas;

        private void Conectar() { cn = new SqlConnection(cadena); }

        public conexionTablas() { Conectar(); }

        public DataTable consultaTabla(string tabla)
        {
            cn.Open();
            string sql = "SELECT * FROM " + tabla;
            da = new SqlDataAdapter(sql, cn);
            DataSet dts = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(dts, tabla);
            dt = dts.Tables[tabla];

            cn.Close();
            return dt;
        }

        public DataTable consultaProductos(string tabla)
        {
            cn.Open();
            string sql = "SELECT productoID, productoNombre, productoPrecio, categoriaNombre, marcaNombre FROM Productos" + tabla +
            "INNER JOIN ProductosCategorias ON (categoria = categoriaID) INNER JOIN ProductosMarcas ON (marca = marcaID)";

            da = new SqlDataAdapter(sql, cn);
            DataSet dts = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(dts, tabla);
            dt = dts.Tables[tabla];

            cn.Close();
            return dt;
        }

        public DataTable consultaEmpleados(string tabla)
        {
            cn.Open();
            string sql = "SELECT usuarioID, usuarioLogin, UsuarioPass, usuarioTipo, nombre, apellido, usuarioSector FROM" + tabla + "WHERE usuarioTipo='Empleado'";
            da = new SqlDataAdapter(sql, cn);
            DataSet dts = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(dts, tabla);
            dt = dts.Tables[tabla];

            cn.Close();
            return dt;
        }

        public DataTable consultaClientes(string tabla)
        {
            cn.Open();
            string sql = "SELECT usuarioID, usuarioLogin, usuarioPass, usuarioTipo, nombre, apellido FROM" + tabla + "WHERE usuarioTipo='Cliente'";
            da = new SqlDataAdapter(sql, cn);
            DataSet dts = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(dts, tabla);
            dt = dts.Tables[tabla];

            cn.Close();
            return dt;
        }

        public DataTable consultaTablaConUnSQL(string sql)
        {
            cn.Open();
            da = new SqlDataAdapter(sql, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            cn.Close();
            return dt;
        }

        public bool insertar(string sql)
        {
            cn.Open();
            comando = new SqlCommand(sql, cn);
            int i = comando.ExecuteNonQuery();
            cn.Close();

            if (i > 0) { return true; }

            else { return false; }
        }

        public bool modificar(string sql)
        {
            cn.Open();
            comando = new SqlCommand(sql, cn);
            int i = comando.ExecuteNonQuery();
            cn.Close();

            if (i > 0) { return true; }

            else { return false; }
        }

        public bool eliminar(string sql)
        {
            try
            {
                cn.Open();
                comando = new SqlCommand(sql, cn);
                int i = comando.ExecuteNonQuery();
                cn.Close();

                if (i > 0) { return true; }

                else { return false; }
            }

            catch
            {
                cn.Close();
                return false;
            }
        }

        public DataTable MOSTRARTABLA()
        {
            DataTable Tabla = new DataTable();
            Comando.Connection = Conexion.AbrirConexion();
            Comando.CommandText = "SELECT *FROM Productos";

            LeerFilas = Comando.ExecuteReader();
            Tabla.Load(LeerFilas);
            LeerFilas.Close();
            Conexion.CerrarConexion();
            return Tabla;
        }

        public string replaceStr(string str)
        {
            str = str.Replace(',', '.');
            return str;
        }

        public string removeStr(string str)
        {
            str = str.TrimEnd('0');
            return str;
        }
    }
}