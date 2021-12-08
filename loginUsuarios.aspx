<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginUsuarios.aspx.cs" Inherits="store_BOXLIT.loginUsuarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Iniciar sesion BOXLIT</title>
    <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="//fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700" rel="stylesheet"/>
    <link href="css/styleLogin.css" rel="stylesheet" />

     <!-- Favicons/ Iconos de pestaña -->
    <link href="img/favicon-boxlit.png" rel="icon"/>
    <link href="img/favicon-boxlit.png" rel="apple-touch-icon"/> 

    <!-- Estilos Modal -->
    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />

     <style type="text/css">
        .auto-style1 {
            max-width: 350px;
            position: relative;
            left: 0px;
            top: 0px;
            padding: 2em 0em;
        }
    </style>

    <!-- Para usar color especifico de un boton en el modal -->
    <style type="text/css">
        .btn-theme03 {
          color: #fff;
          background-color: #48cfad;
          border-color: #37bc9b;
        }
    </style>

</head>

<body>
   <form id="form1" runat="server" method="post">

    <!-- Ventana emergente: Confirmacion de exito -->
    <div class="modal fade" id="miModalExito" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="img/check_ok.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">En buena hora! Proceso realizado correctamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnExito" runat="server" Text="Aceptar" CssClass="btn btn-theme03" OnClick="btnExito_Click" />
                    </div>
                  </div>
                </div>
              </div>

    <!-- Ventana emergente: Confirmacion de error -->
    <div class="modal fade" id="miModalError" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-body" style="font-size:medium"> 
                        <br />
                        <img src="img/check_error.png" class="img-rounded" width="80" height="80" style="display:block; margin:auto" />
                         <h4 style="font-size:medium; text-align:center">Ocurrió un error! Complete nuevamente los datos o intente nuevamente.</h4>
                    </div>
                    <div class="modal-footer">
                      <asp:Button ID="btnError" runat="server" Text="Aceptar" ForeColor="White" OnClick="btnError_Click" CssClass="btn btn-theme03" />
                    </div>
                  </div>
                </div>
              </div>

    <div class="main-top-intro">
        <div class="bg-layer">

            <!-- Logotipo -->
            <div class="wrapper">
                <header>
                    <div class="header-w3layouts">
                        <h1>
                            <a class="navbar-brand logo" href="loginUsuarios.aspx">
                            <img src="img/logotipo-boxlit.png" width="250" height:110 /></a>
                        </h1>
                    </div>
                </header>

                <!-- Cabecera -->
                <div class="content-inner-info" >
                    <div class="auto-style1">
                      <h2 style="font-size:x-large">Iniciar sesión</h2>
                        <br />
                        <div class="form-w3ls-left-info">
                                <input id="usuarioLogin" runat="server" type="text" placeholder="Nombre de usuario" />
                                <input id="usuarioPass" runat="server" type="password" placeholder="Contraseña" />
                                <div class="bottom">
                                    <asp:Button ID="btnAceptar" runat="server" Text="Iniciar sesión" CssClass="styleIniciarSesion" OnClick="btnAceptar_Click" Width="180px"/>
                                </div>
                        </div>
                            <br />
                            <p ><a class="copy-w3layouts-inf" style="color:white; font-size:small" href="../loginRegistro.aspx">¿No tienes una cuenta? Registrate</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

  </form>

    <!-- Estilos Java Script -->
    <script src="lib/jquery/jquery.min.js"></script>
    <script src="lib/bootstrap/js/bootstrap.min.js"></script>
    <script src="lib/nouislider.min.js"></script>
    <script src="lib/jquery.zoom.min.js"></script>
    <script src="lib/main.js"></script>

</body>
</html>
