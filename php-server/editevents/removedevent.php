<?php // 2015/06/25
if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Event Removed"]);?>


		<?php
			$subyear = $_SESSION['year'];
			$submonth = $_SESSION['month'];
			$subday = $_SESSION['day'];
			
			// Print the information changed
			print("<p>");
			print($subyear . "/" . $submonth . "/" . $subday . " has been modified.");
			print("<br/>");
			
			// Pasted from http://stackoverflow.com/questions/4343596/parsing-json-file-with-php
			// Read JSON file first, append results from the form to the file		
			$str = file_get_contents(__DIR__ . "/../download/json/events.json");
			//print("<br/>Existing Values: " . $str . "<br/><br/>");
			$jsoncontents = json_decode($str, true);
			//
			
			$selectedevent = intval($_POST["eventtbr"]);
			$temparray = array();
			// If first event is selected
			if ($selectedevent == 0)
			{
				// Unset event index
				unset($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0]);
				// reindex array
				$temparray = array_values($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]]);
				
				// Move reindexed array back to original events array
				$jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]] = $temparray ;
				
				$_SESSION['numofevents'] = $_SESSION['numofevents'] - 1;
			}
			// If second event is selected
			if ($selectedevent == 1)
			{
				unset($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][1]);
				// reindex array
				$temparray = array_values($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]]);
				
				// Move reindexed array back to original events array
				$jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]] = $temparray ;
				
				$_SESSION['numofevents'] = $_SESSION['numofevents'] - 1;
			}
			// If third event is selected
			if ($selectedevent == 2)
			{
				unset($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][2]);
				// reindex array
				$temparray = array_values($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]]);
				
				// Move reindexed array back to original events array
				$jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]] = $temparray ;
				
				$_SESSION['numofevents'] = $_SESSION['numofevents'] - 1;
			}
			
			// If day array contains no events, delete day array latogether
			$currenteventsnum = count($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]]);
			
			if ($currenteventsnum == 0)
			{
				//delete first event, unset the entire day table
				unset($jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]]);
			}
			
			print("There are now " . $_SESSION['numofevents'] . " events for this day.");
			
			// Open and write post into events.json
			$fp = fopen(__DIR__ . "/../download/json/events.json", 'w');
			fwrite($fp, json_encode($jsoncontents));
			fclose($fp);
			
			$fp2 = fopen(__DIR__ . "/../download/md5/events.md5", 'w');
			$mdstring = md5(json_encode($jsoncontents));
			fwrite($fp2, $mdstring);
			fclose($fp2);
			
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
			
			unset($subyear);
			unset($submonth);
			unset($subday);
			unset($_SESSION['year']);
			unset($_SESSION['month']);
			unset($_SESSION['day']);
			unset($_SESSION['numofevents']);
		?>
		</ol>
        <form action="../index.php">
			<button class="btn btn-default">Home</button>
		</form>

<?php render("footer"); ?>