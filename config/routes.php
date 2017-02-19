<?php
    return array(
        'admin/news/([a-z]+)/([0-9]+)' => 'admin/news/$1/$2',
        'admin/news/([a-z])' => 'admin/news/$1',
        'admin/news' => 'admin/news/page',

        'admin/users' => 'admin/users',
        'admin' => 'admin/index',
        'search' => 'search/index',

        'news/([a-z]+)/([0-9]+)' => 'news/view/$1/$2',
        'news/([a-z]+)' => 'news/view/$1',
        'news/([0-9]+)' => 'news/start/$1',
        'news' => 'news/view',

        'user/register' => 'user/register',
        'user/login' => 'user/login',
        'user/logout' => 'user/logout',

        '(.+)' => 'news/start',
        '' => 'news/start'
    );