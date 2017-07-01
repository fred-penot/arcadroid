<?php
namespace Arcadroid\Services;

class Security {
    private $db = null;

    public function __construct($db) {
        $this->db = $db;
    }

    public function __destruct() {}

    public function auth($json) {
        try {
            $request = json_decode($json);
            if (!isset($request->login) || !isset($request->password)) {
                throw new \Exception("Veuillez renseigner les attributs 'login' et 'password'");
            }
            $query = "SELECT * FROM user where login='" . $request->login . "' and password='" .
                 md5($request->password) . "';";
            $result = $this->db->fetchAll($query);
            if (count($result) == 0) {
                throw new \Exception("Utilisateur inconnu", 401);
            }
            $token = $this->generateAndUpdateToken($result[0]["id"]);
            return [
                'token' => $token,
                'profil' => $result[0]["profil"],
            ];
        } catch (\Exception $ex) {
            throw new \Exception($ex->getMessage(), $ex->getCode());
        }
    }

    private function generateAndUpdateToken($userId) {
        try {
            $token = bin2hex(openssl_random_pseudo_bytes(16));
            $queryDelete = "DELETE FROM token_user WHERE  user_id='" . $userId . "';";
            $this->db->exec($queryDelete);
            $queryInsert = "INSERT INTO token_user (user_id, value, time) VALUES ('" . $userId .
                 "', '" . $token . "', '" . time() . "');";
            $result = $this->db->exec($queryInsert);
            if (! $result) {
                throw new \Exception("Erreur lors de l'injection du token de l'utilisateur.", 500);
            }
            return $token;
        } catch (\Exception $ex) {
            throw new \Exception($ex->getMessage(), $ex->getCode());
        }
    }

    public function checkAndUpdateToken($token) {
        try {
            $oldTime = time() - (60 * 15);
            $queryDelete = "DELETE FROM token_user WHERE time<'" . $oldTime . "';";
            $this->db->exec($queryDelete);
            $querySelect = "SELECT * FROM token_user WHERE value='" . $token . "';";
            $resultSelect = $this->db->fetchAll($querySelect);
            if (count($resultSelect) == 1) {
                $userId = $resultSelect[0]["user_id"];
                $querySelect = "SELECT * FROM token_user WHERE user_id='" . $userId .
                     "' ORDER BY id ASC;";
                $resultSelect = $this->db->fetchAll($querySelect);
                if (count($resultSelect) > 9) {
                    $queryDelete = "DELETE FROM token_user WHERE id='" . $resultSelect[0]["id"] .
                         "';";
                    $this->db->exec($queryDelete);
                }
                $token = bin2hex(openssl_random_pseudo_bytes(16));
                $queryInsert = "INSERT INTO token_user (user_id, value, time) VALUES ('" . $userId .
                     "', '" . $token . "', '" . time() . "');";
                $result = $this->db->exec($queryInsert);
                if (! $result) {
                    throw new \Exception("Erreur lors de l'injection du token de l'utilisateur.", 500);
                }
            } else {
                throw new \Exception("Erreur lors du contrôle d'autentification.", 401);
            }
            return $token;
        } catch (\Exception $ex) {
            throw new \Exception("Erreur du controle et mise à jour du token : ".$ex->getMessage(), $ex->getCode());
        }
    }
    
    public function getUser($token) {
        try {
            $querySelect = "SELECT * FROM token_user WHERE value='" . $token . "';";
            $resultSelect = $this->db->fetchAll($querySelect);
            if (count($resultSelect) == 1) {
                $queryUser = "SELECT * FROM user where id=".$resultSelect[0]['user_id'].";";
                $user = $this->db->fetchAll($queryUser);
            } else {
                throw new \Exception("Erreur lors de la récupération des infos utilisateurs.", 500);
            }
            return $user[0];
        } catch (\Exception $ex) {
            throw new \Exception($ex->getMessage(), $ex->getCode());
        }
    }
}
