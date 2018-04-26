
<?php require(__DIR__ . "/../includes/helpers.php") ?>

<?php render("header", ["title" => "Home"]);?>
		<script>
			/*
				2015/06/21
				Have a JSON file determining the number of news recorded
				
				newsrecorded = 1
				
				Create new JSON file
				
				$fp = fopen("c" . $num . ".json", 'w');
				
				-==========================================================
				blocks
				
			*/
		/*
		
		<form action="editblocks/submitdate.php">
			<button class="btn btn-default">Edit Blocks</button>
		</form>
		
		<form action="editevents/editevents.php">
			<button class="btn btn-default">Edit Events</button>
		</form>
		
		<form action="addnews/addnews.php">
			<button class="btn btn-default">Add News</button>
		</form>
		
		<form action="updateannie/uploadannie.php">
			<button class="btn btn-default">Update Announcement</button>
		</form>
		*/
		// Adapted from http://www.w3schools.com/bootstrap/bootstrap_navbar.asp
		</script>
		
		<?php
			//Set default timezone to Vancouver
			
			date_default_timezone_set('America/Vancouver');
		?>
		
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
			  <ul class="nav navbar-nav">
				<li><a href="editblocks/submitdate.php">Edit Blocks</a></li>
				<li><a href="editevents/submitdate.php">Edit Events</a></li>
				<li><a href="editnews/aodnews.php">Edit News</a></li>
				<li><a href="updateannie/uploadannie.php">Update Announcements</a></li>
			  </ul>
		  </div>
		</nav>
	
<?php render("footer"); ?>