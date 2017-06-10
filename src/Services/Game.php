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
            $sql = "SELECT * FROM game ;";
            $games = $this->db->fetchAll($sql);
            foreach ($games as $game) {
               $gameList[] = array("id" => $game['id'],
				"name" => $game['name'],
                                "rom" => $game['rom'],);
            }
            return $gameList;
        } catch (\Exception $ex) {
            return $ex;
        }
    }
}
