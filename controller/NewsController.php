<?php

include_once ROOT."/model/news.php";
include_once ROOT."/components/db.php";
include_once ROOT."/components/paginator.php";

class NewsController{
    public function actionStart($pageNumber = 1){ //Отображает главную страницу со списком всех новостей и рецензий
        $displayAllNewsList = News::getAllNewsList($pageNumber); 
        $countNewsPages = News::getCountNewsPages();
        $paginator = Paginator::getPaginator($pageNumber,$countNewsPages);
        require_once ROOT.'/view/news/mainview.php';
        return true;
    }

    public function actionView($type, $id_news=null, $pageNumber=1){
        $errors = false;
        if ($type && $id_news){  //Отображает новость с конкретным ID и комментарии к ней
            if (isset($_POST['sendPost'])){
                $post = htmlspecialchars(addslashes($_POST['Post']));
                var_dump($_POST['Post']);
                $errors = News::checkValidatePost($post);
                if ($errors == false){
                    $id_news = intval($id_news);
                    $id_user = intval($_SESSION['logged_user']['id_user']);
                    News::addPost($id_user,$id_news,$post);
                    header("Location: /news/news/$id_news");
                }
            }
            $newsItem = News::getNewsItemById($id_news);
            $postList = News::getPostById($id_news);
            require_once ROOT.'/view/news/newsview.php';
            return true;
        }

        if ($type){  //Отображает страницу по типу новости: новость или рецензия
            $newsListByType = News::getNewsListByType($type,$pageNumber);
            $newsByTypePages = News::getCountNewsByTypePages($type);
            $paginator = Paginator::getPaginator($pageNumber,$newsByTypePages);
            require_once ROOT.'/view/news/newsviewbytype.php';
        }
        return true;
    }
}
