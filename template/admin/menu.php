<header>
	<div class="container-fluid" style="background-color:#FFFFFF; color:#ffffff; height:200px; background-image: url(<?php ROOT?>/style/images/header_background.jpg); background-size: cover;">
		<h1><span class="color">by</span><span class="color_2">product.by</span></h1>
	</div>
	<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
		<ul class="nav navbar-nav">
			<li class="active"><a href="/">Main</a></li>
			<li><a href="/admin/news">News</a></li>
			<li><a href="#">Manufacturers</a></li>
			<li><a href="#">Category</a></li>
			<li><a href="/admin/users">Users</a></li>
		</ul>
		<form class="navbar-form navbar-left" role="search">
			<div class="form-group">
			<input type="text" class="form-control" placeholder="Search">
			</div>
			<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
		</form>
		<ul class="nav navbar-nav navbar-right" style="margin-right: 10px">
			<li><a href="#"><span class="glyphicon glyphicon-ok-sign"></span> <?= "HELLO, " . strtoupper($_SESSION['logged_user']['Login']);?></a></li>
			<li><a href="/admin/"><span class="glyphicon glyphicon-user"></span> Admin panel</a></li>
			<li><a href="/user/logout/"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
		</ul>
	</nav>
</header>	