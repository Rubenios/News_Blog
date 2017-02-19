<main>
	<?php foreach ($displayAllNewsList as $number => $array){?>
    <div class="panel panel-default">
        <div class="panel-heading">
        <h3><a href="/news/<?=strtolower($array['news_type'])."/".$array['id_news']?>"><?= $array['Title'] ?></a></h3></div>
        <div class="panel-body">
            <p><img class="image" src="../style/images/<?=$array['image_path']?>" alt="" height="250"/>
                <?=substr($array['News'],0,1000).'...' ?></p>
            <a href="/news/<?=strtolower($array['news_type'])."/".$array['id_news']?>">Read more</a>
            <span class="shortinfo">Date: <?=$array['Newsdate'] ?> Author: <?=$array['Login']?></span>
        </div>
    </div>
    <?php } ?>
    <div class="center">
        <?php foreach ($paginator as $number => $value){
            if ($value == $pageNumber){?>
                 <span><?=$value?></span>
            <?php }else{?>
                <a href="<?="/news/".$value?>"><?=$value?></a>
            <?php } ?>
        <?php } ?>
    </div>
</main>