			<div class="footer">
			&copy; <span class="color">by</span><span class="color_2">product.by</span>
			</div>		
		<script>
			$(document).ready(function(){
			  $('.dropdown-submenu a.test').on("click", function(e){
				$(this).next('ul').toggle();
				e.stopPropagation();
				e.preventDefault();
			  });
			});
		</script>	
	</body>
</html>