<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Removing Event"]);?>



        <p>Adding Event.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>

		<?php
			/*
				2015/06/29
				REMOVE EVENT
				List of sessions:
				
				// Pass POST of last page to SESSION
				$_SESSION['year'] = $_POST["year"];
				$_SESSION['month'] = $_POST["month"];
				$_SESSION['day'] = $_POST["day"];
				
				// Pass the number of blocks into $_SESSION
				$_SESSION['numofevents'] = $numofevents;
			*/
			
			// Read Events, get all existing events
			$str = file_get_contents(__DIR__ . "/../download/json/events.json");
			//print("Existing contents of events.json: " . $str . "<br/><br/>");
			$jsoncontents = json_decode($str, true);
			
			print("Choose the events you would like to remove for " . $_SESSION['year'] . "/" . $_SESSION['month'] . "/" . $_SESSION['day'] . ".");
			print("<br/>");
		?>
		
		<form action="removedevent.php" method="post" >
		<?php
			// Print previous event for information
			print("Select the event: <br/>");
			switch ($_SESSION['numofevents'])
			{
				case 0:
					print("none");
					break;
				case 1:
					//<input type="radio" name="eventtbr" value = 0/>
					print("<input type=\"radio\" name=\"eventtbr\" value = \"0\"/ checked> ");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0]);
					print("<br/>");
					break;
				case 2:
					//<input type="radio" name="eventtbr" value = 1/>
					print("<input type=\"radio\" name=\"eventtbr\" value = \"0\" checked/> ");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0]);
					print("<br/>");
					print("<input type=\"radio\" name=\"eventtbr\" value = \"1\"/> ");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][1]);
					print("<br/>");
					break;
				case 3:
					//<input type="radio" name="eventtbr" value = 2/>
					print("<input type=\"radio\" name=\"eventtbr\" value = \"0\" checked/> ");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0]);
					print("<br/>");
					print("<input type=\"radio\" name=\"eventtbr\" value = \"1\"/> ");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][1]);
					print("<br/>");
					print("<input type=\"radio\" name=\"eventtbr\" value = \"2\"/> ");
					print($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][2]);
					print("<br/>");
					break;
			}
			
		?>
				<br/>				
				<input type="submit" value="Submit" class="btn btn-default"/>
		</form>

<?php render("footer"); ?>