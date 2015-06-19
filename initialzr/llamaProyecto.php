<?php
session_start();
$idProyecto = $_POST["idProyecto"];

include "consultas.php";

//echo "$idPost";

//visualizarPost($idPost);
if (!empty($_SESSION["username"])) 
  {
    $idUsuario = $_SESSION["idUsuario"];
    $username = $_SESSION["username"];


echo "<!DOCTYPE html>
<!--[if lt IE 7]>      <html class='no-js lt-ie9 lt-ie8 lt-ie7'> <![endif]-->
<!--[if IE 7]>         <html class='no-js lt-ie9 lt-ie8'> <![endif]-->
<!--[if IE 8]>         <html class='no-js lt-ie9'> <![endif]-->
<!--[if gt IE 8]><!--> <html class='no-js'> <!--<![endif]-->
    
    <head>
        <meta charset='utf-8'>
        <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>
        <title></title>
        <meta name='description' content=''>
        <meta name='viewport' content='width=device-width'>

        <link rel='stylesheet' href='css/bootstrap.min.css'>
        <style>
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .hero-unit {
			padding: 60px;
			margin-bottom: 30px;
			font-size: 18px;
			font-weight: 200;
			line-height: 30px;
			color: inherit;
			background-color: #35708B;
			-webkit-border-radius: 6px;
			-moz-border-radius: 6px;
			border-radius: 6px;
}
        </style>
        <link rel='stylesheet' href='css/bootstrap-responsive.min.css'>
        <link rel='stylesheet' href='css/main.css'>
            
            
       
        <script src='js/vendor/modernizr-2.6.2-respond-1.1.0.min.js'></script>
        
     
    </head>
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
                    <a class='brand' href='inicio.php'>Innovative Ideas</a>
                    <div class='nav-collapse collapse'>
                        <ul class='nav'>
                            <li class='active'><a href='#'>$idUsuario</a></li>
                            <li><a href='#about'>Mis Publicaciones</a></li>
                            <li><a href='visualizador.php'>Ranking</a></li>
                            <li><a href='proyectos.php'>Proyectos</a></li>
                            
                            <li class='dropdown'>
                                <a href='#' class='dropdown-toggle' data-toggle='dropdown'>Cuenta <b class='caret'></b></a>
                                <p></p>
                                <ul class='dropdown-menu'>
                                    <li><a href='#'>Informacion legal</a></li>
                                    <li><a href='#'>Configuracion de Cuenta</a></li>
                                    <li><a href='#'>Something else here</a></li>
                                    <li class='divider'></li>
                                    <li class='nav-header'>Sesion</li>
                                    <li><a href='#'>Separated link</a></li>
                                    <li><a href='cerrarSesion.php'>Cerrar Sesion</a></li>
                                </ul>
                            </li>
                        </ul>
                        
                        
                      
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <div class='container'>";

            //<!-- Main hero unit for a primary marketing message or call to action -->
             
               visualizarPost($idProyecto);
               visualizarHijos($idProyecto);
      
          echo "   
             
            <!-- Example row of columns -->
            <!--<div class='row'>
                 <div class='span10'>
                    </div>
					<div class = 'span2'>
                    <p><a class='btn' href='#'>Un botoncillo &raquo;</a></p>
                </div>
             
            </div>-->
        
            
            <!--<hr>-->
            
            <div class='row'>
            <div class= 'span2'>
            <form class='navbar-form pull-left'>
            <input type='text' class='span7'>
            <button type='submit' class='btn'>Submit</button>
            </form></div></div>
          

            <footer>
                <p>&copy; Instituto Tecnologico de Costa Rica 2013</p>
            </footer>

        </container>

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
    </body>
</html>
  ";}
  else{
      echo "<a href = 'index.php'>No se pudo inciar sesion</a>";}






//header('Location: index.php');

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
?>
