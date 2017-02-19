<?php
require_once ROOT."/components/db.php";

class Menu{
    public static function getListMenu(){
        $db = Db::getConnection();
        $result = $db->query("SELECT news_type FROM newstype");
        $listMenu = $result->fetchAll(PDO::FETCH_ASSOC);
        return $listMenu;
    }

    public static function getCategoryMenu(){
        $db = Db::getConnection();
        $result = $db->query("SELECT category FROM category");
        $categoryMenu = $result->fetchAll(PDO::FETCH_ASSOC);
        return $categoryMenu;
    }

}