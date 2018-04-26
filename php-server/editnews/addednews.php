<?php // 2015/06/25
	if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "News Added"]);?>

		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<?php
			// Print the information changed
			print("<p>");
			
			//print_r($_POST);
			//print("<br/>");
			
			// Read JSON file first, append results from the form to the file		
			$str = file_get_contents(__DIR__ . "/../download/json/news.json");
			//print("<br/>Existing Values: " . $str . "</br></br>");
			$jsoncontents = json_decode($str, true);
			
			// Number of news
			$jsoncontents["numnews"] = $jsoncontents["numnews"] + 1;
			$unixtime = time();
			
			// Newsindex is for use of arrays, so a subtraction of one is requried
			$newsindex = intval($jsoncontents["numnews"]);
			$newsindex = $newsindex - 1;
			//print($newsindex);
			
			$jsoncontents["n"][$newsindex]["time"] = $unixtime;
			$jsoncontents["n"][$newsindex]["title"] = $_POST["newstitle"];
			$jsoncontents["n"][$newsindex]["content"] = $_POST["newscontent"];
			

			// Print validation information
			print("\"" . $jsoncontents["n"][$newsindex]["title"] . "\" was submitted on " . date("D M j G:i:s T Y") . ".<br/>");
			
			// Adding one back to $newsindex reflects the actual number of news for printing
			$newsindex++;
			print("There are now " . $newsindex . " news items.");
			print("</p>");
			
			// Open and write post into news.json
			$fp = fopen(__DIR__ . "/../download/json/news.json", 'w');
			fwrite($fp, json_encode($jsoncontents));
			fclose($fp);
			
			$fp2 = fopen(__DIR__ . "/../download/md5/news.md5", 'w');
			$mdstring = md5(json_encode($jsoncontents));
			fwrite($fp2, $mdstring);
			fclose($fp2);
			
			// 2015/07/09 CURL REST API
			curl_init();
			
	function sendMessage(){
		$content = array(
			"en" => $_POST["newscontent"]
		);
		
		$headings = array(
			"en" => $_POST["newstitle"]
		);
		
		$fields = array(
			'app_id' => "708df132-1ca3-11e5-9ed6-ef6ba6b9864e",
			'included_segments' => array('All'),
			'contents' => $content,
			'headings' => $headings
		);
		
		$fields = json_encode($fields);
		print("\nJSON sent:\n");
		print($fields);
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
		curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Authorization: Basic NzA4ZGYxZTYtMWNhMy0xMWU1LTllZDctZjMyYTcxYjRkMjI5'));
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($ch, CURLOPT_HEADER, FALSE);
		curl_setopt($ch, CURLOPT_POST, TRUE);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

		$response = curl_exec($ch);
		curl_close($ch);
		
		return $response;
	}
	
	$response = sendMessage();
	$return["allresponses"] = $response;
	$return = json_encode( $return);
	
	print("\n\nJSON received:\n");
	print($return);
	print("\n")
			
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