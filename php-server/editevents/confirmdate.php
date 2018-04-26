<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Editing Events"]);?>



        <p>Confirm the date.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>
		
		<script>
			/*
				2015/06/29
			*/
		</script>
		<?php
			// Read Events, get all events
			$str = file_get_contents(__DIR__ . "/../download/json/events.json");
			//print("Existing contents of events.json: " . $str . "</br></br>");
			$jsoncontents = json_decode($str, true);
			
			$numofevents = 0;
			
			// print date out
			print($_POST["year"] . "/" . $_POST["month"] . "/" . $_POST["day"] . " ");
			
			// Adapted from submitblocks.php
			// Function that prints "no events"
			function printnoevents()
			{
				print("has no events.  You can add three more events." );
			}
			
			// Adapted from submitblocks.php, checks for the existence of certain keys.
			if (array_key_exists($_POST["year"], $jsoncontents["d"]))
			{
				// Check for the existence of month
				if (array_key_exists($_POST["month"], $jsoncontents["d"][$_POST["year"]]))
				{
					// Check day
					if (array_key_exists($_POST["day"], $jsoncontents["d"][$_POST["year"]][$_POST["month"]]))
					{
						// Day index exists
						// Check if first event exists
						$result = count($jsoncontents["d"][$_POST["year"]][$_POST["month"]][$_POST["day"]]);
						if ($result == 1)
						{
							print("contains one event.  You can add two more events.");
							$numofevents = 1;
						}
						elseif ($result == 2)
						{
							print("contains two events.  You can add one more event.");
							$numofevents = 2;
						}
						elseif ($result == 3)
						{
							print("contains three events.  <b>You cannot add any more events.</b>");
							$numofevents = 3;
						}
						else
						{
							// First event does not exist
							printnoevents();
						}
					}
					else
					{
						// Day index does not exist
						printnoevents();
					}
				}
				else
				{
					// month index does not exist
					printnoevents();
				}
			}
			else
			{
				// year index does not exists
				printnoevents();
			}
			
			// Pass POST of last page to SESSION
			$_SESSION['year'] = $_POST["year"];
			$_SESSION['month'] = $_POST["month"];
			$_SESSION['day'] = $_POST["day"];
			
			// Pass the number of blocks into $_SESSION
			$_SESSION['numofevents'] = $numofevents;
		
		// Prints out current events:
		?>
		
		<br/>
		
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
		
		<br/>
		<script>
			// <form action=<?php if ($_SESSION['numofevents'] == 3) { echo "../index.php";} else {echo "submitevent.php";} ?>>
		</script>
		<!-- If number of events is 3 then make add button inactive -->
		<form action=<?php if ($_SESSION['numofevents'] == 3) { echo "#";} else {echo "addevent.php";} ?>>
			<button class="btn btn-default <?php if ($_SESSION['numofevents'] == 3) {echo "disabled";} ?>">Add Event</button>
		</form>
		<!-- If number of events is 0 then make remove button inactive -->
		<form action=<?php if ($_SESSION['numofevents'] == 0) { echo "#";} else {echo "removeevent.php";} ?>>
			<button class="btn btn-default <?php if ($_SESSION['numofevents'] == 0) {echo "disabled";} ?>">Remove Event</button>
		</form>
		

<?php render("footer"); ?>