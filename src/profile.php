<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

require_once 'db.php';

// Get User Info
$stmt = $pdo->prepare("SELECT username, xp FROM users WHERE id = ?");
$stmt->execute([$_SESSION['user_id']]);
$user = $stmt->fetch();
$xp = $user['xp'];
$_SESSION['xp'] = $xp; // ensure session matches DB

// Calculate Rank Logic
$rank = 'Novato';
$nextRankXP = 100;
$prevRankXP = 0;
$progressPercent = 0;

if ($xp >= 1000) {
    $rank = 'Experto Shopify';
    $nextRankXP = 1000;
    $prevRankXP = 1000;
    $progressPercent = 100;
} elseif ($xp >= 500) {
    $rank = 'Avanzado';
    $nextRankXP = 1000;
    $prevRankXP = 500;
    $progressPercent = (($xp - $prevRankXP) / ($nextRankXP - $prevRankXP)) * 100;
} elseif ($xp >= 200) {
    $rank = 'Intermedio';
    $nextRankXP = 500;
    $prevRankXP = 200;
    $progressPercent = (($xp - $prevRankXP) / ($nextRankXP - $prevRankXP)) * 100;
} else {
    $rank = 'Novato';
    $nextRankXP = 200;
    $prevRankXP = 0;
    $progressPercent = (($xp - $prevRankXP) / ($nextRankXP - $prevRankXP)) * 100;
}

// Get recent scores
$stmt = $pdo->prepare("SELECT score, total_questions, xp_earned, played_at FROM scores WHERE user_id = ? ORDER BY played_at DESC LIMIT 10");
$stmt->execute([$_SESSION['user_id']]);
$recentScores = $stmt->fetchAll();

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - ShopiAcademy</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <!-- Navbar -->
    <nav class="bg-white shadow-sm border-b">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="index.php" class="flex items-center text-xl font-bold text-emerald-600">
                        <svg class="w-8 h-8 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path></svg>
                        ShopiAcademy
                    </a>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="flex flex-col items-end border-r pr-4 border-gray-300">
                        <span class="text-sm font-semibold text-gray-700"><?php echo htmlspecialchars($_SESSION['username']); ?></span>
                        <span class="text-xs text-yellow-600 font-bold"><?php echo $xp; ?> XP</span>
                    </div>
                    <a href="profile.php" class="text-emerald-600 font-medium ml-4">Mi Perfil</a>
                    <a href="theory.php" class="text-gray-600 hover:text-emerald-600 font-medium">Teoría</a>
                    <a href="game.php" class="text-gray-600 hover:text-emerald-600 font-medium">Juego</a>
                    <a href="login.php?logout=1" class="bg-gray-200 hover:bg-gray-300 text-gray-800 px-4 py-2 rounded-md text-sm font-medium transition">Salir</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Profile Header -->
    <div class="max-w-4xl mx-auto mt-10 px-4">
        <div class="bg-white shadow-xl rounded-lg overflow-hidden border border-gray-200">
            <div class="bg-emerald-600 px-6 py-8 text-center text-white relative">
                <h1 class="text-3xl font-bold mb-2"><?php echo htmlspecialchars($user['username']); ?></h1>
                <p class="text-emerald-100 uppercase tracking-widest font-semibold text-sm mb-4">Rango: <?php echo $rank; ?></p>
                
                <div class="inline-block bg-white text-emerald-700 rounded-full px-6 py-2 font-bold shadow-md">
                    <?php echo $xp; ?> / <?php echo $rank == 'Experto Shopify' ? 'MAX' : $nextRankXP; ?> XP
                </div>
            </div>

            <!-- XP Progress Bar -->
            <?php if ($rank != 'Experto Shopify'): ?>
            <div class="px-8 pt-6">
                <div class="flex justify-between text-xs text-gray-500 font-bold mb-1">
                    <span><?php echo $prevRankXP; ?> XP</span>
                    <span>Progreso al siguiente rango</span>
                    <span><?php echo $nextRankXP; ?> XP</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-4 overflow-hidden shadow-inner">
                    <div class="bg-gradient-to-r from-emerald-400 to-emerald-600 h-4 rounded-full transition-all duration-500" style="width: <?php echo $progressPercent; ?>%"></div>
                </div>
            </div>
            <?php endif; ?>

            <!-- Recent Matches -->
            <div class="px-8 py-8">
                <h2 class="text-xl font-bold text-gray-800 border-b pb-2 mb-4">Últimas Partidas</h2>
                <?php if (count($recentScores) > 0): ?>
                    <ul class="space-y-3">
                        <?php foreach($recentScores as $s): ?>
                        <li class="bg-gray-50 border border-gray-100 rounded-lg p-4 flex justify-between items-center hover:bg-emerald-50 transition">
                            <span class="text-gray-500 text-sm font-medium"><?php echo date('d M Y, H:i', strtotime($s['played_at'])); ?></span>
                            <span class="text-emerald-600 font-bold px-3 py-1 bg-emerald-100 rounded-full">+<?php echo $s['xp_earned']; ?> XP</span>
                        </li>
                        <?php endforeach; ?>
                    </ul>
                <?php else: ?>
                    <div class="text-center py-8">
                        <p class="text-gray-500 mb-4">Aún no has jugado ninguna partida.</p>
                        <a href="game.php" class="bg-emerald-600 text-white px-6 py-2 rounded-md font-medium hover:bg-emerald-700">Ir a jugar</a>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>
</html>
