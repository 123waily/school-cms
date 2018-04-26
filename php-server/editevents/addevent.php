<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Adding Event"]);?>



        <p>Adding Event.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>
		
		<script>
			/*
				2015/06/29
				ADD EVENT
				SUBMIT EVENT
				
				// Pass POST of last page to SESSION
				$_SESSION['year'] = $_POST["year"];
				$_SESSION['month'] = $_POST["month"];
				$_SESSION['day'] = $_POST["day"];
				
				// Pass the number of blocks into $_SESSION
				$_SESSION['numofevents'] = $numofevents;
			*/
		</script>
		
		<?php
			// Read Events, get all existing events
			$str = file_get_contents(__DIR__ . "/../download/json/events.json");
			//print("Existing contents of events.json: " . $str . "</br></br>");
			$jsoncontents = json_decode($str, true);
			
			print("You are now adding an event for " . $_SESSION['year'] . "/" . $_SESSION['month'] . "/" . $_SESSION['day'] . ".");
			print("</br>");
			
		// Prints out current events:
		?>
				
		<br/>
		<p>List of Current Events:</p>
		<ol>
		<?php
			
			//Print events on the screen
			switch ($_SESSION['numofevents'])
			{
				case 0:
					break;
				case 1:
					print("<li>");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0]);
					print("</li>");
					break;
				case 2:
					print("<li>");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0]);
					print("</li><li>");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][1]);
					print("</li>");
					break;
				case 3:
					print("<li>");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0]);
					print("</li><li>");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][1]);
					print("</li><li>");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][2]);
					print("</li>");
					break;
			}
		?>
		</ol>
		
		<form action="addedevent.php" method="post" >
				<br/>
				<p>Enter New Event:</p>
				<!--<textarea name="newevent" cols="20" rows="4"></textarea>-->
				<input type="text" name="newevent">

				<br/>
				<br/>				
				<input type="submit" value="Submit" class="btn btn-default"/>
		</form>

<?php render("footer"); ?>