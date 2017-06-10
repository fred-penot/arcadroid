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

$app['service.game'] = function ($app) {
    return new Arcadroid\Services\Japscan($app['db'], $app['monolog']);
};
