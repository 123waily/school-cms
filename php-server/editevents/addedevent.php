<?php // 2015/06/25
if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Event Added"]);?>


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
			
			switch ($_SESSION['numofevents'])
			{
				case 0:
					$jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][0] = $_POST["newevent"];
					break;
				case 1:
					$jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][1] = $_POST["newevent"];
					break;
				case 2:
					$jsoncontents["d"][$_SESSION["year"]][$_SESSION["month"]][$_SESSION["day"]][2] = $_POST["newevent"];
					break;
			}
			$_SESSION['numofevents'] = $_SESSION['numofevents'] + 1;
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