<?php
require_once ROOT."/components/menu.php";
$list = Menu::getListMenu();
$category = Menu::getCategoryMenu();
?>
<body>
<header>
	<div class="container-fluid" style="background-color:#FFFFFF; color:#ffffff; height:200px; background-image: url(<?php ROOT?>/style/images/header_background.jpg); background-size: cover;">
	<h1><span class="color">by</span><span class="color_2">product.by</span></h1>
	</div> 
	<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
		<ul class="nav navbar-nav">
			<li class="active"><a href="/">Main</a></li>
			<?php
			foreach($list as $key => $value){
			?>
			<li><a href="/news/<?=strtolower($value['news_type'])?>"><?=$value['news_type']?></a></li>
			<?php }?>
			<li class="dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">Category<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<?php
					foreach($category as $key => $value){
					?>
					<li class="dropdown-submenu"><a class="test" tabindex="-1" href="#"><?=$value['category']?><span class="caret"></span></a>
						<ul class="dropdown-menu">
						<li><a tabindex="-1" href="/news/">News</a></li>
						<li><a tabindex="-1" href="/news/">Reviews</a></li>
						<li><a tabindex="-1" href="#">Manufacturers</a></li>
						</ul>
					</li>
					<?php } ?>
				</ul>
			</li>
		</ul>
		<form class="navbar-form navbar-left" action="/search" method="POST">
			<div class="form-group">
				<input type="search" name="query" class="form-control" value="<?=@$_POST['query'] ?>" placeholder="Search">
			</div>
			<button type="submit" class="btn btn-default" name="searchQuery"><span class="glyphicon glyphicon-search"></span></button>
		</form>
		<?php
		if(isset($_SESSION['logged_user']) && $_SESSION['logged_user']['id_privilege']=='1') {?>
				<ul class="nav navbar-nav navbar-right" style="margin-right: 10px">
				<li><a href="#"><span class="glyphicon glyphicon-ok-sign"></span> <?= "HELLO, " . strtoupper($_SESSION['logged_user']['Login']);?></a></li>
				<li><a href="/admin/"><span class="glyphicon glyphicon-user"></span> Admin panel</a></li>
				<li><a href="/user/logout/"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
			</ul>
			<?php
		}elseif(isset($_SESSION['logged_user']) && $_SESSION['logged_user']['id_privilege']=='2'){
		?>
			<ul class="nav navbar-nav navbar-right" style="margin-right: 10px">
				<li><a href="#"><span class="glyphicon glyphicon-ok-sign"></span> <?= "HELLO, " . strtoupper($_SESSION['logged_user']['Login']);?></a></li>
				<li><a href="#"><span class="glyphicon glyphicon-user"></span> Personal cab</a></li>
				<li><a href="/user/logout/"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
			</ul>
		<?php }else{?>
			<ul class="nav navbar-nav navbar-right" style="margin-right: 10px">
				<li><a href="/user/register/"><span class="glyphicon glyphicon-user"></span> Register</a></li>
				<li><a href="/user/login/"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
			</ul>
		<?php }?>
	</nav>
</header>	