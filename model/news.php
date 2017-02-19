<?php
define('NEWS_PER_PAGE', 4);
class News{
    public static function getCountNewsByType($news_type){
        $db = Db::getConnection();
        $query = "SELECT COUNT(*) FROM news INNER JOIN newstype ON news.id_newstype = newstype.id_newstype WHERE newstype.news_type = '$news_type';";
        $result = $db->query($query);
        $countNewsByType = $result->fetch(PDO::FETCH_NUM);
        return $countNewsByType[0];
    }

    public static function getCountNewsByTypePages($news_type){
        $newsByTypeCount = self::getCountNewsByType($news_type);
        $newsByTypePages = ceil($newsByTypeCount/NEWS_PER_PAGE);
        //var_dump($newsByTypePages);
        return $newsByTypePages;
    }

    public static function getCountNews()
    {
        $db = Db::getConnection();
        $result = $db->query("SELECT COUNT(*) FROM news;");
        $countNews = $result->fetch(PDO::FETCH_NUM);
        return $countNews;
    }

    public static function getCountNewsPages()
    {
        $countNews = self::getCountNews();
        $countNewsPages = ceil($countNews[0] / NEWS_PER_PAGE);
        //var_dump($countNewsPages);
        return $countNewsPages;

    }

    public static function getAllNewsList($pageNumber)
    {
        $db = Db::getConnection();
        $newsOffset = ($pageNumber - 1) * NEWS_PER_PAGE;
        $result = $db->query('SELECT news.id_news, news.Title, news.News, news.Newsdate, media.image_path, newstype.news_type, users.Login
                              FROM news INNER JOIN newstype ON news.id_newstype = newstype.id_newstype INNER JOIN media
                              ON media.id_news = news.id_news INNER JOIN users ON news.id_user = users.id_user
                              ORDER BY news.id_news DESC LIMIT '.$newsOffset .','. NEWS_PER_PAGE .';');
        $displayAllNewsList = $result->fetchAll(PDO::FETCH_ASSOC);
        //var_dump($displayAllNewsList);
        return $displayAllNewsList;
    }

    public static function getNewsListByType($type, $pageNumber)
    {
        $db = Db::getConnection();
        $newsOffset = ($pageNumber - 1) * NEWS_PER_PAGE;
        $query = ('SELECT news.id_news, users.login, newstype.news_type, news.title, news.news, news.newsdate, media.image_path
                  FROM news INNER JOIN newstype ON news.id_newstype = newstype.id_newstype INNER JOIN media
                  ON media.id_news = news.id_news INNER JOIN users ON news.id_user = users.id_user
                  WHERE newstype.news_type = ? ORDER BY news.id_news DESC LIMIT '.$newsOffset .','. NEWS_PER_PAGE .';');
        $result = $db->prepare($query);
        $result->execute(["$type"]);
        $newsListByType = $result->fetchAll(PDO::FETCH_ASSOC);
        return $newsListByType;
    }

    public static function getNewsItemById($id)
    {
        $id = intval($id);
        if ($id) {
            $db = Db::getConnection();
            $query = "SELECT news.id_news, users.Login, newstype.news_type, news.Title, news.News, news.Newsdate, media.image_path
                      FROM news INNER JOIN newstype ON news.id_newstype = newstype.id_newstype INNER JOIN media
                      ON media.id_news = news.id_news INNER JOIN users ON news.id_user = users.id_user WHERE news.id_news = ?;";
            $result = $db->prepare($query);
            $result->execute(["$id"]);
            $newsItem = $result->fetch(PDO::FETCH_ASSOC);
            return $newsItem;
        }
    }

    public static function getPostById($id)
    {
        if ($id) {
            $db = Db::getConnection();
            $query = "SELECT users.Login, posts.Post, posts.Date FROM users
                      INNER JOIN posts ON posts.id_user = users.id_user
                      WHERE posts.id_news = ? ORDER BY posts.Date DESC;";
            $result = $db->prepare($query);
            $result->execute(["$id"]);
            $postList = $result->fetchAll(PDO::FETCH_ASSOC);
            return $postList;
        }
    }

    public static function addPost($id_user, $id_news, $post)
    {
        $db = Db::getConnection();
        $query = "INSERT INTO posts(id_user, id_news, Post) VALUES($id_user, $id_news, '$post');";
        $result = $db->query($query);
        return $result;
    }

    public static function checkValidatePost($post)
    {
        if (strlen($post) > 10) {
            return false;
        } else {
            $errors[] = "Comment should be at least 10 characters";
            return $errors;
        }
    }
}