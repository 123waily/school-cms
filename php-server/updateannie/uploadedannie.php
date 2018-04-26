<?php // 2015/06/28
// Uploading files http://www.w3schools.com/php/php_file_upload.asp
require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Announcement Uploaded"]);?>
<?php session_start(); ?>

		<?php
			$target_dir = __DIR__ . "/../download/annie/";
			print("The file submitted was named " . $_FILES["fileToUpload"]["name"] . ".");
			print("<br/>");
			$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
			$uploadOk = 1;
			$uploadedfiletype = pathinfo($target_file,PATHINFO_EXTENSION);
			print("File type is ". $uploadedfiletype . ".");
			print("<br/>");
			
			//Target of uploaded file(annie.pdf)
			
			$finaltarget = $target_dir . "annie.pdf";
			
			/*
			// Check if image file is a actual image or fake image			
			if(isset($_POST["submit"])) {
				$check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
				if($check !== false) {
					echo "File is an image - " . $check["mime"] . ".";
					$uploadOk = 1;
				} else {
					echo "File is not an image.";
					$uploadOk = 0;
				}
			}
			print("<br/>")
			// Check if file already exists
			if (file_exists($target_file)) {
				echo "Sorry, file already exists.";
				$uploadOk = 0;
			}
			// Check file size

			if ($_FILES["fileToUpload"]["size"] > 500000) {
				echo "Sorry, your file is too large.";
				$uploadOk = 0;
			}
			*/
			// Allow certain file formats
			if($uploadedfiletype != "pdf")
			{
				echo "Sorry, only pdf files are accepted.";
				print("<br/>");
				$uploadOk = 0;
			}
			// Check if $uploadOk is set to 0 by an error
			if ($uploadOk == 0) {
				echo "Sorry, your file was not uploaded.";
			// if everything is ok, try to upload file
			}
			else
			{
				// Delete existing annie.pdf
				if (file_exists($target_dir . "annie.pdf"))
				{
					$myFile = $target_dir . "annie.pdf";
					unlink($myFile);
				}
			
				if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $finaltarget)) {
					echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
				}
				else
				{
					echo "Sorry, there was an error uploading your file.";
				}
			}
		?>
		<br/>
		<br/>
		<p>To view the announcement, click <a href="../download/annie/annie.pdf" target="_blank">here</a>.  (opens in new window)</p>
        <form action="../index.php">
			<button class="btn btn-default">Home</button>
		</form>

<?php render("footer"); ?>