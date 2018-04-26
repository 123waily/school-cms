<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Editing Block Order"]);?>

        <p>You are now submitting the new block order.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>
		
		<script>
			/*
				2015/06/21
				Have a JSON file determining the number of news recorded
				
				newsrecorded = 1
				
				Create new JSON file
				
				$fp = fopen("c" . $num . ".json", 'w');
				
				-==========================================================
				blocks
				
			*/
		</script>
		<?php
			// Read blocks, get the existing block order
			$str = file_get_contents(__DIR__ . "/../download/json/blocks.json");
			//print("Existing contents of blocks.json: " . $str . "</br></br>");
			$jsoncontents = json_decode($str, true);
			
			$currentblock = "ns";
			
			function printnoschool()
			{
				print("Current block order for " . $_POST["year"] . "/" . $_POST["month"] . "/" . $_POST["day"] . " is either set to No School or has not been set." );
			}
			
			// Print current block order only if index exists in blocks.json
			// Check for the year in the d function
			if (array_key_exists($_POST["year"], $jsoncontents["d"]))
			{
				// Check for the existence of month
				if (array_key_exists($_POST["month"], $jsoncontents["d"][$_POST["year"]]))
				{
					// Check day
					if (array_key_exists($_POST["day"], $jsoncontents["d"][$_POST["year"]][$_POST["month"]]))
					{
						// A block order exists in the date index.
						print("Current block order for " . $_POST["year"] . "/" . $_POST["month"] . "/" . $_POST["day"] . " is <b>" . $jsoncontents["d"][$_POST["year"]][$_POST["month"]][$_POST["day"]] . "</b>.");
						$currentblock = $jsoncontents["d"][$_POST["year"]][$_POST["month"]][$_POST["day"]];
					}
					else
					{
						printnoschool();
					}
				}
				else
				{
					printnoschool();
				}
			}
			else
			{
				printnoschool();
			}
			
			// Pass POST of last page to SESSION
			$_SESSION['year'] = $_POST["year"];
			$_SESSION['month'] = $_POST["month"];
			$_SESSION['day'] = $_POST["day"];
		?>
				
		<form action="submittedblocks.php" method="post" >
		
			<p>Select the new block order for that date:</p>
				<input type="radio" name="newblockorder" value = "d1" <?php if ($currentblock == "d1"){ echo "checked";}?>/>
				blocks.d1 = { 2, 3, 5, "l", 6, 8}
				<br/>
				<input type="radio" name="newblockorder" value = "d2" <?php if ($currentblock == "d2"){ echo "checked";}?>/>
				blocks.d2 = { 4, 5, 7, "l", 8, 1}
				<br/>
				<input type="radio" name="newblockorder" value = "d3" <?php if ($currentblock == "d3"){ echo "checked";}?>/>
				blocks.d3 = { 6, 7, 2, "l", 1, 3}
				<br/>
				<input type="radio" name="newblockorder" value = "d4" <?php if ($currentblock == "d4"){ echo "checked";}?>/>
				blocks.d4 = { 8, 2, 4, "l", 3, 5}
				<br/>
				<input type="radio" name="newblockorder" value = "f1" <?php if ($currentblock == "f1"){ echo "checked";}?>/>
				blocks.f1 = { 1, 4, "l", 6, 7}
				<br/>
				<input type="radio" name="newblockorder" value = "f2" <?php if ($currentblock == "f2"){ echo "checked";}?>/>
				blocks.f2 = { 4, 6, "l", 7, 1}
				<br/>
				<input type="radio" name="newblockorder" value = "f3" <?php if ($currentblock == "f3"){ echo "checked";}?>/>
				blocks.f3 = { 6, 7, "l", 1, 4}
				<br/>
				<input type="radio" name="newblockorder" value = "f4" <?php if ($currentblock == "f4"){ echo "checked";}?>/>
				blocks.f4 = { 7, 1, "l", 4, 6}
				<br/>
				<input type="radio" name="newblockorder" value = "p1" <?php if ($currentblock == "p1"){ echo "checked";}?>/>
				blocks.p1 = { 2, 3, 5, "l", 6}
				<br/>
				<input type="radio" name="newblockorder" value = "p2" <?php if ($currentblock == "p2"){ echo "checked";}?>/>
				blocks.p2 = { 4, 5, 7, "l", 8}
				<br/>
				<input type="radio" name="newblockorder" value = "p3" <?php if ($currentblock == "p3"){ echo "checked";}?>/>
				blocks.p3 = { 6, 7, 2, "l", 1}
				<br/>
				<input type="radio" name="newblockorder" value = "p4" <?php if ($currentblock == "p4"){ echo "checked";}?>/>
				blocks.p4 = { 8, 2, 4, "l", 3}
				<br/>
				<input type="radio" name="newblockorder" value = "e1" <?php if ($currentblock == "e1"){ echo "checked";}?>/>
				blocks.e1 = { 1, 2, "l", 3, 4}
				<br/>
				<input type="radio" name="newblockorder" value = "e2" <?php if ($currentblock == "e2"){ echo "checked";}?>/>
				blocks.e2 = { 5, 6, "l", 7, 8}
				<br/>
				<input type="radio" name="newblockorder" value = "noschool" <?php if ($currentblock == "ns"){ echo "checked";}?>/>
				No school
				<br/>

				<input type="submit" value="Submit" class="btn btn-default"/>
		</form>

<?php render("footer"); ?>