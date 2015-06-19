<?php 
session_start();
include "consultas.php";


if (!empty($_SESSION["username"])) 
  {
    $idUsuario = $_SESSION["idUsuario"];
    $username = $_SESSION["username"];

echo "<!DOCTYPE html>
<html class='no-js'><head><!--[if lt IE 7]>      <html class='no-js lt-ie9 lt-ie8 lt-ie7'> <![endif]--><!--[if IE 7]>         <html class='no-js lt-ie9 lt-ie8'> <![endif]--><!--[if IE 8]>         <html class='no-js lt-ie9'> <![endif]--><!--[if gt IE 8]><!--><!--<![endif]-->
        <meta charset='utf-8'>
        <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>
        
        <title></title><meta name='description' content=''>
        <meta name='viewport' content='width=device-width'>

        <link rel='stylesheet' href='css/bootstrap.min.css'>
        <style>
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            
        </style>
        <link rel='stylesheet' href='css/bootstrap-responsive.min.css'>
        <link rel='stylesheet' href='css/main.css'>

        <script src='js/vendor/modernizr-2.6.2-respond-1.1.0.min.js'></script></head>

    <body>
        <!--[if lt IE 7]>
            <p class='chromeframe'>You are using an <strong>outdated</strong> browser. Please <a href='http://browsehappy.com/'>upgrade your browser</a> or <a href='http://www.google.com/chromeframe/?redirect=true'>activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

        <!-- This code is taken from http://twitter.github.com/bootstrap/examples/hero.html -->

        <div class='navbar navbar-inverse navbar-fixed-top'>
            <div class='navbar-inner'>
                <div class='container'>
                    <a class='btn btn-navbar' data-toggle='collapse' data-target='.nav-collapse'>
                        <span class='icon-bar'></span>
                        <span class='icon-bar'></span>
                        <span class='icon-bar'></span>
                    </a>
                    <a class='brand' href='#'>Innovative Ideas</a>
                    <div class='nav-collapse collapse'>
                        
                        
                          <ul class='nav'>
                            <li class='active'><a href='#'>$username</a></li>
                            <li><a href='#about'>Mis Publicaciones</a></li>
                            <li><a href='#contact'>Contact</a></li>
                            <li class='dropdown'>
                                <a href='#' class='dropdown-toggle' data-toggle='dropdown'>Sesion<b class='caret'></b></a>
                                <ul class='dropdown-menu'>
                                    <li><a href='#'>Ayuda</a></li>
                                    <li><a href='#'>Informacion Legal</a></li>
                                    <li><a href='#'>Configuracion de cuenta</a></li>
                                    <li class='divider'></li>
                                    <li class='nav-header'>Sesion</li>
                                    
                                    <li><a href='cerrarSesion.php'>Cerrar Sesion</a></li>
                                </ul>
                            </li>
                        </ul>
                       
                        <!--<form class='navbar-form pull-right'>
                            <input class='span2' placeholder='Email' type='text'>
                            <input class='span2' placeholder='Password' type='password'>
                            <button type='submit' class='btn'>Sign in</button>
                        </form>-->
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <div class='container'>

            <!-- Main hero unit for a primary marketing message or call to action -->
 

            <!-- Example row of columns -->
            <div class='row'>
          
                <div class='span6'>
                    <div class='hero-unit'>
                <h2>Ver posts publicos</h2>
                <p>Vea los posts más populares</p>
                <!--<FORM method = 'POST' action = 'visualizador.php' >
                <input name = 'idUsuario' class='span1' type='hidden' value = '$idUsuario'";
                 echo"'>-->
                <a class='btn btn-info btn-short pull-right'  href='visualizador.php'>Ver Posts</a>
                </form>

                
                    
               </div></div>
                
                <div class='span6'>
                    <div class='hero-unit'>
                <h2>Ver proyectos exitosos</h2>
                <p>Vea el ranking de post convertidos en proyectos</p>
                 <!--<FORM method = 'POST' action = 'proyectos.php' >
                <input name = 'idUsuario' class='span1' type='hidden' value = '$idUsuario'";
                 echo"'>-->
                <a class='btn btn-info btn-short pull-right'  href ='proyectos.php'>Ver Proyectos</a>
                </form>
                </div>
            </div></div>
            
        
            </div>
            

            <hr>

            <footer>
                </footer><p>© Instituto Tecnológico de Costa Rica 2013</p>
            

        </div> <!-- /container -->

        <script src='//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js'></script>
        <script>window.jQuery || document.write('<script src='js/vendor/jquery-1.10.1.min.js'><\/script>')</script>

        <script src='js/vendor/bootstrap.min.js'></script>

        <script src='js/main.js'></script>

        <script>
            var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src='//www.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,'script'));
        </script>
</body></html>";}



else{
    echo "<a href = 'index.php'>No se pudo inciar sesion</a>";  
}

?>