<main>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3><?= $newsItem['Title']?></h3></div>
		<div class="panel-body">
			<p><?=$newsItem['News'] ?></p>
			<span class="shortinfo">Date: <?=$newsItem['Newsdate']?> Author: <?=$newsItem['Login']?></span>
		</div>
	</div>
	<?php
	if ($errors){?>
		<div>
			<?php
			foreach ($errors as $key => $err){
				echo "<p> ".$err."</p>";
			}?>
		</div>
	<?php }?>
	<div class="form-group">
		<p><h3 class="center">
			<?php
			if(empty($postList)) {
				echo "No comments";
			}else{
				echo "Comments";
			}?></h3></p>
	</div>

	<?php foreach ($postList as $key => $post){?>
	<div class="panel panel-default">
		<div class="panel-heading"><h4>User <span class="user"><?=$post['Login']?>
		</span> has left his comment on date <span class="user"><?=$post['Date']?></span></h4></div>
		<div class="panel-body">
			<p><strong><?=$post['Post']?></strong></p>
		</div>
	</div>
	<?php }?>

	<div class="form-group">
		<?php if(isset($_SESSION['logged_user'])){?>
		<div class="center"><h3><?=$_SESSION['logged_user']['Login']?>, add your comment:</h3></div>
		<form action="/news/<?=strtolower($newsItem['news_type']."/".$newsItem['id_news'])?>#post" method="POST">
				<textarea name="Post" class="form-control" rows="5"></textarea><br />
				<button type="submit" name="sendPost" class="btn btn-primary btn-block">Add comment</button>
		</form>
	<?php } else { ?>
		<h4 class="center">Please <a href="/user/login">login</a> to leave your comment</h4>
		<?php } ?>
	</div>
</main>