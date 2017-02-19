<?php
define('DB_HOST','localhost');
define('DB_NAME','projecthtp');
define('DB_CHARSET','utf8');
define('DB_USERNAME','root');
define('DB_PASSWORD','Pass_not_Weak');

class Db{
    public static function getConnection(){
        $db = new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME.";dbcharset=".DB_CHARSET,DB_USERNAME,DB_PASSWORD);
        return $db;
    }
}