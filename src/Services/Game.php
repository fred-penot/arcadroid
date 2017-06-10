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

    public function getList() {
        try {
            $gameList = array();
            $sql = "SELECT g.id as id, g.name as title, g.rom as rom, ".
                  " g.keyword as keyword, t.id as type_id, t.name as type_name, ".
                  " e.id as emulator_id, e.name as emulator_name FROM game g " .
                "JOIN type t ON t.id=g.type_id " .
                "JOIN emulator e ON e.id=g.emulator_id ;";
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
            }
            return $gameList;
        } catch (\Exception $ex) {
            return $ex;
        }
    }
}
