<?php
$app['parameter.db.driver'] = 'pdo_mysql';
$app['parameter.db.host'] = 'localhost';
$app['parameter.db.name'] = 'arcadroid';
$app['parameter.db.login'] = 'root';
$app['parameter.db.password'] = 'Fred8076$';

$app['parameter.log.name'] = 'app.log';
$app['parameter.log.game'] = realpath(__DIR__ . DIRECTORY_SEPARATOR.'log').DIRECTORY_SEPARATOR.'arcadroid.log';

$app['parameter.ssh.host'] = '192.168.1.20';
$app['parameter.ssh.user'] = 'root';
$app['parameter.ssh.port'] = '22';
$app['parameter.ssh.password'] = 'recalboxroot';

$app['parameter.sql.path.game'] = realpath(dirname(__FILE__).DIRECTORY_SEPARATOR.'log').DIRECTORY_SEPARATOR.'game.sql';

$app['parameter.emulator.bin'] = ['retroarch', 'mupen64plus'];

$app['parameter.path.rom'] = '/recalbox/share/roms/';