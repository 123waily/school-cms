<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Removing News"]);?>



        <p>Removing News.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>

		<?php
			/*
				2015/07/05
				REMOVE NEWS
				
			*/
			
			// Read news, get all existing news
			$str = file_get_contents(__DIR__ . "/../download/json/news.json");
			print("Existing contents of news.json: " . $str . "<br/><br/>");
			$jsoncontents = json_decode($str, true);
			
			$numofnews = intval($jsoncontents["numnews"]);
			
			print("Choose the news you would like to remove.");
			print("<br/>");
		?>
		
		<form action="removednews.php" method="post" >
		<?php
			// Print all events
			
			for ($i = 1; $i <= $numofnews; $i++)
			{
				print("<input type=\"radio\" name=\"newstbr\" value = \"" . $i . "\"/> ");
				print($i . ": ");
				print($jsoncontents["n"][$i-1]["title"]);
				print("<br/>");
			}
			
		?>
				<br/>				
				<input type="submit" value="Submit" class="btn btn-default"/>
		</form>

<?php render("footer"); ?>