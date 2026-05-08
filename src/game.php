<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

require_once 'db.php';

// Handle Early Exit
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'finish_early') {
    $_SESSION['game_state'] = 'results';
    header("Location: game.php");
    exit;
}

// Ensure game state exists
if (!isset($_SESSION['game_state'])) {
    $_SESSION['game_state'] = 'start';
}

// 1. START STATE: Select Topic
if ($_SESSION['game_state'] === 'start') {
    // Fetch available modules
    $stmt = $pdo->query("SELECT slug, title FROM theory_modules");
    $modules = $stmt->fetchAll();

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['start_game'])) {
        $selected_module = $_POST['module'] ?? 'all';
        
        if ($selected_module === 'all') {
            $stmt = $pdo->query("SELECT * FROM questions ORDER BY RANDOM()");
        } else {
            $stmt = $pdo->prepare("SELECT * FROM questions WHERE module_slug = ? ORDER BY RANDOM()");
            $stmt->execute([$selected_module]);
        }
        
        $questions = $stmt->fetchAll();
        
        if (count($questions) > 0) {
            $_SESSION['questions'] = $questions;
            $_SESSION['current_q_index'] = 0;
            $_SESSION['current_score'] = 0; // XP
            $_SESSION['correct_answers'] = 0; // Correct answers count
            $_SESSION['game_state'] = 'playing';
            header("Location: game.php");
            exit;
        } else {
            $error = "No hay preguntas disponibles para este tema todavía.";
        }
    }
}

// 2. PLAYING STATE
if ($_SESSION['game_state'] === 'playing') {
    $q_index = $_SESSION['current_q_index'];
    $questions = $_SESSION['questions'];
    
    if ($q_index >= count($questions)) {
        $_SESSION['game_state'] = 'results';
        header("Location: game.php");
        exit;
    }
    
    $current_question = $questions[$q_index];
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (isset($_POST['next'])) {
            // User clicked Next
            unset($_SESSION['show_feedback']);
            unset($_SESSION['correct_idx']);
            $_SESSION['current_q_index']++;
            header("Location: game.php");
            exit;
        } elseif (isset($_POST['answer'])) {
            // User submitted an answer
            $selected_answer = (int)$_POST['answer'];
            $correct_answer = (int)$current_question['correct_answer_index'];
            
            if ($selected_answer === $correct_answer) {
                $_SESSION['current_score'] += $current_question['xp_reward'];
                $_SESSION['correct_answers']++;
                $feedback = "correct";
            } else {
                $feedback = "incorrect";
            }
            
            $_SESSION['show_feedback'] = $feedback;
            $_SESSION['correct_idx'] = $correct_answer;
        }
    }
}

// 3. RESULTS STATE
if ($_SESSION['game_state'] === 'results') {
    $score_xp = $_SESSION['current_score'] ?? 0;
    $correct_ans = $_SESSION['correct_answers'] ?? 0;
    $total_q = isset($_SESSION['questions']) ? count($_SESSION['questions']) : 0;
    
    // Check if we need to save the score (we only save once)
    if (!isset($_SESSION['score_saved'])) {
        try {
            $pdo->beginTransaction();
            
            // Insert history (needs user_id, score, total_questions, xp_earned)
            $stmt = $pdo->prepare("INSERT INTO scores (user_id, score, total_questions, xp_earned) VALUES (?, ?, ?, ?)");
            $stmt->execute([$_SESSION['user_id'], $correct_ans, $total_q, $score_xp]);
            
            // Update total XP
            $stmt = $pdo->prepare("UPDATE users SET xp = xp + ? WHERE id = ?");
            $stmt->execute([$score_xp, $_SESSION['user_id']]);
            
            $pdo->commit();
            $_SESSION['score_saved'] = true;
            
            // Update session xp
            $_SESSION['xp'] += $score_xp;
        } catch (Exception $e) {
            $pdo->rollBack();
            die("Error guardando puntuación: " . $e->getMessage());
        }
    }
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['restart'])) {
        unset($_SESSION['game_state']);
        unset($_SESSION['questions']);
        unset($_SESSION['current_q_index']);
        unset($_SESSION['current_score']);
        unset($_SESSION['correct_answers']);
        unset($_SESSION['show_feedback']);
        unset($_SESSION['correct_idx']);
        unset($_SESSION['score_saved']);
        header("Location: game.php");
        exit;
    }
}

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Quiz - ShopiAcademy</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
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
                        <span class="text-xs text-yellow-600 font-bold"><?php echo isset($_SESSION['xp']) ? $_SESSION['xp'] : 0; ?> XP</span>
                    </div>
                    <a href="profile.php" class="text-gray-600 hover:text-emerald-600 font-medium ml-4">Mi Perfil</a>
                    <a href="theory.php" class="text-gray-600 hover:text-emerald-600 font-medium">Teoría</a>
                    <a href="game.php" class="text-emerald-600 font-medium border-b-2 border-emerald-600 pb-1">Juego</a>
                    <a href="login.php?logout=1" class="bg-gray-200 hover:bg-gray-300 text-gray-800 px-4 py-2 rounded-md text-sm font-medium transition">Salir</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="flex-grow flex items-center justify-center py-12 px-4">
        <div class="max-w-3xl w-full">
            
            <?php if ($_SESSION['game_state'] === 'start'): ?>
                <div class="bg-white p-8 rounded-lg shadow-xl text-center border-t-4 border-emerald-500">
                    <h1 class="text-3xl font-bold text-gray-800 mb-4">The Shopify Quiz</h1>
                    <p class="text-gray-600 mb-8">Selecciona la temática que quieres repasar o elige todas para el reto definitivo.</p>
                    
                    <?php if (isset($error)) echo "<p class='text-red-500 mb-4'>$error</p>"; ?>
                    
                    <form method="POST" class="max-w-md mx-auto">
                        <div class="mb-6 text-left">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tema:</label>
                            <select name="module" class="w-full border-gray-300 rounded-md shadow-sm focus:border-emerald-500 focus:ring-emerald-500 p-2 border">
                                <option value="all">📚 Todos los Temas (Reto Definitivo)</option>
                                <?php foreach ($modules as $mod): ?>
                                    <option value="<?php echo htmlspecialchars($mod['slug']); ?>"><?php echo htmlspecialchars($mod['title']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <button type="submit" name="start_game" class="w-full bg-emerald-600 text-white font-bold py-3 px-4 rounded-lg hover:bg-emerald-700 transition shadow-md">
                            Comenzar Partida
                        </button>
                    </form>
                </div>
                
            <?php elseif ($_SESSION['game_state'] === 'playing'): ?>
                
                <div class="flex justify-between items-center mb-4">
                    <div class="text-sm font-semibold text-gray-500 uppercase tracking-wider">
                        Pregunta <?php echo $_SESSION['current_q_index'] + 1; ?> de <?php echo count($_SESSION['questions']); ?>
                    </div>
                    <div class="flex items-center space-x-4">
                        <div class="text-sm font-bold text-yellow-600 bg-yellow-50 px-3 py-1 rounded-full border border-yellow-200">
                            XP Acumulado: <?php echo $_SESSION['current_score']; ?>
                        </div>
                        <!-- Botón para terminar la partida tempranamente -->
                        <form method="POST" class="inline">
                            <input type="hidden" name="action" value="finish_early">
                            <button type="submit" class="bg-red-50 border border-red-200 text-red-600 hover:bg-red-100 px-3 py-1 rounded-full text-xs font-bold transition">
                                Terminar ahora y guardar
                            </button>
                        </form>
                    </div>
                </div>
                
                <div class="w-full bg-gray-200 rounded-full h-2 mb-6 shadow-inner">
                    <div class="bg-emerald-500 h-2 rounded-full transition-all duration-300" style="width: <?php echo (($_SESSION['current_q_index'] / count($_SESSION['questions'])) * 100); ?>%"></div>
                </div>
                
                <div class="bg-white p-8 rounded-xl shadow-lg border border-gray-100">
                    <div class="flex justify-between items-start mb-6">
                        <h2 class="text-2xl font-bold text-gray-800 leading-tight"><?php echo htmlspecialchars($current_question['question_text']); ?></h2>
                        <span class="bg-emerald-100 text-emerald-800 text-xs font-bold px-3 py-1 rounded-full whitespace-nowrap ml-4 flex-shrink-0">
                            +<?php echo $current_question['xp_reward']; ?> XP
                        </span>
                    </div>
                    
                    <form method="POST" class="space-y-3">
                        <?php 
                        $options = [
                            $current_question['option_0'], 
                            $current_question['option_1'], 
                            $current_question['option_2'], 
                            $current_question['option_3']
                        ];
                        
                        foreach($options as $index => $opt): 
                            $btnClass = "w-full text-left p-4 border-2 rounded-lg transition-all cursor-pointer flex items-center";
                            $icon = "<div class='w-5 h-5 rounded-full border-2 border-gray-300 mr-3 flex-shrink-0'></div>";
                            
                            // Apply feedback styles
                            if (isset($_SESSION['show_feedback'])) {
                                if ($index === $_SESSION['correct_idx']) {
                                    $btnClass = "w-full text-left p-4 border-2 border-emerald-500 bg-emerald-50 rounded-lg flex items-center font-bold text-emerald-700 shadow-sm";
                                    $icon = '<svg class="w-5 h-5 text-emerald-500 mr-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path></svg>';
                                } elseif (isset($_POST['answer']) && (int)$_POST['answer'] === $index && $_SESSION['show_feedback'] === 'incorrect') {
                                    $btnClass = "w-full text-left p-4 border-2 border-red-500 bg-red-50 rounded-lg flex items-center font-bold text-red-700 shadow-sm";
                                    $icon = '<svg class="w-5 h-5 text-red-500 mr-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M6 18L18 6M6 6l12 12"></path></svg>';
                                } else {
                                    $btnClass = "w-full text-left p-4 border-2 border-gray-100 bg-gray-50 opacity-60 rounded-lg flex items-center text-gray-500";
                                }
                            } else {
                                $btnClass .= " border-gray-200 hover:border-emerald-400 hover:bg-emerald-50 text-gray-700";
                            }
                        ?>
                            <button type="submit" name="answer" value="<?php echo $index; ?>" class="<?php echo $btnClass; ?>" <?php echo isset($_SESSION['show_feedback']) ? 'disabled' : ''; ?>>
                                <?php echo $icon; ?>
                                <span><?php echo htmlspecialchars($opt); ?></span>
                            </button>
                        <?php endforeach; ?>
                        
                        <?php if (isset($_SESSION['show_feedback'])): ?>
                            <div class="mt-8 text-center animate-fade-in-up">
                                <button type="submit" name="next" class="bg-gray-900 hover:bg-black text-white font-bold py-3 px-8 rounded-lg transition-all w-full shadow-lg flex items-center justify-center">
                                    Siguiente Pregunta <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                                </button>
                            </div>
                        <?php endif; ?>
                    </form>
                </div>
                
            <?php elseif ($_SESSION['game_state'] === 'results'): ?>
                <div class="bg-white p-10 rounded-2xl shadow-2xl text-center border-t-8 border-emerald-500 max-w-lg mx-auto">
                    <div class="w-24 h-24 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <svg class="w-12 h-12 text-yellow-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"></path></svg>
                    </div>
                    
                    <h1 class="text-3xl font-black text-gray-800 mb-2">¡Partida Terminada!</h1>
                    <p class="text-gray-500 mb-8 font-medium">Aquí tienes los resultados de tu sesión de estudio.</p>
                    
                    <div class="bg-gray-50 rounded-xl p-6 mb-8 border border-gray-200">
                        <p class="text-sm text-gray-500 font-bold uppercase tracking-widest mb-2">XP Conseguida</p>
                        <p class="text-6xl font-black text-emerald-600">+<?php echo $_SESSION['current_score']; ?></p>
                    </div>
                    
                    <form method="POST" class="flex flex-col space-y-3">
                        <button type="submit" name="restart" class="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-4 px-8 rounded-xl shadow-md transition-all">
                            Jugar de nuevo
                        </button>
                        <a href="profile.php" class="w-full bg-white border-2 border-gray-200 text-gray-700 hover:bg-gray-50 hover:border-gray-300 font-bold py-4 px-8 rounded-xl transition-all inline-flex items-center justify-center">
                            Ver Mi Perfil
                        </a>
                    </form>
                </div>
            <?php endif; ?>
            
        </div>
    </main>
</body>
</html>
