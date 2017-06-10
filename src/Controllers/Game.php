<?php
use Silex\Application;
use Symfony\Component\HttpFoundation\Response;

$game = $app['controllers_factory'];

$game->get('/api/list/{token}', 
    function ($token) use($app) {
        try {
            $listeDevice = $app['service.game']->getList();
            if ($listeDevice instanceof \Exception) {
                throw new \Exception($listeDevice->getMessage());
            }
            $app['retour'] = array(
                "listeDevice" => $listeDevice
            );
        } catch (\Exception $ex) {
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

return $game;
