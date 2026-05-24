<?php
// test.php

$host = 'aws-0-eu-central-1.pooler.supabase.com';
$port = '6543';
$db   = 'postgres';

// OJO AQUÍ: Debe ser "postgres." seguido EXACTAMENTE de las 20 letras de tu proyecto.
// Ejemplo: 'postgres.hytjswqezvytrygbbvls'
$user = 'postgres.qevaqecmyquibiemanwr'; 

// Tu contraseña sin corchetes
$pass = 'dNGNxOpAIOUJJjVn';

$dsn = "pgsql:host=$host;port=$port;dbname=$db";

try {
    $pdo = new PDO($dsn, $user, $pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    echo "✅ ÉXITO: La conexión a Supabase funciona perfectamente.\n";
} catch (PDOException $e) {
    echo "❌ ERROR DE CONEXIÓN: " . $e->getMessage() . "\n";
}