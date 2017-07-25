<?php
namespace Arcadroid\Services;

class Game {
    private $db = null;
    private $log = null;

    public function __construct($db, $log) {
        $this->db = $db;
        $this->log = $log;
    }

    public function __destruct() {}

    public function getGameList() {
        try {
            return $this->getGameInfo(null, false);
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors de la récupération de l'ensemble des jeux : ".$ex->getMessage(), $ex->getCode());
        }
    }

    public function getFullGameList() {
        try {
            return $this->getGameInfo(null, true);
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors de la récupération de l'ensemble des jeux avec liens image : ".$ex->getMessage(),$ex->getCode());
        }
    }

    public function getGame($json) {
        try {
            $request = json_decode($json);
            if (!isset($request->id)) {
                throw new \Exception("Veuiller renseigner l'attribut 'id'", 500);
            }
            return $this->getGameInfo('where g.id='.$request->id.';', false);
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors de la récupération du jeu : ".$ex->getMessage(), $ex->getCode());
        }
    }

    public function getFullGame($json) {
        try {
            $request = json_decode($json);
            if (!isset($request->id)) {
                throw new \Exception("Veuiller renseigner l'attribut 'id'", 500);
            }
            return $this->getGameInfo('where g.id='.$request->id.';', true);
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors de la récupération du jeu : ".$ex->getMessage(), $ex->getCode());
        }
    }

    public function launch($json) {
        try {
            $request = json_decode($json);
            if (!isset($request->id)) {
                throw new \Exception("Veuiller renseigner l'attribut 'id'", 500);
            }
            $gameInfo = $this->getGameInfo('where g.id='.$request->id.';', false);
            $sshCon = $this->sshConnectRecalbox();
            $cmd = '/recalbox/scripts/runcommand.sh 4 "retroarch -L /usr/lib/libretro/mame078_libretro.so --config /recalbox/share/system/configs/retroarch/retroarchcustom.cfg /recalbox/share/roms/mame/'.$gameInfo[0]['rom'].'.zip"';
            $stream = ssh2_exec($sshCon, $cmd);
            if( !$stream ) {
                throw new \Exception("Impossible de lancer la commande !", 500);
            }
            return true;
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors du lancement du jeu : ".$ex->getMessage(), $ex->getCode());
        }

    }

    public function stop() {
        try {
            $sshCon = $this->sshConnectRecalbox();
            $cmd = 'ps -ef | grep retroarch | grep -v grep';
            $streamGrep = ssh2_exec($sshCon, $cmd);
            if( !$streamGrep ) {
                throw new \Exception("Impossible de lancer la commande !", 500);
            } else {
                $pid = null;
                stream_set_blocking($streamGrep, true);
                $streamLines = stream_get_contents($streamGrep);
                $lines = explode("\n", $streamLines);
                foreach ($lines as $line){
                    $field = explode(" ", $line);
                    $pid = $field[0];
                    if ($pid == '') {
                        $pid = $field[1];
                    }
                    $streamKill = ssh2_exec( $sshCon, 'kill '.$pid );
                    if( !$streamKill ) {
                        throw new \Exception("Impossible de tuer le processus".$pid." !", 500);
                    }
                }
            }
            return true;
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors de l'arret du jeu : ".$ex->getMessage(), $ex->getCode());
        }

    }

    public function getCurrentRunning() {
        try {
            $sshCon = $this->sshConnectRecalbox();
            $cmd = 'ps -ef | grep /recalbox/share/roms/mame/ | grep -v grep';
            $streamGrep = ssh2_exec($sshCon, $cmd);
            if( !$streamGrep ) {
                throw new \Exception("Impossible de lancer la commande !", 500);
            } else {
                stream_set_blocking($streamGrep, true);
                $streamLines = stream_get_contents($streamGrep);
                $lines = explode("\n", $streamLines);
                if (count($lines) > 0) {
                    foreach ($lines as $line){
                        $field = explode('/recalbox/share/roms/mame/', $line);
                        $romZip = trim($field[1]);
                        break;
                    }
                    $gameInfo = $this->getGameInfo('where g.rom="'.str_replace('.zip', '', $romZip).'";', true);
                    return $gameInfo[0];
                } else {
                    return [];
                }
            }
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors de la récupération du jeu courant : ".$ex->getMessage(), $ex->getCode());
        }

    }

    private function sshConnectRecalbox() {
        try {
            $host = '192.168.1.20';
            $port = 22;
            $user = 'root';
            $password = 'recalboxroot';
            $sshCon  = ssh2_connect($host, $port);
            if( !$sshCon ) {
                throw new \Exception("Erreur réseau", 500);
            } else {
                if( !ssh2_auth_password( $sshCon, $user, $password ) ) {
                    throw new \Exception("Erreur de login / mot de passe sur recalbox", 500);
                } else {
                    return $sshCon;
                }
            }
        } catch (\Exception $ex) {
            throw new \Exception("Impossible de se connecter à recalbox : ".$ex->getMessage(), $ex->getCode());
        }
    }

    private function getGameInfo($where=null, $withScreenView=false) {
        try {
            $gameList = array();
            $sql = "SELECT g.id as id, g.name as title, g.rom as rom, ".
                " g.keyword as keyword, t.id as type_id, t.name as type_name, ".
                " e.id as emulator_id, e.name as emulator_name FROM game g " .
                "JOIN type t ON t.id=g.type_id " .
                "JOIN emulator e ON e.id=g.emulator_id ";
            if ($where) {
                $sql.=$where;
            }
            $games = $this->db->fetchAll($sql);
            foreach ($games as $game) {
                $gameList[] = array(
                    "id" => $game['id'],
                    "name" => $game['title'],
                    "rom" => $game['rom'],
                    "keyword" => $game['keyword'],
                    "type" => array(
                        "id" => $game['type_id'],
                        "name" => $game['type_name']
                    ),
                    "emulator" => array(
                        "id" => $game['emulator_id'],
                        "name" => $game['emulator_name']
                    ),
                );
                if ($withScreenView) {
                    $gameList[count($gameList)-1]["screenview"] = $this->getGoogleImage($game['keyword']);
                }
            }
            return $gameList;
        } catch (\Exception $ex) {
            throw new \Exception($ex->getMessage(), 500);
        }
    }

    private function getGoogleImage($keyword){
        try {
            $file = file_get_contents('https://www.google.fr/search?q='.str_replace(' ', '+', $keyword).'&tbm=isch', FILE_USE_INCLUDE_PATH);
            $imgLinkTemp = explode ('src="https://encrypted-tbn0.gstatic.com/images?q=tbn:', $file);
            unset($imgLinkTemp[count($imgLinkTemp)-1]);
            unset($imgLinkTemp[0]);
            $imgLinks=[];
            foreach ($imgLinkTemp as $linkTemp) {
                $linkTemp = explode('" width="', $linkTemp);
                $imgLinks[] = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:'.$linkTemp[0];
            }
            return $imgLinks;
        } catch (\Exception $ex) {
            throw new \Exception($ex->getMessage(), 500);
        }
    }
}
