<main>
	<div class="panel panel-default">
	<?php foreach ($displayAllNewsList as $number => $array){?>
	<form action="#" method="post">
	<div class="panel panel-default">
		<div class="panel-heading">
				<h4><?=$array['id_news']?> <a href="/news/<?=strtolower($array['news_type'])/$array['id_news']?>"><?=substr($array['Title'],0, 60).'...'?></a>
				<span class="shortinfo">
				<a href="/admin/news/edit/<?=$array['id_news']?>" name="edit"><span class="glyphicon glyphicon-pencil"> Edit | </span></a>
				<a href="/admin/news/edit/<?=$array['id_news']?>" name="delete"><span class="glyphicon glyphicon-trash"> Delete </span></a></span></h4>
		</div>
	</div>
	</form>
			<?php } ?>
	<form action="/admin/news/add" method="post">
	<div class="panel panel-default">
			<button type="submit" class="btn btn-primary btn-block" name="add"><span class="glyphicon glyphicon-plus-sign"></span> Add article</button>
	</div>
	</form>

		<div class="center">
			<?php foreach ($paginator as $number => $value){?>
			<a href="<?="/admin/news/page/".$value?>"><?=$value?></a>
			<?php } ?>
		</div>
	</div>
</main>