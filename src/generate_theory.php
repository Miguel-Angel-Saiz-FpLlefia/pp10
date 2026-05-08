<?php

require_once 'theory_data_1.php';
require_once 'theory_data_2.php';

$topics = array_merge($topics_1, $topics_2);

$inserts = [];
foreach ($topics as $slug => $data) {
    $title = $data['title'];
    $html = $data['html'];
    
    // Wrap in a uniform container class for spacing and presentation
    $wrapped_html = "<div class='text-gray-700 leading-relaxed max-w-4xl'>" . $html . "</div>";
    
    // Escape single quotes for SQL
    $safe_title = str_replace("'", "''", $title);
    $safe_html = str_replace("'", "''", $wrapped_html);
    $inserts[] = "('$slug', '$safe_title', '$safe_html')";
}

$sql_values = implode(",\n", $inserts);

$sql_block = "-- Insert Theory Modules\nINSERT INTO theory_modules (slug, title, content_html) VALUES\n" . $sql_values . ";\n";

$file_path = "database.sql";
$content = file_get_contents($file_path);

// Replace from "-- Insert Theory Modules" to "-- Insert Questions"
$pattern = '/-- Insert Theory Modules.*?;\s*-- Insert Questions/s';
$new_content = preg_replace($pattern, $sql_block . "\n\n-- Insert Questions", $content);

file_put_contents($file_path, $new_content);

echo "database.sql updated successfully with REAL theory modules.\n";
