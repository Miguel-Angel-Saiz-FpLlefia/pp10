<?php
session_start();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopiAcademy - Aprende Shopify como un Experto</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 text-gray-800 flex flex-col min-h-screen">

    <!-- Navigation -->
    <nav class="bg-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="index.php" class="flex-shrink-0 flex items-center">
                        <span class="font-bold text-2xl text-emerald-600 tracking-tight">ShopiAcademy</span>
                    </a>
                </div>
                <div class="flex items-center space-x-4">
                    <?php if (isset($_SESSION['user_id'])): ?>
                        <div class="flex flex-col items-end border-r pr-4 border-gray-300">
                            <span class="text-sm font-semibold text-gray-700"><?php echo htmlspecialchars($_SESSION['username']); ?></span>
                            <span class="text-xs text-yellow-600 font-bold"><?php echo isset($_SESSION['xp']) ? $_SESSION['xp'] : 0; ?> XP</span>
                        </div>
                        <a href="profile.php" class="text-gray-600 hover:text-emerald-600 font-medium ml-4">Mi Perfil</a>
                        <a href="theory.php" class="text-gray-600 hover:text-emerald-600 font-medium">Teoría</a>
                        <a href="game.php" class="text-gray-600 hover:text-emerald-600 font-medium">Juego</a>
                        <a href="login.php?logout=1" class="bg-gray-200 hover:bg-gray-300 text-gray-800 px-4 py-2 rounded-md text-sm font-medium transition">Salir</a>
                    <?php else: ?>
                        <a href="login.php" class="text-gray-600 hover:text-emerald-600 font-medium">Iniciar Sesión</a>
                        <a href="login.php?register=1" class="bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-md text-sm font-medium transition">Regístrate</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <main class="flex-grow">
        <div class="relative bg-emerald-700 overflow-hidden">
            <div class="max-w-7xl mx-auto">
                <div class="relative z-10 pb-8 bg-emerald-700 sm:pb-16 md:pb-20 lg:max-w-2xl lg:w-full lg:pb-28 xl:pb-32">
                    <main class="mt-10 mx-auto max-w-7xl px-4 sm:mt-12 sm:px-6 md:mt-16 lg:mt-20 lg:px-8 xl:mt-28">
                        <div class="sm:text-center lg:text-left pt-12">
                            <h1 class="text-4xl tracking-tight font-extrabold text-white sm:text-5xl md:text-6xl">
                                <span class="block xl:inline">Domina Shopify</span>
                                <span class="block text-emerald-300">practicando</span>
                            </h1>
                            <p class="mt-3 text-base text-emerald-100 sm:mt-5 sm:text-lg sm:max-w-xl sm:mx-auto md:mt-5 md:text-xl lg:mx-0">
                                ShopiAcademy es tu plataforma definitiva para aprender todo sobre Shopify. Desde la teoría fundamental hasta juegos interactivos que pondrán a prueba tus conocimientos sobre Liquid y la gestión de tiendas.
                            </p>
                            <div class="mt-5 sm:mt-8 sm:flex sm:justify-center lg:justify-start">
                                <div class="rounded-md shadow">
                                    <a href="login.php?register=1" class="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-emerald-700 bg-white hover:bg-gray-50 md:py-4 md:text-lg transition">
                                        Comenzar ahora
                                    </a>
                                </div>
                                <div class="mt-3 sm:mt-0 sm:ml-3">
                                    <a href="theory.php" class="w-full flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-white bg-emerald-600 hover:bg-emerald-500 md:py-4 md:text-lg transition">
                                        Ver Teoría
                                    </a>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
            <div class="lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2">
                <img class="h-56 w-full object-cover sm:h-72 md:h-96 lg:w-full lg:h-full opacity-80 mix-blend-multiply" src="https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80" alt="Ecommerce Analytics">
            </div>
        </div>

        <!-- Services Section -->
        <div class="py-16 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center">
                    <h2 class="text-base text-emerald-600 font-semibold tracking-wide uppercase">Nuestros Servicios</h2>
                    <p class="mt-2 text-3xl leading-8 font-extrabold tracking-tight text-gray-900 sm:text-4xl">
                        Todo lo que necesitas para ser un experto
                    </p>
                </div>

                <div class="mt-16">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                        
                        <!-- Teoría -->
                        <div class="bg-gray-50 rounded-xl p-8 shadow-sm hover:shadow-md transition border border-gray-100">
                            <div class="flex items-center justify-center h-16 w-16 rounded-md bg-emerald-500 text-white mb-6">
                                <svg class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                </svg>
                            </div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Teoría Completa</h3>
                            <p class="text-gray-600">
                                Aprende los fundamentos de Liquid, cómo gestionar el inventario de manera eficiente y los secretos de un checkout de alta conversión.
                            </p>
                        </div>

                        <!-- Práctica -->
                        <div class="bg-gray-50 rounded-xl p-8 shadow-sm hover:shadow-md transition border border-gray-100">
                            <div class="flex items-center justify-center h-16 w-16 rounded-md bg-emerald-500 text-white mb-6">
                                <svg class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                                </svg>
                            </div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Práctica Real</h3>
                            <p class="text-gray-600">
                                Aplica lo aprendido con ejemplos de código y situaciones del mundo real que te encontrarás administrando tiendas Shopify.
                            </p>
                        </div>

                        <!-- Juegos -->
                        <div class="bg-gray-50 rounded-xl p-8 shadow-sm hover:shadow-md transition border border-gray-100">
                            <div class="flex items-center justify-center h-16 w-16 rounded-md bg-emerald-500 text-white mb-6">
                                <svg class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">El Juego (Trivia)</h3>
                            <p class="text-gray-600">
                                Demuestra lo que sabes en "The Shopify Quiz". Gana puntos y compite para ver quién domina mejor la plataforma.
                            </p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-800 text-gray-400 py-8 text-center">
        <p>&copy; <?php echo date('Y'); ?> ShopiAcademy. Todos los derechos reservados.</p>
        <p class="text-sm mt-2">Plataforma de aprendizaje para desarrolladores y administradores de Shopify.</p>
    </footer>

</body>
</html>
