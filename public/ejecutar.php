<?php
header('Content-Type: text/plain');
echo "Destruyendo archivo físico de caché de rutas...\n";
echo "--------------------------------------------------\n";

$archivo_rutas = __DIR__ . '/../bootstrap/cache/routes-v7.php';

if (file_exists($archivo_rutas)) {
    if (unlink($archivo_rutas)) {
        echo "¡ÉXITO! El mapa de rutas viejo ha sido destruido.\n";
        echo "Laravel se verá obligado a leer tu web.php real ahora mismo.\n";
    } else {
        echo "ERROR: El archivo existe pero el servidor bloqueó el borrado.\n";
    }
} else {
    echo "El archivo routes-v7.php no existía. ¡Tu mapa de rutas ya está limpio!\n";
}