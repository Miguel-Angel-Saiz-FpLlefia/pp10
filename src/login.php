<?php
session_start();
require_once 'db.php';

$error = '';
$success = '';

// Handle Logout
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: index.php");
    exit;
}

// Handle Login / Register
$isRegister = isset($_GET['register']) ? true : false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($action === 'register') {
        $email = trim($_POST['email'] ?? '');
        if (empty($username) || empty($email) || empty($password)) {
            $error = 'Por favor, rellena todos los campos.';
        } else {
            // Check if user exists
            $stmt = $pdo->prepare("SELECT id FROM users WHERE username = ? OR email = ?");
            $stmt->execute([$username, $email]);
            if ($stmt->fetch()) {
                $error = 'El usuario o el correo electrónico ya existen.';
            } else {
                $hash = password_hash($password, PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)");
                if ($stmt->execute([$username, $email, $hash])) {
                    $success = 'Registro exitoso. Ya puedes iniciar sesión.';
                    $isRegister = false; // switch to login view
                } else {
                    $error = 'Hubo un problema al registrar el usuario.';
                }
            }
        }
    } elseif ($action === 'login') {
        if (empty($username) || empty($password)) {
            $error = 'Por favor, rellena todos los campos.';
        } else {
            $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
            $stmt->execute([$username]);
            $user = $stmt->fetch();

            if ($user && password_verify($password, $user['password_hash'])) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['username'];
                $_SESSION['xp'] = $user['xp'];
                header("Location: theory.php");
                exit;
            } else {
                $error = 'Usuario o contraseña incorrectos.';
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso - ShopiAcademy</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen">

    <!-- Navbar -->
    <nav class="bg-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="index.php" class="flex-shrink-0 flex items-center">
                        <span class="font-bold text-2xl text-emerald-600 tracking-tight">ShopiAcademy</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full bg-white p-8 rounded-xl shadow-lg border border-gray-100">
            <div>
                <h2 class="mt-2 text-center text-3xl font-extrabold text-gray-900">
                    <?php echo $isRegister ? 'Crea tu cuenta' : 'Inicia sesión'; ?>
                </h2>
            </div>

            <?php if ($error): ?>
                <div class="bg-red-50 text-red-700 p-3 rounded-md mt-4 text-sm text-center">
                    <?php echo htmlspecialchars($error); ?>
                </div>
            <?php endif; ?>
            <?php if ($success): ?>
                <div class="bg-emerald-50 text-emerald-700 p-3 rounded-md mt-4 text-sm text-center">
                    <?php echo htmlspecialchars($success); ?>
                </div>
            <?php endif; ?>

            <form class="mt-8 space-y-6" action="login.php<?php echo $isRegister ? '?register=1' : ''; ?>" method="POST">
                <input type="hidden" name="action" value="<?php echo $isRegister ? 'register' : 'login'; ?>">
                <div class="rounded-md shadow-sm -space-y-px">
                    <div>
                        <label for="username" class="sr-only">Usuario</label>
                        <input id="username" name="username" type="text" required class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 <?php echo $isRegister ? 'rounded-t-md' : 'rounded-t-md'; ?> focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Nombre de usuario">
                    </div>
                    <?php if ($isRegister): ?>
                    <div>
                        <label for="email" class="sr-only">Correo electrónico</label>
                        <input id="email" name="email" type="email" required class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Correo electrónico">
                    </div>
                    <?php endif; ?>
                    <div>
                        <label for="password" class="sr-only">Contraseña</label>
                        <input id="password" name="password" type="password" required class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Contraseña">
                    </div>
                </div>

                <div>
                    <button type="submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-emerald-600 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition">
                        <?php echo $isRegister ? 'Registrarse' : 'Entrar'; ?>
                    </button>
                </div>
            </form>

            <div class="mt-6 text-center text-sm">
                <?php if ($isRegister): ?>
                    <p class="text-gray-600">¿Ya tienes cuenta? <a href="login.php" class="font-medium text-emerald-600 hover:text-emerald-500">Inicia sesión aquí</a></p>
                <?php else: ?>
                    <p class="text-gray-600">¿No tienes cuenta? <a href="login.php?register=1" class="font-medium text-emerald-600 hover:text-emerald-500">Regístrate gratis</a></p>
                <?php endif; ?>
            </div>
        </div>
    </div>

</body>
</html>
