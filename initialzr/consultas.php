<?php
include 'conexiones.php';



function iniciarSesion($username,$password){
    session_start();
    $conexion = conectarse();
    $resultado = mysql_query("call iniciarSesion('$username','$password')",$conexion);
    
    if (!$resultado){die("ERROR Inicio de sesion nombre usuario: $username contrasenia: $password" . mysql_error());}
    
    else{
        $row = mysql_fetch_row($resultado);
        $_SESSION["idUsuario"]=$row[0];
        $_SESSION["username"]=$row[1];
        header("inicio.php");
    }
    
}
   

function cambioPagina($param){
     header('posts.html'); 
}
function verPosts() {
    $conexion = conectarse();
	if (!$conexion){die("ERROR DE CONEXION CON MYSQL: " . mysql_error());}
    $resultado = mysql_query("call visualizarPosts()",$conexion);
	if (!$resultado){die("ERROR CON CONSULTA " . mysql_error());}

    while ($row = mysql_fetch_row($resultado)) {
	if(!$row){die("Error en el ciclo: " . mysql_error());}
	
        else{
        
        
        $fotografia = $row[8];
        
        
        echo "<div class='hero-unit'>";
        echo "<h2>".$row[2]."</h2>";
        echo "<p><img src='$fotografia' height='10%' width='10%'>    ".$row[4]."</p>";
        /*echo "<div class='row'><div class='span3 offset9'>".$row[1]."</div></div>";*/
        echo "<p><FORM method = 'POST' action = 'llamaPost.php' >
	    <input name = 'idPost' class='span1' type='hidden' value = '$row[0]'>
            <input type='submit' class='btn btn-info btn-short pull-right' value = 'Ver Post'>
            </form></p>";
        
         $contador = 0;
         while($contador < round($row[1])){
            	echo "<img src='img/star3.png'>";
                $contador +=1;
        }
        
        $contador = 0;
        while($contador < 5-round($row[1])){
            	echo "<img src='img/starN4.png'>";
                $contador +=1;
        }
    
       echo "</div>"; }
    }
    mysql_close();

}

function visualizarProyectos($idUsuario) {
    $conexion = conectarse();
    if (!$conexion){die("ERROR DE CONEXION CON MYSQL: " . mysql_error());}
    $resultado = mysql_query("call verProyectos('$idUsuario')",$conexion);
    if (!$resultado){die("ERROR CON CONSULTA " . mysql_error());}
    
     while ($row = mysql_fetch_row($resultado)) {
	if(!$row){die("Error en el ciclo: " . mysql_error());}
	else{echo "<div class='hero-unit'>";
        echo "<h2>".$row[2]."</h2>";
        echo "<p>".$row[3]."</p>";
        /*echo "<div class='row'><div class='span3 offset9'>".$row[1]."</div></div>";*/
        echo "<p><FORM method = 'POST' action = 'llamaProyecto.php' >
	    <input name = 'idProyecto' class='span1' type='hidden' value = '$row[0]'>
            <input type='submit' class='btn btn-info btn-short pull-right' value = 'Ver Proyecto'>
            </form></p>";
        
        //$resutaldoCalif = mysql_query("call verPublicacion($row[0])");
        //$calificacion = mysql_fetch_row($resutaldoCalif);
        
         $contador = 0;
         while($contador < round(4)){
            	echo "<img src='img/star3.png'>";
                $contador +=1;
        }
        
        $contador = 0;
        while($contador < 5-round(4)){
            	echo "<img src='img/starN4.png'>";
                $contador +=1;
        }
     
        echo "</div>"; }
    }
    mysql_close();
    

}


function verProyecto($idProyecto){
    
}

function registrar($nombre,$username,$password) {
    $conexion = conectarse();
    $resultado = mysql_query("call registrar($nombre,$username,$)",$conexion);
    if (!$resultado){die("ERROR CON CONSULTA " . mysql_error());}
}



function visualizarPost($idPost){
    $id = $idPost;
    $conexion = conectarse();
   	if (!$conexion){die("ERROR DE CONEXION CON MYSQL: " . mysql_error());}
    $resultado = mysql_query("call verPublicacion($id)",$conexion);
	if (!$resultado){die("ERROR CON CONSULTA" . mysql_error());}

    while ($row = mysql_fetch_row($resultado)) {
	if(!$row){die("Error en el ciclo: " . mysql_error());}
	else{
        echo "<div class='hero-unit'>";
        echo "<h2>".$row[2]."</h2>";
        echo "<p>".$row[3]."</p>";
        
  
        /*echo "<div class='row'><div class='span3 offset9'>".$row[1]."</div></div>";*/
        /*echo "<p><FORM method = 'POST' action = 'llamaPost.php' >
	    <input name = 'idPost' class='span1' type='text' value = '$row[0]'>
            <input type='submit' class='btn btn-info btn-short pull-right'>
            </form></p>";*/
       
         $contador = 0;
         while($contador < round($row[1])){
            	echo "<img src='img/star3.png'>";
                $contador +=1;
        }
        
        $contador = 0;
        while($contador < 5-round($row[1])){
            	echo "<img src='img/starN4.png'>";
                $contador +=1;
        }
       
       echo "<p><FORM method = 'POST' action = 'calificar.php' >
	    <input name = 'idPost' class='span1' type='hidden' value = '$row[0]'>
                
            <input type='radio' name='cali' value='1'> </>
            <input type='radio' name='cali' value='2'> </>
            <input type='radio' name='cali' value='3'> </>
            <input type='radio' name='cali' value='4'> </>
            <input type='radio' name='cali' value='5'> </>
            <input type='submit' class='btn btn-info btn-short' value = 'Calificar'>
            </form></p>";
       echo "</div>"; 
        }
    }
    
    mysql_close();
    
}

function visualizarHijos($idPost){
    $id = $idPost;
    $conexion = conectarse();
   	if (!$conexion){die("ERROR DE CONEXION CON MYSQL: " . mysql_error());}
    $resultado = mysql_query("call verHijos($id)",$conexion);
	if (!$resultado){die("ERROR CON CONSULTA" . mysql_error());}

    while ($row = mysql_fetch_row($resultado)) {
	if(!$row){die("Error en el ciclo: " . mysql_error());}
	else{
        echo "<div class='hero-unit'>";
        echo "<h2>".$row[2]."</h2>";
        echo "<p>".$row[3]."</p>";
       
       
         $contador = 0;
         while($contador < round($row[1])){
            	echo "<img src='img/star3.png'>";
                $contador +=1;
        }
        
        $contador = 0;
        while($contador < 5-round($row[1])){
            	echo "<img src='img/starN4.png'>";
                $contador +=1;
        }
       
       echo "<p><FORM method = 'POST' action = 'calificar.php' >
	    <input name = 'idPost' class='span1' type='hidden' value = '$row[0]'>
                
            <input type='radio' name='cali' value='1'> </>
            <input type='radio' name='cali' value='2'> </>
            <input type='radio' name='cali' value='3'> </>
            <input type='radio' name='cali' value='4'> </>
            <input type='radio' name='cali' value='5'> </>
            <input type='submit' class='btn btn-info btn-short' value = 'Calificar'>
            </form></p>";
       echo "</div>"; 
        }
    }
    
    mysql_close();
    
}



function cerrarSesion($param) {

}
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
?>
