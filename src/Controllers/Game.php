<?php
use Silex\Application;
use Symfony\Component\HttpFoundation\Response;

$game = $app['controllers_factory'];

$game->get('/api/list/{token}', 
    function ($token) use($app) {
        try {
            $gameList = $app['service.game']->getList();
            if ($gameList instanceof \Exception) {
                throw new \Exception($gameList->getMessage());
            }
            $app['retour'] = array(
                "gameList" => $gameList
            );
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

return $game;
