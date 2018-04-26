<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Editing News"]);?>

<?php  ?>

        <p>Add or delete news.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>
		
		<script>
			/*
				2015/07/05
				Add page to delete or add events
			*/
		</script>
		<?php
			// Read news, get all news
			$str = file_get_contents(__DIR__ . "/../download/json/news.json");
			//print("Existing contents of news.json: " . $str . "</br></br>");
			$jsoncontents = json_decode($str, true);
			
			$numofnews = intval($jsoncontents["numnews"]);
		?>
		
		
		
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Event ID</th>
					<th scope="col">Title</th>
					<th scope="col">Contents</th>
					<th scope="col">Time</th>
				</tr>
				
				<tbody>
						
		<?php
			for ($i = 1; $i <= $numofnews; $i++)
			{
					print("<tr>");
						print("<th>" . $i . "</th>");
						print("<th>" . $jsoncontents["n"][$i-1]["title"] . "</th>");
						print("<th>" . $jsoncontents["n"][$i-1]["content"] . "</th>");
						print("<th>" . date ('r', $jsoncontents["n"][$i-1]["time"]) . "</th>");
					print("<tr>");
			}
		?>
				
				</tbody>
			</thead>
		</table>
				
		<br/>
		<script>
			// <form action=<?php if ($_SESSION['numofevents'] == 3) { echo "../index.php";} else {echo "submitevent.php";} ?>>
		</script>
		<!-- Events can be added no matter what -->
		<form action="addnews.php">
			<button class="btn btn-default">Add News</button>
		</form>
		<!-- If number of news is 0 then make remove button inactive -->
		<form action=<?php if ($numofnews == 0) { echo "#";} else {echo "removenews.php";} ?>>
			<button class="btn btn-default <?php if ($numofnews == 0) {echo "disabled";} ?>">Remove News</button>
		</form>
		

<?php render("footer"); ?>