
<?php
//ini_set( "display_errors", true );
//date_default_timezone_set( "Europe/Minsk" );
define('ROOT', dirname(__FILE__)); //Задаем путь к корневому каталогу (c:/WebServer/Apache24/htdocs/), к которому будем добавлять ссылки на все пути к подключаемым скриптам
require_once ROOT.'/components/router.php';

session_start();

$router = new Route();
$router->run();