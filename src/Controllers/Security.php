<?php
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Silex\Application;

$security = $app['controllers_factory'];

$security->post('/auth',
    function (Request $request) use($app) {
        try {
            $auth = $app['service.security']->auth($request->getContent());
            $app['newToken'] = $auth['token'];
            $app['retour'] = $auth;
        } catch (\Exception $ex) {
            $app['code'] = $ex->getCode();
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->after($jsonReturn);

$security->post('/auth/check',
    function () use($app) {
        try {
        } catch (\Exception $ex) {
            $app['code'] = $ex->getCode();
            $app['retour'] = $ex;
        }
        return new Response();
    })
    ->before($checkAuth, Application::EARLY_EVENT)
    ->after($jsonReturn);

return $security;
