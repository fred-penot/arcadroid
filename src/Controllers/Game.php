<?php
use Silex\Application;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

$game = $app['controllers_factory'];

$game->post('/list',
    function () use($app) {
        try {
            $app['retour'] = $app['service.game']->getGameList();
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/list/full',
    function ()  use($app) {
        try {
            $app['retour'] = $app['service.game']->getFullGameList();
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/one',
    function (Request $request) use($app) {
        try {
            $app['retour'] = $app['service.game']->getGame($request->getContent());
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/one/full',
    function (Request $request) use($app) {
        try {
            $app['retour'] = $app['service.game']->getFullGame($request->getContent());
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/launch',
    function (Request $request) use($app) {
        try {
            $app['retour'] = $app['service.game']->launch($request->getContent());
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/stop',
    function (Request $request) use($app) {
        try {
            $app['retour'] = $app['service.game']->stop();
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/current',
    function (Request $request) use($app) {
        try {
            $app['retour'] = $app['service.game']->getCurrentRunning();
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/get/emulator',
    function (Request $request) use($app) {
        try {
            $app['retour'] = $app['service.game']->getEmulator();
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

$game->post('/list/emulator',
    function (Request $request) use($app) {
        try {
            $app['retour'] = $app['service.game']->getGameEmulatorList($request->getContent());
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

return $game;

