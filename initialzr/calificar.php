<?php
session_start();
include "consultas.php";

$idUsuario = $_SESSION["idUsuario"];
$idPublicacion = $_POST["idPost"];
$calificacion = $_POST["cali"];


$conexion = conectarse();

$resultado = mysql_query("call calificar('$idUsuario','$idPublicacion','$calificacion')",$conexion);
    
    if (!$resultado){ header("Location:mensajeRepetido.php");}
    
    else{
        $row = mysql_fetch_row($resultado);
        if($row[0]==0){
             header("Location:mensajeRepetido.php");
        }else if($row[0]==1)
            {
            header("Location:mensajeExito.php");
            }
            }
            mysql_close();
?>
