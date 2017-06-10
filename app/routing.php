<?php
$app->mount('/game', include __DIR__ . '/../src/Controllers/Game.php');
$app->mount('/security', include __DIR__ . '/../src/Controllers/Security.php');