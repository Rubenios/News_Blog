<main>
	<div class="panel panel-default">
		<button type="#" class="btn btn-primary btn-block"><span class="glyphicon glyphicon-list-alt"></span> User statistics </button>
		<div class="panel-heading">
			<table class="table">
				<tr><td>ID</td><td>Status</td><td>Login</td><td>Email</td></tr>
				<?php foreach($listUsers as $key => $value) {?>
				<tr>
					<td><?=$value['id_user']?></td>
					<td><?=$value['id_privilege']?></td>
					<td><?=$value['Login']?></td>
					<td><?=$value['Email']?></td>
				</tr>
				<?php }?>
			</table>
		</div>
	</div>
</main>