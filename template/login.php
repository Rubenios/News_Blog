<main>
	<?php
	if (isset($_POST['submit']) && is_array($errors)){?>
		<div class="errors">
			<?php
			foreach ($errors as $key => $err){
				echo "<p>- ".$err."</p>";
			} ?>
		</div>
		<?php } ?>
	<form method="post" action="#">
		<div class="form-group">
			<label for="login">Login:</label>
			<input type="text" class="form-control" name="Login" value="<?=@$_POST['Login']?>">
		</div>
		<div class="form-group">
			<label for="password">Password:</label>
			<input type="password" class="form-control" name="Password" value="<?=@$_POST['Password']?>">
		</div>
		<div class="form-group">
			<input type="submit" class="btn btn-default" name="submit">
		</div>
	</form>
</main>