<?php
session_start();
include "consultas.php";
$username = $_POST["username"];
$password = $_POST["password"];

$conexion = conectarse();
$resultado = mysql_query("select * from usuario where username = '$username' and password ='$password')",$conexion);
    
    if (!$resultado){die("ERROR Inicio de sesion nombre usuario: $username contrasenia: $password" . mysql_error());}
    
    else{
        $row = mysql_fetch_row($resultado);
        $_SESSION["idUsuario"]=$row[0];
        $_SESSION["username"]=$row[1];

        //header("Location:inicio.php");
        echo $_SESSION["username"];

    }
?>
