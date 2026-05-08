<?php
require_once 'db.php';

echo "<h2>Iniciando instalación de la base de datos...</h2>";

try {
    // Read SQL file
    // Note: We need to go up one level because install.php is in src/ but database.sql is in root
    $sql_path = __DIR__ . '/../database.sql';
    if (!file_exists($sql_path)) {
        die("Error: No se encuentra el archivo database.sql en $sql_path");
    }

    $sql = file_get_contents($sql_path);

    // Execute SQL
    $pdo->exec($sql);

    echo "<p style='color: green;'>✅ Base de datos instalada correctamente.</p>";
    echo "<p>Ahora puedes ir a <a href='index.php'>Inicio</a>.</p>";
    echo "<p><strong>IMPORTANTE:</strong> Por seguridad, elimina este archivo (src/install.php) después de la instalación.</p>";

} catch (Exception $e) {
    echo "<p style='color: red;'>❌ Error durante la instalación: " . $e->getMessage() . "</p>";
}
