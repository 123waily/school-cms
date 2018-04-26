<?php if(!isset($_SESSION)){ session_start(); }
 require(__DIR__ . "/../../includes/helpers.php") ?>

<?php render("header", ["title" => "Editing Events"]);?>

        <p>You are now submitting date for which the events are to be changed.</p>
		<p><b>No changes have been applied.</b>  <a href="../index.php">Go back home</a></p>
		
		<script>
			/*
				2015/06/29
				ADD EVENTS
			*/
		</script>
				
		<form action="confirmdate.php" method="post" >
				<p>Select a year:</p>
				<select name="year">
					<option value="2014" <?php if (date("Y") == 2014) {print("selected=\"selected\"");}?>>2014</option>
					<option value="2015" <?php if (date("Y") == 2015) {print("selected=\"selected\"");}?>>2015</option>
					<option value="2016" <?php if (date("Y") == 2016) {print("selected=\"selected\"");}?>>2016</option>
					<option value="2017" <?php if (date("Y") == 2017) {print("selected=\"selected\"");}?>>2017</option>
					<option value="2018" <?php if (date("Y") == 2018) {print("selected=\"selected\"");}?>>2018</option>
					<option value="2019" <?php if (date("Y") == 2019) {print("selected=\"selected\"");}?>>2019</option>
					<option value="2020" <?php if (date("Y") == 2020) {print("selected=\"selected\"");}?>>2020</option>
					<option value="2021" <?php if (date("Y") == 2021) {print("selected=\"selected\"");}?>>2021</option>
					<option value="2022" <?php if (date("Y") == 2022) {print("selected=\"selected\"");}?>>2022</option>
					<option value="2023" <?php if (date("Y") == 2023) {print("selected=\"selected\"");}?>>2023</option>
					<option value="2024" <?php if (date("Y") == 2024) {print("selected=\"selected\"");}?>>2024</option>
					<option value="2025" <?php if (date("Y") == 2025) {print("selected=\"selected\"");}?>>2025</option>
				</select>
				
				<select name="month">
					<option value="01" <?php if (date("m") == "01") {print("selected=\"selected\"");}?>>01</option>
					<option value="02" <?php if (date("m") == "02") {print("selected=\"selected\"");}?>>02</option>
					<option value="03" <?php if (date("m") == "03") {print("selected=\"selected\"");}?>>03</option>
					<option value="04" <?php if (date("m") == "04") {print("selected=\"selected\"");}?>>04</option>
					<option value="05" <?php if (date("m") == "05") {print("selected=\"selected\"");}?>>05</option>
					<option value="06" <?php if (date("m") == "06") {print("selected=\"selected\"");}?>>06</option>
					<option value="07" <?php if (date("m") == "07") {print("selected=\"selected\"");}?>>07</option>
					<option value="08" <?php if (date("m") == "08") {print("selected=\"selected\"");}?>>08</option>
					<option value="09" <?php if (date("m") == "09") {print("selected=\"selected\"");}?>>09</option>
					<option value="10" <?php if (date("m") == "10") {print("selected=\"selected\"");}?>>10</option>
					<option value="11" <?php if (date("m") == "11") {print("selected=\"selected\"");}?>>11</option>
					<option value="12" <?php if (date("m") == "12") {print("selected=\"selected\"");}?>>12</option>
				</select>
				
				<select name="day">
					<option value="01" <?php if (date("d") == 01) {print("selected=\"selected\"");}?>>01</option>
					<option value="02" <?php if (date("d") == 02) {print("selected=\"selected\"");}?>>02</option>
					<option value="03" <?php if (date("d") == 03) {print("selected=\"selected\"");}?>>03</option>
					<option value="04" <?php if (date("d") == 04) {print("selected=\"selected\"");}?>>04</option>
					<option value="05" <?php if (date("d") == 05) {print("selected=\"selected\"");}?>>05</option>
					<option value="06" <?php if (date("d") == 06) {print("selected=\"selected\"");}?>>06</option>
					<option value="07" <?php if (date("d") == 07) {print("selected=\"selected\"");}?>>07</option>
					<option value="08" <?php if (date("d") == 08) {print("selected=\"selected\"");}?>>08</option>
					<option value="09" <?php if (date("d") == 09) {print("selected=\"selected\"");}?>>09</option>
					<option value="10" <?php if (date("d") == 10) {print("selected=\"selected\"");}?>>10</option>
					<option value="11" <?php if (date("d") == 11) {print("selected=\"selected\"");}?>>11</option>
					<option value="12" <?php if (date("d") == 12) {print("selected=\"selected\"");}?>>12</option>
					<option value="13" <?php if (date("d") == 13) {print("selected=\"selected\"");}?>>13</option>
					<option value="14" <?php if (date("d") == 14) {print("selected=\"selected\"");}?>>14</option>
					<option value="15" <?php if (date("d") == 15) {print("selected=\"selected\"");}?>>15</option>
					<option value="16" <?php if (date("d") == 16) {print("selected=\"selected\"");}?>>16</option>
					<option value="17" <?php if (date("d") == 17) {print("selected=\"selected\"");}?>>17</option>
					<option value="18" <?php if (date("d") == 18) {print("selected=\"selected\"");}?>>18</option>
					<option value="19" <?php if (date("d") == 19) {print("selected=\"selected\"");}?>>19</option>
					<option value="20" <?php if (date("d") == 20) {print("selected=\"selected\"");}?>>20</option>
					<option value="21" <?php if (date("d") == 21) {print("selected=\"selected\"");}?>>21</option>
					<option value="22" <?php if (date("d") == 22) {print("selected=\"selected\"");}?>>22</option>
					<option value="23" <?php if (date("d") == 23) {print("selected=\"selected\"");}?>>23</option>
					<option value="24" <?php if (date("d") == 24) {print("selected=\"selected\"");}?>>24</option>
					<option value="25" <?php if (date("d") == 25) {print("selected=\"selected\"");}?>>25</option>
					<option value="26" <?php if (date("d") == 26) {print("selected=\"selected\"");}?>>26</option>
					<option value="27" <?php if (date("d") == 27) {print("selected=\"selected\"");}?>>27</option>
					<option value="28" <?php if (date("d") == 28) {print("selected=\"selected\"");}?>>28</option>
					<option value="29" <?php if (date("d") == 29) {print("selected=\"selected\"");}?>>29</option>
					<option value="30" <?php if (date("d") == 30) {print("selected=\"selected\"");}?>>30</option>
					<option value="31" <?php if (date("d") == 31) {print("selected=\"selected\"");}?>>31</option>
				</select>

				<input type="submit" value="Submit" class="btn btn-default"/>
		</form>

<?php render("footer"); ?>