<?php
namespace Arcadroid\Commands;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class GenerateSqlGameCommand extends \Knp\Command\Command {
    private $log;
    private $host;
    private $user;
    private $port;
    private $password;
    private $con;
    private $db;
    private $sqlPath;
    private $gameList;

    protected function configure() {
        $this->setName("generate:sql")->setDescription(
            "Genere le code SQL correspondant a un dossier de jeu.");
    }

    protected function execute(InputInterface $input, OutputInterface $output) {
        $this->init();
        try {
            $this->connectSsh();
            $this->generateGameList();
            $this->generateSql();
            //$this->renameFile();
            $msg = "Fichier genere et disponible a l emplacement : ".$this->sqlPath;
            $this->log->addInfo($msg);
            $output->writeln($msg);
        } catch (\Exception $ex) {
            $this->log->addError($ex->getMessage());
            $output->writeln("Une erreur s'est produite : " . $ex->getMessage());
        }
    }

    private function init() {
        ini_set('memory_limit', '512M');
        $app = $this->getSilexApplication();
        $this->log = $app['monolog.game'];
        $this->host = '192.168.1.20';
        $this->user = 'root';
        $this->port = '22';
        $this->password = 'recalboxroot';
        $this->con = null;
        $this->db = $app['db'];
        $this->sqlPath = realpath(dirname(__FILE__).'/../../app/log').'/game.sql';
        $this->gameList = [];
    }

    private function connectSsh() {
        try {
            $this->con  = ssh2_connect($this->host, $this->port);
            if( !$this->con ) {
                throw new \Exception("Connection failed !");
            }
            if (!ssh2_auth_password($this->con, $this->user, $this->password)) {
                throw new \Exception("Authorization failed !");
            }
        } catch (\Exception $ex) {
            throw new \Exception("Une erreur s'est produite : " . $ex->getMessage());
        }
    }

    private function getEmulatorList() {
        try {
            $sql = "SELECT * FROM emulator;";
            $emulators = $this->db->fetchAll($sql);
            return $emulators;
        } catch (\Exception $ex) {
            throw new \Exception("Une erreur s'est produite : " . $ex->getMessage());
        }
    }

    private function checkGame($game) {
        try {
            $sql = "SELECT * FROM game WHERE rom='".$game['rom']."' AND emulator_id=".$game['emulator_id']." ;";
            $gameCount = $this->db->fetchAll($sql);
            if (count($gameCount)==0) {
                return true;
            } else {
                return false;
            }
        } catch (\Exception $ex) {
            throw new \Exception("Une erreur s'est produite : " . $ex->getMessage());
        }
    }

    private function generateGameList() {
        try {
            $emulators = $this->getEmulatorList();
            foreach ($emulators as $emulator) {
                $path = $emulator['path'];
                $cmd = 'ls '.$path;
                $streamLaunch = ssh2_exec( $this->con, $cmd );
                if( !$streamLaunch ) {
                    throw new \Exception("Impossible de lancer la commande <".$cmd.">");
                }
                stream_set_blocking($streamLaunch, true);
                $streamLines = stream_get_contents($streamLaunch);
                $games = explode("\n", $streamLines);
                foreach ($games as $game) {
                    if ($game != '') {
                        $findExtension = false;
                        $extensions = explode(',', $emulator['extension']);
                        foreach ($extensions as $extension) {
                            if (strrpos($game, '.'.$extension)!==false) {
                                $findExtension = true;
                            }
                        }
                        if ($findExtension) {
                            $romPosParenthese = strpos($game, '(');
                            $gameTemp = $game;
                            if ($romPosParenthese !== false) {
                                $gameTemp = trim(substr($game, 0, $romPosParenthese)).'.'.$extension;
                            }
                            $name = str_replace(array('.'.$extension,'_'), array('', ' '), $gameTemp);
                            $rom = str_replace([' ', '\''], '_', $gameTemp);
                            $gameCheck = [
                                'rom' => $rom,
                                'emulator_id' => $emulator['id'],
                            ];
                            if ($this->checkGame($gameCheck)) {
                                $this->gameList[] = [
                                    'source' => $game,
                                    'name' => $name,
                                    'rom' => $rom,
                                    'sql' => 'INSERT INTO `game` VALUES (null,"'.$name.'","'.$rom.'","'.$name.' '.$emulator['keyword'].'",'.$emulator['id'].', 1);',
                                    'command' => 'mv '.$path.str_replace([' ', '\'', '!', '(', ')', '[', ']'], ['\ ', '\\\'', '\!', '\(', '\)', '\[', '\]'], $game).' '.$path.$rom,
                                ];
                            }
                        }
                    }
                }
            }
        } catch (\Exception $ex) {
            throw new \Exception("Une erreur s'est produite : " . $ex->getMessage());
        }
    }

    private function generateSql() {
        try {
            if (file_exists($this->sqlPath)) {
                unlink($this->sqlPath);
            }
            $sqlFile = fopen($this->sqlPath, 'a+');
            foreach ($this->gameList as $game) {
                fputs($sqlFile, $game['sql']."\n");
            }
            fclose($sqlFile);
        } catch (\Exception $ex) {
            throw new \Exception("Une erreur s'est produite : " . $ex->getMessage());
        }

    }

    private function renameFile() {
        try {
            foreach ($this->gameList as $game) {
                $cmd = $game['command'];
                $streamLaunch = ssh2_exec( $this->con, $cmd );
                if( !$streamLaunch ) {
                    throw new \Exception("Impossible de lancer la commande <".$cmd.">");
                }
            }
        } catch (\Exception $ex) {
            throw new \Exception("Une erreur s'est produite : " . $ex->getMessage());
        }

    }
}