<?php

class Route{
    private $routes;

    public function __construct(){
        $routesPath = ROOT."/config/routes.php";
        $this->routes = include $routesPath;
    }

    private function getURI(){
        if (!empty($_SERVER['REQUEST_URI'])){ //Если в адресной строке есть адрес, отличный от корня
            return trim($_SERVER['REQUEST_URI'],'/'); //Обрезаем слэш в конце адреса ()
        }
    }

    public function run(){
        $uri = $this->getURI();

        foreach ($this->routes as $uriPattern => $path){
            if (preg_match("~$uriPattern~",$uri)){ //Если физический адрес исполняемого скрипта совпадает с маской, заданной в routes.php, то
                $internalRoute = preg_replace("~$uriPattern~",$path,$uri); //заменяем его на соответствующий относительный путь из routes.php
                $segments = explode('/',$internalRoute); //Разбиваем относительный путь на отдельные фрагменты

                $controllerName = ucfirst(array_shift($segments)).'Controller'; //и подставляем первый фрагмент к имени Controller, таким образом определяя, какой именно нам нужно вызвать контроллер
                $actionName = 'action'.ucfirst(array_shift($segments)); //а второй фрагмент меняем местами с первым и добавляем к исполняемому методу action

                $parameters = $segments;

                $controllerFile = ROOT.'/controller/'.$controllerName.'.php'; //Определяем физический путь к нужному контроллеру

                if (file_exists($controllerFile)){ //И если файл с контроллером физически существует
                    include $controllerFile; //Подключаем его на выполнение
                }

                $controllerObject = new $controllerName;
                $result = call_user_func_array(array($controllerObject,$actionName),$parameters);
                if ($result != null){
                    break;
                }
            }
        }
    }
}