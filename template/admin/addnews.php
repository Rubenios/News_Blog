<main>
	<div class="panel panel-default">
		<?php
		if (isset($_POST['add']) && is_array($result)) {?>
			<div>
				<?php
				foreach ($result as $key => $err){
					echo "<p>$err</p>";
				}?>
			</div>
			<?php}?>
		<div class="panel-heading"><h3>News editor</h3></div>
		<div class="panel-body">
			<form enctype="multipart/form-data" method="post" action="#">
				<div class="form-group">
					<label for="title">News title:</label>
					<input type="text" class="form-control" id="title" value="<?php $_POST['Title']?>">

					<label for="body">News body:</label>
					<p><textarea id="editor1" name="editor1"><?php $_POST['News']?></textarea>
					<script type="text/javascript"> CKEDITOR.replace( 'editor1' ); </script></p>

					<label for="title">Upload/edit image for preview:</label>
					<input type="hidden" name="MAX_FILE_SIZE" value="3000">
					<p><input type="file" name="image"></p>

					<table class="table">
					<tr><td>
					<label for="selectname">Select news type:</label>
						<p><select name="type">
						<!-- !!!!!!!!!!!!!!!!!!!!!!Path: /models/admin.php!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
						<?php
						foreach ($result as $key => $value){?>
						<option value="<?=$value['id_newstype']?>"><?=$value['news_type']?></option>
						<?php } ?>
						</select></p>
					</td>
					<td>
			 			<label for="category">Select news category:</label>
						<p><select name="category">
						<?php
						foreach ($categoryList as $key => $value){?>
						<option value="<?=$value['id_category']?>"><?=$value['category']?></option>
						<?php } ?>
						</select></p>
					</td>
					<td>
						<label for="user">Select news author:</label>
						<p><select name="user">
						<?php
						foreach ($listUsers as $key => $value){?>
						<option value="<?=$value['id_user']?>"><?=$value['Login']?></option>
						<?php } ?>
						</select></p>
					</td></tr>
					</table>
					<button type="submit" name="add" class="btn btn-primary btn-block">
					<span class="glyphicon glyphicon-plus-sign"></span>Add article</button>
				</div>
			</form>
		</div>
	</div>
</main>