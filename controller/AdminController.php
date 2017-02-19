<?php

include_once ROOT."/model/admin.php";
include_once ROOT."/model/news.php";
include_once ROOT."/components/checkdata.php";
include_once ROOT."/components/db.php";
include_once ROOT."/components/paginator.php";

class admincontroller{

    public function ActionIndex(){
        Admin::checkUserAdmin(); // models/admin.php
        $countUsers = Admin::getCountUsers(); //models/admin.php
        $countNews = News::getCountNewsByType('news'); //models/news.php
        $countReviews = News::getCountNewsByType('reviews'); //models/news.php
        include_once ROOT."/view/admin/index.php";
        return true;
    }

    public function ActionUsers(){
        Admin::checkUserAdmin();
        $countUsers = Admin::getCountUsers();
        $listUsers = Admin::getListUsers();
        include_once ROOT."/view/admin/user.php";
        return true;
    }

    public function ActionNews($type = null, $id = 1){
        Admin::checkUserAdmin();
        if ($type == 'page') {
            if (isset($_POST['delete'])){
                $pathFile = ROOT."/style/images/".$_POST['image_path'];
                $idDelete = $_POST['id'];
                $delete = Admin::deleteNewsById($idDelete, $pathFile);
            }
            $displayAllNewsList = News::getAllNewsList($id);
            $countNewsPages = News::getCountNewsPages();
            $paginator = Paginator::getPaginator($id, $countNewsPages);
            include_once ROOT . "/view/admin/listnews.php";
            return true;
        }

        if ($type == 'edit'){
            if (isset($_POST['submit'])){
                $title = checkdata::getSafety($_POST['Title']);
                $news = checkdata::getSafety($_POST['News']);
                $result = Admin::editNews($title, $news, $id);
            }
            $newsItem = News::getNewsItemById($id);
            include_once ROOT . "/view/admin/addnews.php";
            return true;
        }

        if ($type == 'add'){
            if(isset($_POST['add'])){
                $path = ROOT."/style/images/";
                $tmpName = $_FILES['image']['tmp_name'];
                $image_path = $_FILES['image']['name'];
                move_uploaded_file($tmpName, $path.$image_path);
                $id_user = $_SESSION['logged_user']['id_user'];
                $id_newstype = $_POST['news_type'];
                $id_manufacturer = $_POST['id_manufacturer'];
                $id_category = $_POST['id_category'];
                $title = checkdata::getSafety($_POST['Title']);
                $news = checkdata::getSafety($_POST['editor1']);
                $result = Admin::addNews($id_manufacturer,$id_category,$id_user,$id_newstype,$title,$news,$image_path);
            }
            $typesNews = Admin::getTypesNews();
            include_once ROOT."/view/admin/addnews.php";
            return true;
        }
    }
}
