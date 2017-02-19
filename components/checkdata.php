<?php

class checkdata{
    public static function getSafety($news){
        $content = htmlspecialchars(addslashes(strip_tags($news)));
        return $content;
    }
}