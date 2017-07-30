<?php
use Monolog\Handler\StreamHandler;
use Monolog\Logger;

/***** log *****/
$app['monolog.game'] = $app->share(
    function ($app) {
        $log = new $app['monolog.logger.class']('game');
        $handler = new StreamHandler($app['parameter.log.game'], Logger::DEBUG);
        $log->pushHandler($handler);
        return $log;
    });
/***** service *****/

$app['service.security'] = function ($app) {
    return new Arcadroid\Services\Security($app['db']);
};

$app['service.game'] = function ($app) {
    return new Arcadroid\Services\Game(
        $app['db'],
        $app['parameter.emulator.bin'],
        $app['parameter.path.rom'],
        $app['parameter.ssh.host'],
        $app['parameter.ssh.port'],
        $app['parameter.ssh.user'],
        $app['parameter.ssh.password'],
        $app['monolog']
    );
};
