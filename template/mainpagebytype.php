<main>
	<?php foreach ($newsListByType as $number => $array){?>
    <div class="panel panel-default">
        <div class="panel-heading">
        <h3><a href="/news/<?=strtolower($array['news_type'])."/".$array['id_news']?>"><?= $array['title'] ?></a></h3></div>
        <div class="panel-body">
            <p><img class="image" src="../style/images/<?=$array['image_path']?>" alt="" height="250"/>
                <?=substr($array['news'],0,1000).'...' ?></p>
            <a href="/news/<?=strtolower($array['news_type'])."/".$array['id_news']?>">Read more</a>
            <span class="shortinfo">Date: <?=$array['newsdate'] ?> Author: <?=$array['login']?></span>
        </div>
    </div>
    <?php } ?>
    <div class="center">
        <?php foreach ($paginator as $number => $value){?>
                <a href="<?="/news/".$value?>"><?=$value?></a>
            <?php } ?>
    </div>
</main>