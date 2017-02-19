<?php
class Admin{
    public static function getCountUsers(){ //Получаем общее количество зарегистрированных пользователей из БД
        $db = Db::getConnection();
        $query = "SELECT COUNT(*) FROM users";
        $result = $db->query($query);
        $countUsers = $result->fetch(PDO::FETCH_NUM);
        return $countUsers[0];
    }

    public static function getListUsers(){ //Получаем список (массив) данных польхователей - id, тип пользователя, логин, пароль, email из БД
        $db = Db::getConnection();
        $query = "SELECT u.id_user, u.id_privilege, u.Login, u.Password, u.Email FROM users u 
                  INNER JOIN privilege ON u.id_privilege = privilege.id_privilege";
        $result = $db->query($query);
        $listUsers = $result->fetchAll(PDO::FETCH_ASSOC);
        return $listUsers;
    }
	
	    public static function getCategoryList(){ //Получаем список (массив) существующих категорий статей из БД
        $db = Db::getConnection();
        $query = "SELECT category.id_category, category.id_parent, category.category FROM category";
        $result = $db->query($query);
        $categoryList = $result->fetchAll(PDO::FETCH_ASSOC);
        return $categoryList;
    }

    public static function editNews($title, $news, $id){ //Метод для проверки заголовка и текста статьи и редактирования статьи (внесения изменений) в базе данных
        $errors = false;

        if (!self::checkValidateTitleNews($title)){
            $errors[] = "Title length should be from 10 to 100 characters!";
        }

        if (!self::checkValidateContentNews($news)){
            $errors[] = "News length should not be less than 200 characters!";
        }

        if ($errors == false) {
            $db = Db::getConnection();
            $query = "UPDATE news n SET n.Title = '$title', n.News = '$news' WHERE n.id_news = $id;";
            $result = $db->query($query);
            return $result;
        }

        return $errors;
    }

    public static function addNews($id_manufacturer,$id_category,$id_user,$id_newstype,$title,$news,$image_path){ //Функция добавления статьи в БД
        $errors = false;

        if (!self::checkValidateTitleNews($title)){
            $errors[] = "Title length should be from 10 to 100 characters!";
        }

        if (!self::checkValidateContentNews($news)){
            $errors[] = "News length should not be less than 200 characters!";
        }

        if (!self::checkValidateFile($image_path)){
            $errors[] = "You forgot to upload a photo!";
        }

        if ($errors == false) {
            $db = Db::getConnection();
            $query = "INSERT INTO news(id_manufacturer,id_category, id_user, id_newstype, title, news) 
                      VALUES($id_manufacturer,$id_category,$id_user,$id_newstype,'$title','$news');
                      INSERT INTO media(image_path,id_news) VALUES('$image_path',LAST_INSERT_ID())";
            $result = $db->query($query);
            return $result;
        }

        return $errors;
    }

    public static function deleteNewsById($id){
        intval($id);
        $db = Db::getConnection();
        $query = "DELETE FROM media WHERE id_news=$id;
                  DELETE FROM news WHERE id_news=$id";
        $deleteNews = $db->query($query);
        return $deleteNews;
    }

    private static function checkValidateTitleNews($title){
        if (strlen($title) >= 10 && strlen($title) <= 100){
            return true;
        }else{
            return false;
        }
    }

    private static function checkValidateContentNews($news){
        if (strlen($news) >= 200){
            return true;
        }else{
            return false;
        }
    }

    private static function checkValidateFile($file){
        if (!empty($file)){
            return true;
        }else{
            return false;
        }
    }

    public static function getTypesNews(){
        $db = Db::getConnection();
        $query = "SELECT * FROM newstype;";
        $result = $db->query($query);
        $typesNews = $result->fetchAll(PDO::FETCH_ASSOC);
        return $typesNews;
    }

    public static function checkUserAdmin(){
        if ($_SESSION['logged_user']){
            $idUser = $_SESSION['logged_user']['id_user'];
            $db = Db::getConnection();
            $query = "SELECT privilege.type_privilege FROM users INNER JOIN privilege
                      ON users.id_privilege = privilege.id_privilege WHERE users.id_user = ?;";
            $result = $db->prepare($query);
            $result->execute(["$idUser"]);
            $statusUser = $result->fetch(PDO::FETCH_ASSOC);
            $statusUser = $statusUser['type_privilege'];
            if ($statusUser == 'admin'){
                return true;
            }else{
                header("Location: /user/login");
            }
        }else{
            header("Location: /user/login");
        }
    }
}