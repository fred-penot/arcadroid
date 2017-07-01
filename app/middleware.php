<?php
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Silex\Application;

// function after à positionner obligatoirement avant les routes
$jsonReturn = function (Request $request, Response $response, Application $app) {
    $retour = [];
    try {
        if ($app['retour'] instanceof \Exception) {
            throw new \Exception($app['retour']->getMessage(), $app['retour']->getCode());
        }
        $retour['token'] = $app['newToken'];
        $retour['data'] = $app['retour'];
        if (isset($retour['data']['token'])) {
            unset($retour['data']['token']);
        }
        $app['code'] = 200;
    } catch (\Exception $ex) {
        $app['monolog']->addError($ex->getMessage());
        $retour['message'] = $ex->getMessage();
        $app['code'] = $ex->getCode();
    }
    $header = array(
        "Access-Control-Allow-Origin" => "*"
    );
    return $app->json($retour, $app['code'], $header);
};

// function before à positionner obligatoirement avant les routes
$checkAuth = function (Request $request, Application $app) {
    try {
        $json = json_decode($request->getContent());
        if (!isset($json->token)) {
            throw new \Exception("Veuillez fournir un token.",500);
        }
        $newToken = $app['service.security']->checkAndUpdateToken($json->token);
        $user = $app['service.security']->getUser($newToken);
        $app['newToken'] = $newToken;
        $app['user'] = $user;
        $app['retour'] = [
            "profil" => $user['profil']
        ];
        return;
    } catch (\Exception $ex) {
        $app['retour'] = $ex;
        throw new \Exception($ex->getMessage(),$ex->getCode());
    }
};