<?php // 2015/07/05
if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "News Removed"]);?>

		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<?php
			
			// Pasted from http://stackoverflow.com/questions/4343596/parsing-json-file-with-php
			// Read JSON file first, append results from the form to the file		
			$str = file_get_contents(__DIR__ . "/../download/json/news.json");
			//print("<br/>Existing Values: " . $str . "<br/><br/>");
			$jsoncontents = json_decode($str, true);
			
			//$selectednews is for the array's use, therefore the index starts from 0
			$selectednews = intval($_POST["newstbr"]);
			$selectednews = $selectednews - 1;
			
			// http://stackoverflow.com/questions/5217721/how-to-remove-array-element-and-then-re-index-array
			// Remove item from array, put to new temp array, put back
			$temparray = array();
			unset($jsoncontents["n"][$selectednews]);
			$temparray = array_values($jsoncontents["n"]);
			$jsoncontents["n"] = $temparray;
			
			unset($temparray);
			
			// Subtract one from numnews
			$jsoncontents["numnews"] = $jsoncontents["numnews"]-1;
			print("There are now " . $jsoncontents["numnews"] . " news items.");
			
			// Open and write post into news.json
			$fp = fopen(__DIR__ . "/../download/json/news.json", 'w');
			fwrite($fp, json_encode($jsoncontents));
			fclose($fp);
			
			$fp2 = fopen(__DIR__ . "/../download/md5/news.md5", 'w');
			$mdstring = md5(json_encode($jsoncontents));
			fwrite($fp2, $mdstring);
			fclose($fp2);
			
		?>
		
		<?php
		// 2015/07/19 Generate HTML file for the client to download
		//Link to download file...
		$url = "http://semiahmoo.geogamez.com/download/html/mobilenews.php";

		//Code to get the file...
		$data = file_get_contents($url);

		//save as?
		//$filename = __DIR__ . "/../html/mobilenews.html";

		//save the file...
		$fh = fopen(__DIR__ . "/../download/html/mobilenews.html", 'w');
		fwrite($fh,$data);
		fclose($fh);

		//display link to the file you just saved...
		//echo "<a href='".$filename."'>Click Here</a> to download the file...";
		
		?>
		
		<br/>

        <form action="../index.php">
			<button class="btn btn-default">Home</button>
		</form>

<?php render("footer"); ?>