<!DOCTYPE html><head>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
<meta name="viewport" content="width=device-width" />
<meta charset="UTF-8">
<style>
p{
	font-family: sans-serif;
}
</style>
<title>News</title>
</head><body><?php
			/*
				2015/07/18
				HTML News page to be displayed in the app
			*/
			
			// Read news, get all news
			$str = file_get_contents(__DIR__ . "/../json/news.json");
			//print("Existing contents of news.json: " . $str . "</br></br>");
			$jsoncontents = json_decode($str, true);
			
			$numofnews = intval($jsoncontents["numnews"]);
		?><?php
			for ($i = $numofnews; $i >= 1; $i = $i - 1)
			{
				$unixtime = $jsoncontents["n"][$i-1]["time"];
				print("<p>");
				print( date('Y', $unixtime) . "/" . date('m', $unixtime) . "/" . date('d', $unixtime) . " ");
				print( date('H', $unixtime) . ":" . date('i', $unixtime) . ":" . date('s', $unixtime));
				print("<br/>");
				print("<b>" . $jsoncontents["n"][$i-1]["title"] . "</b>");
				print("<br/>");
				print($jsoncontents["n"][$i-1]["content"]);
				print("<hr/>");
				print("</p>");
			}
		?></body></html>