<?php require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Uploading Announcement"]);?>

        <p>You are now uploading today's announcement.  To view the existing announcement, click <a href="/public/annie/annie.pdf" target="_blank">here</a>.  (opens in new window)</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>
		<script>
			/*
				2015/06/28
				Uploading Files
			*/
		</script>
		
		<p>Upload today's announcement in a PDF file format.</p>
		<form action="uploadedannie.php" method="post" enctype="multipart/form-data">
			<input type="file" name="fileToUpload" id="fileToUpload" class="btn btn-info">
			<br/>
			<input type="submit" value="Upload PDF File" name="submit" class="btn btn-default">
		</form>

<?php render("footer"); ?>