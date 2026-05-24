<?php
// Forzamos a PHP a mostrar errores puros
ini_set('display_errors', 1);
error_reporting(E_ALL);

try {
    require __DIR__.'/../vendor/autoload.php';
    $app = require_once __DIR__.'/../bootstrap/app.php';
    $kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

    // AQUÍ ESTÁ LA MAGIA: Hacemos que Laravel procese la visita real
    $response = $kernel->handle(
        $request = Illuminate\Http\Request::capture()
    );

    echo "<h2 style='color:green;'>La petición funcionó. Código: " . $response->getStatusCode() . "</h2>";

} catch (\Throwable $e) {
    // Capturamos el error exacto que tira la web abajo
    echo "<h2 style='color:red;'>🚨 ERROR ENCONTRADO EN LA PANTALLA 🚨</h2>";
    echo "<div style='background:#f4f4f4; padding:15px; border-left: 5px solid red; font-family: monospace;'>";
    echo "<b>Tipo:</b> " . get_class($e) . "<br>";
    echo "<b>Mensaje:</b> " . $e->getMessage() . "<br><br>";
    echo "<b>Archivo:</b> " . $e->getFile() . "<br>";
    echo "<b>Línea:</b> " . $e->getLine();
    echo "</div>";
}