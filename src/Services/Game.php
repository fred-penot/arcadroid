<?php
namespace Arcadroid\Services;

class Game {
    private $db = null;
    private $emulatorBin = null;
    private $pathRom = null;
    private $sshHost = null;
    private $sshPort = null;
    private $sshUser = null;
    private $sshPassword = null;
    private $log = null;

    public function __construct($db, $emulatorBin, $pathRom, $sshHost,
                                $sshPort, $sshUser, $sshPassword, $log) {
        $this->db = $db;
        $this->emulatorBin = $emulatorBin;
        $this->pathRom = $pathRom;
        $this->sshHost = $sshHost;
        $this->sshPort = $sshPort;
        $this->sshUser = $sshUser;
        $this->sshPassword = $sshPassword;
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

    public function getGameEmulatorList($json) {
        try {
            $request = json_decode($json);
            if (!isset($request->emulatorId)) {
                throw new \Exception("Veuiller renseigner l'attribut 'emulatorId'", 500);
            }
            return $this->getGameInfo('where e.id='.$request->emulatorId.';', false);
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors de la récupération de l'ensemble des jeux de l'émulateur: ".$ex->getMessage(), $ex->getCode());
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
            $stream = ssh2_exec($sshCon, $gameInfo[0]['command']);
            if( !$stream ) {
                throw new \Exception("Impossible de lancer la commande !", 500);
            }
            stream_set_blocking($stream, true);
            $streamLines = stream_get_contents($stream);
            return true;
        } catch (\Exception $ex) {
            throw new \Exception("Erreur lors du lancement du jeu : ".$ex->getMessage(), $ex->getCode());
        }

    }

    public function stop() {
        try {
            $sshCon = $this->sshConnectRecalbox();
            $searchType = $this->emulatorBin;
            foreach ($searchType as $search) {
                $cmd = 'ps -ef | grep '.$search.' | grep -v grep';
                $streamGrep = ssh2_exec($sshCon, $cmd);
                if( !$streamGrep ) {
                    throw new \Exception("Impossible de lancer la commande !", 500);
                } else {
                    $pid = null;
                    stream_set_blocking($streamGrep, true);
                    $streamLines = stream_get_contents($streamGrep);
                    $lines = explode("\n", $streamLines);
                    foreach ($lines as $line){
                        $field = explode(" ", trim($line));
                        $pid = $field[0];
                        if ($pid!=''){
                            $streamKill = ssh2_exec( $sshCon, 'kill '.$pid );
                            if( !$streamKill ) {
                                throw new \Exception("Impossible de tuer le processus".$pid." !", 500);
                            }
                        }
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
            $cmd = 'ps -ef | grep '.$this->pathRom.' | grep -v grep';
            $streamGrep = ssh2_exec($sshCon, $cmd);
            if( !$streamGrep ) {
                throw new \Exception("Impossible de lancer la commande !", 500);
            } else {
                stream_set_blocking($streamGrep, true);
                $streamLines = stream_get_contents($streamGrep);
                $lines = explode("\n", $streamLines);
                if (count($lines) > 0) {
                    foreach ($lines as $line){
                        $field = explode($this->pathRom, $line);
                        $path = explode('/', $field[1]);
                        $romZip = trim($path[1]);
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

    public function getEmulator() {
        try {
            $sql = "SELECT e.id as id, e.name as name from emulator e;";
            $emulator = $this->db->fetchAll($sql);
            return $emulator;
        } catch (\Exception $ex) {
            throw new \Exception($ex->getMessage(), 500);
        }
    }

    private function sshConnectRecalbox() {
        try {
            $sshCon  = ssh2_connect($this->sshHost, $this->sshPort);
            if( !$sshCon ) {
                throw new \Exception("Erreur réseau", 500);
            } else {
                if( !ssh2_auth_password( $sshCon, $this->sshUser, $this->sshPassword ) ) {
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
                " t.id as type_id, t.name as type_name, ".
                " e.id as emulator_id, e.name as emulator_name, ".
                " e.keyword as emulator_keyword, e.command as emulator_command FROM game g" .
                " JOIN type t ON t.id=g.type_id" .
                " JOIN emulator e ON e.id=g.emulator_id ";
            if ($where) {
                $sql.=$where;
            }
            $games = $this->db->fetchAll($sql);
            foreach ($games as $game) {
                $command = str_replace('__ROM_NAME__', $game['rom'], $game['emulator_command']);
                $gameList[] = array(
                    "id" => $game['id'],
                    "name" => $game['title'],
                    "rom" => $game['rom'],
                    "keyword" => $game['title'].' '.$game['emulator_keyword'],
                    "type" => array(
                        "id" => $game['type_id'],
                        "name" => $game['type_name']
                    ),
                    "emulator" => array(
                        "id" => $game['emulator_id'],
                        "name" => $game['emulator_name']
                    ),
                    "command" => $command
                );
                if ($withScreenView) {
                    $gameList[count($gameList)-1]["screenview"] = $this->getGoogleImage($game['title'].' '.$game['emulator_keyword']);
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
