<?php
header('Content-Type: text/plain');
echo "Drivers de Base de Datos activos en este instante:\n";
print_r(PDO::getAvailableDrivers());