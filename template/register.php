<main>
	<?php
	if (isset($_POST['submit']) && is_array($errors)){?>
		<div>
			<?php
			foreach ($errors as $key => $err){
				echo "<p>- ".$err."</p>";
			}
			?>
		</div>
		<?php
	}
	?>
	<form method="post" action="#">
		<div class="form-group">
			<label for="login">Login:</label>
			<input type="text" name="Login" class="form-control" id="login" value="<?=$login?>">
		</div>
		<div class="form-group">
			<label for="password">Password:</label>
			<input type="password" name="Password" class="form-control" id="password" value="<?=$password?>">
		</div>
		<div class="form-group">
			<label for="password">Password again:</label>
			<input type="password" name="Passwordagain" class="form-control" id="password" value="<?=$passwordagain?>">
		</div>
		<div class="form-group">
			<label for="email">Email address:</label>
			<input type="email" name="Email" class="form-control" id="email" value="<?=$email?>">
		</div>
		<div class="form-group">
			<input type="submit" name="submit" class="btn btn-default" value="Register">
		</div>
	</form>
</main>
