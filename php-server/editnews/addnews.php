<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Adding News"]);?>

        <p>Adding News.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>
		
		<script>
			/*
				2015/06/25
				Have a JSON file determining the number of news recorded
				
				newsrecorded = 1
				
				Create new JSON file
				
				$fp = fopen("c" . $num . ".json", 'w');
				
				-==========================================================
				blocks
				<textarea name="newstitle" cols="20" rows="1"></textarea>
			<textarea name="newscontent" cols="20" rows="4"></textarea>
			*/
		</script>
				
		<form action="addednews.php" method="post" >
				<p>Enter title for news</p>
				<input type="text" name="newstitle">
				
				<br/>
				<br/>
				
				<p>Enter news</p>
				<input type="text" name="newscontent">

				<br/>
				<br/>
				
				<p>The time of submission will show up in the client app.</p>
				
				<input type="submit" value="Submit" class="btn btn-default"/>
		</form>

<?php render("footer"); ?>