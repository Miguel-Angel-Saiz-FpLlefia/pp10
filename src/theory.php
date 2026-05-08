<?php
session_start();
require_once 'db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

// Fetch all modules for sidebar
$stmt = $pdo->query("SELECT slug, title FROM theory_modules ORDER BY id ASC");
$modules = $stmt->fetchAll();

// Default section
$section_slug = $_GET['section'] ?? ($modules[0]['slug'] ?? '');

// Fetch current module content
$stmt = $pdo->prepare("SELECT title, content_html FROM theory_modules WHERE slug = ?");
$stmt->execute([$section_slug]);
$current_module = $stmt->fetch();

// Icons mapped by slug (optional visual enhancement)
$icons = [
    'liquid' => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />',
    'inventory' => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />',
    'checkout' => '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />'
];
$default_icon = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />';

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teoría - ShopiAcademy</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen">

    <!-- Navbar -->
    <nav class="bg-white shadow-sm border-b border-gray-200 z-10 relative">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="index.php" class="flex-shrink-0 flex items-center">
                        <span class="font-bold text-2xl text-emerald-600 tracking-tight">ShopiAcademy</span>
                    </a>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="flex flex-col items-end border-r pr-4 border-gray-300">
                        <span class="text-sm font-semibold text-gray-700"><?php echo htmlspecialchars($_SESSION['username']); ?></span>
                        <span class="text-xs text-yellow-600 font-bold"><?php echo isset($_SESSION['xp']) ? $_SESSION['xp'] : 0; ?> XP</span>
                    </div>
                    <a href="profile.php" class="text-gray-600 hover:text-emerald-600 font-medium ml-4">Mi Perfil</a>
                    <a href="theory.php" class="text-emerald-600 font-medium border-b-2 border-emerald-600 pb-1">Teoría</a>
                    <a href="game.php" class="text-gray-600 hover:text-emerald-600 font-medium">Juego</a>
                    <a href="login.php?logout=1" class="bg-gray-200 hover:bg-gray-300 text-gray-800 px-4 py-2 rounded-md text-sm font-medium transition">Salir</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="flex flex-grow max-w-7xl w-full mx-auto">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-gray-200 flex flex-col hidden md:flex pt-8 px-4">
            <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-4 flex-shrink-0">Módulos</h3>
            <nav class="space-y-2 flex-1 overflow-y-auto pb-4 pr-2">
                <?php foreach ($modules as $mod): ?>
                <a href="theory.php?section=<?php echo urlencode($mod['slug']); ?>" class="<?php echo $section_slug === $mod['slug'] ? 'bg-emerald-50 text-emerald-700' : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'; ?> group flex items-center px-3 py-2 text-sm font-medium rounded-md transition">
                    <svg class="<?php echo $section_slug === $mod['slug'] ? 'text-emerald-500' : 'text-gray-400 group-hover:text-gray-500'; ?> flex-shrink-0 -ml-1 mr-3 h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <?php echo $icons[$mod['slug']] ?? $default_icon; ?>
                    </svg>
                    <?php echo htmlspecialchars($mod['title']); ?>
                </a>
                <?php endforeach; ?>
            </nav>
        </aside>

        <!-- Content Area -->
        <main class="flex-1 bg-white p-8 overflow-y-auto">
            <div class="max-w-3xl">
                <?php if ($current_module): ?>
                    <h1 class="text-3xl font-extrabold text-gray-900 mb-6"><?php echo htmlspecialchars($current_module['title']); ?></h1>
                    <div class="prose prose-emerald max-w-none text-gray-600">
                        <?php echo $current_module['content_html']; // We assume content from DB is safe HTML ?>
                    </div>
                <?php else: ?>
                    <h1 class="text-2xl font-bold text-red-600">Módulo no encontrado</h1>
                    <p>El módulo seleccionado no existe.</p>
                <?php endif; ?>

                <div class="mt-12 flex justify-between border-t border-gray-200 pt-6">
                    <a href="theory.php" class="text-emerald-600 hover:text-emerald-500 font-medium text-sm">&larr; Volver al inicio</a>
                    <a href="game.php" class="bg-emerald-600 hover:bg-emerald-700 text-white px-6 py-2 rounded-md font-medium transition shadow-sm">
                        ¡Gana XP con The Quiz!
                    </a>
                </div>
            </div>
        </main>
    </div>

</body>
</html>
