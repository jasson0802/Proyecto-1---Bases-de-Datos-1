<!DOCTYPE html>
<html class="no-js"><head><!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]--><!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]--><!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]--><!--[if gt IE 8]><!--><!--<![endif]-->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        
        <title></title><meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <style>
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            
        </style>
        <link rel="stylesheet" href="css/bootstrap-responsive.min.css">
        <link rel="stylesheet" href="css/main.css">

        <script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script></head>

    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

        <!-- This code is taken from http://twitter.github.com/bootstrap/examples/hero.html -->

        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Innovative Ideas</a>
                    <div class="nav-collapse collapse">
                       
                        <form class="navbar-form pull-right" method = 'POST' action = 'inicioSesion.php'>
                            <input name = 'username' class="span2" placeholder="Email" type="text">
                            <input name = 'password'class="span2" placeholder="Password" type="password">
                            <button type="submit" class="btn">Sign in</button>
                        </form>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <div class="container">

            <!-- Main hero unit for a primary marketing message or call to action -->
 

            <!-- Example row of columns -->
            <div class="row">
          
                <div class="span6">
                    <h2>Únete al cambio</h2>
                    <p>Esta pagina esta dedicada a mi familia, amigos y toda la gallada. Conocen mops!</p>
                    
                    <figure><figcaption><img src = "img/ubuntu.jpg"/></figcaption></figure>
                    <p></p>
                    
               </div>
                <div class="span4 offset2">
                    <h2>Registrarse</h2>
                    <form clase="navbar-form pull-left">
                        <input class="span3" placeholder="Nombre Completo" type="text">
                        <input class="span3" placeholder="Correo electronico" type="text">
                        <input class="span3" placeholder="Fecha de Nacimiento" type="date">
                        <input class="span3" placeholder="Password" type="password">
                        <a class="btn btn-info" href="#">Registrarme »</a>
                    
                    </form>
                    
                </div>
            </div>
            
            <!--<div class="row">
                <p></p>
                <p><a class="btn" href="#">Ver mas »</a></p>
            </div>-->

            <hr>

            <footer>
                </footer><p>© Instituto Tecnológico de Costa Rica 2013</p>
            

        </div> <!-- /container -->

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.1.min.js"><\/script>')</script>

        <script src="js/vendor/bootstrap.min.js"></script>

        <script src="js/main.js"></script>

        <script>
            var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src='//www.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,'script'));
        </script>
    </body></html>