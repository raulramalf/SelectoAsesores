<?php
// Ruta hacia la carpeta de caché (sube un nivel desde /public)
$directorio = __DIR__ . '/../bootstrap/cache/';

echo "<h3>Iniciando limpieza profunda...</h3>";

// Buscamos todos los archivos .php en esa carpeta
$archivos = glob($directorio . '*.php');
$borrados = 0;

if ($archivos !== false) {
    foreach($archivos as $archivo) {
        if(is_file($archivo)) {
            unlink($archivo); // Esta es la orden de aniquilación
            echo "<p>🗑️ Eliminado: " . basename($archivo) . "</p>";
            $borrados++;
        }
    }
}

if ($borrados === 0) {
    echo "<p>No se encontraron archivos de caché corruptos.</p>";
}

echo "<h2 style='color:green;'>✅ Limpieza terminada. Ya puedes recargar tu web.</h2>";
?>