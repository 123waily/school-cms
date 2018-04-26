<?php // 2015/06/21
if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Block Changes Applied"]);?>


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
			$str = file_get_contents(__DIR__ . "/../download/json/blocks.json");
			//print("<br/>Existing Values: " . $str . "</br></br>");
			$jsoncontents = json_decode($str, true);
			
			// Put d20150625 into a variable called dstring
			$dstring = "d" . $subyear . $submonth . $subday;
			
			// Set the block.date into the new block order specified by Mahli.
			$jsoncontents["d"][$subyear][$submonth][$subday] = $_POST["newblockorder"];
			
			// If the value is noschool then unset it, making the table value dissappear.
			if ($jsoncontents["d"][$subyear][$submonth][$subday] == "noschool")
			{
				unset($jsoncontents["d"][$subyear][$submonth][$subday]);
				print("There will be no school on this day.");
			}
			else
			{
				// Else then display the changed block order.
				print("Block order for that date is now " . $jsoncontents["d"][$subyear][$submonth][$subday] . ".");
			}
			print("</p>");
			
			// Open and write post into blocks.json
			$fp = fopen(__DIR__ . "/../download/json/blocks.json", 'w');
			fwrite($fp, json_encode($jsoncontents));
			fclose($fp);
			
			$fp2 = fopen(__DIR__ . "/../download/md5/blocks.md5", 'w');
			$mdstring = md5(json_encode($jsoncontents));
			fwrite($fp2, $mdstring);
			fclose($fp2);
			
			unset($subyear);
			unset($submonth);
			unset($subday);
			unset($_SESSION['year']);
			unset($_SESSION['month']);
			unset($_SESSION['day']);
		?>
        <form action="../index.php">
			<button class="btn btn-default">Home</button>
		</form>

<?php render("footer"); ?>