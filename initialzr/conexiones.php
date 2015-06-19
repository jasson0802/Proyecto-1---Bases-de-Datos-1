<?php

function conectarse() {
   $conexion = mysql_connect("localhost", "root", "contrasenia");
     if (!$conexion){die("ERROR DE CONEXION CON MYSQL: " . mysql_error());}
    $base = mysql_select_db("innovativeideas",$conexion);
	if (!$base){die("ERROR CONEXION CON BD: ".mysql_error());}
    return $conexion; 
}

function desconectar(){
    mysql_free_result($resultado);
    mysql_close();
}
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
?>
