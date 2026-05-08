<?php
// db.php
$host = getenv('DB_HOST') ?: 'db';
$db   = getenv('DB_NAME') ?: 'shopiacademy';
$user = getenv('DB_USER') ?: 'myuser';
$pass = getenv('DB_PASS') ?: 'mypassword';
$port = getenv('DB_PORT') ?: '5432';

$dsn = "pgsql:host=$host;port=$port;dbname=$db";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    // For production, you wouldn't want to show the exact error.
    // For development/practice platform, it's helpful.
    throw new \PDOException($e->getMessage(), (int)$e->getCode());
}
?>
