<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: text/plain');

echo "Probando conexión directa a Supabase (Con límite de 3 segundos)...\n";
echo "------------------------------------------------------------------\n";

$host = 'aws-1-eu-west-2.pooler.supabase.com';
$port = '5432';
$db   = 'postgres';
$user = 'postgres.qevaqecmyquibiemanwr';
$pass = 'dNGNxOpAIOUJJjVn'; // Pon tu clave real solo para este test

try {
    $dsn = "pgsql:host=$host;port=$port;dbname=$db;sslmode=require";
    // Forzamos un timeout de 3 segundos para evitar que el servidor lance un 503
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_TIMEOUT => 3,
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
    echo "¡CONEXIÓN EXITOSA! El servidor puede hablar con Supabase perfectamente.";
} catch (PDOException $e) {
    echo "CONEXIÓN RECHAZADA POR EL SERVIDOR:\n";
    echo $e->getMessage();
}