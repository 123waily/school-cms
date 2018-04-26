local composer = require( "composer" )
local scene = composer.newScene()

local adt = require("adata")
local widget = require("widget")
local socket = require("socket")	
-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
	
end
--========================================================================================================================
-- Booleans to check whether file has been downloaded
local downloadedeventsj = 0
local downloadedblocksj = 0
local downloadednewsj = 0

-- These three must be all one for second launch to proceed to menu
local downloadedeventsm = 0
local downloadedblocksm = 0
local downloadednewsm = 0

-- JSON
local function eventsjlistener( event )
	print(event.phase)
	if ( event.isError ) then

	elseif ( event.phase == "ended" ) then
		print( "events.json Downloaded" )
		downloadedeventsj = 1
	end
end

local function blocksjlistener( event )
	if ( event.isError ) then

	elseif ( event.phase == "ended" ) then
		print( "blocks.json Downloaded" )
		downloadedblocksj = 1
	end
end

local function newsjlistener( event )
	if ( event.isError ) then

	elseif ( event.phase == "ended" ) then
		print( "mobilenews.html Downloaded" )
		downloadednewsj = 1
	end
end

-- MD5
local function eventsmlistener( event )
	if ( event.isError ) then

	elseif ( event.phase == "ended" ) then
		print( "events.md5 Downloaded" )
		downloadedeventsm = 1
	end
end

local function blocksmlistener( event )
	if ( event.isError ) then

	elseif ( event.phase == "ended" ) then
		print( "blocks.md5 Downloaded" )
		downloadedblocksm = 1
	end
end

local function newsmlistener( event )
	if ( event.isError ) then

	elseif ( event.phase == "ended" ) then
		print( "news.md5 Downloaded" )
		downloadednewsm = 1
	end
end

local params = {}
params.progress = true
--========================================================================================================================
local function setupdefaults()
-- Function that determines whether day has no events
-- Return 1 means event exists, Return 0 means no event exists.
adt.tfevents = function( year, month, day)
	local events = {}
	events = adt.l("events.json")
	
	year = tostring(year)
	month = tostring(month)
	day = tostring(day)
	
	if ( string.len(month) == 1 ) then
		month = "0" .. month
	end

	if ( string.len(day) == 1 ) then
		day = "0" .. day
	end
	
	if ( events["d"][year] == nil ) then
		return 0
	elseif ( events["d"][year][month] == nil ) then
		return 0
	elseif ( events["d"][year][month][day] == nil ) then
		return 0
	else
		return 1
	end
end

-- Function that determines whether day has no blocks
-- Return 1 means event blocks, Return 0 means no blocks exists.
adt.tfblocks = function( year, month, day)
	local blocks = {}
	blocks = adt.l("blocks.json")
	
	year = tostring(year)
	month = tostring(month)
	day = tostring(day)
	
	if ( string.len(month) == 1 ) then
		month = "0" .. month
	end

	if ( string.len(day) == 1 ) then
		day = "0" .. day
	end
	
	if ( blocks["d"][year] == nil ) then
		return 0
	elseif ( blocks["d"][year][month] == nil ) then
		return 0
	elseif ( blocks["d"][year][month][day] == nil ) then
		return 0
	else
		return 1
	end
end

-- Get block order
adt.getblocks = function( year, month, day)
	local blocks = {}
	blocks = adt.l("blocks.json")
	
	year = tostring(year)
	month = tostring(month)
	day = tostring(day)
	
	if ( string.len(month) == 1 ) then
		month = "0" .. month
	end

	if ( string.len(day) == 1 ) then
		day = "0" .. day
	end

	return blocks["d"][year][month][day]
end

-- Get event table
adt.getevents = function( year, month, day)
	local events = {}
	events = adt.l("events.json")
	
	year = tostring(year)
	month = tostring(month)
	day = tostring(day)
	
	if ( string.len(month) == 1 ) then
		month = "0" .. month
	end

	if ( string.len(day) == 1 ) then
		day = "0" .. day
	end

	return events["d"][year][month][day]
end
-- Function that generates the block order string
adt.bsgen = function(code) 
	local tempstring
	
	if ( code == "d1" ) then
		tempstring = "2, 3, 5, 6, 8"
	elseif ( code == "d2" ) then
		tempstring = "4, 5, 7, 8, 1"
	elseif ( code == "d3" ) then
		tempstring = "6, 7, 2, 1, 3"
	elseif ( code == "d4" ) then
		tempstring = "8, 2, 4, 3, 5"
		
	elseif ( code == "f1" ) then
		tempstring = "1, 4, 6, 7"
	elseif ( code == "f2" ) then
		tempstring = "4, 6, 7, 1"
	elseif ( code == "f3" ) then
		tempstring = "6, 7, 1, 4"
	elseif ( code == "f4" ) then
		tempstring = "7, 1, 4, 6"
		
	elseif code == "p1" then
		tempstring = "2, 3, 5, 6"
	elseif code == "p2" then
		tempstring = "4, 5, 7, 8"
	elseif code == "p3" then
		tempstring = "6, 7, 2, 1"
	elseif code == "p4" then
		tempstring = "8, 2, 4, 3"
		
	elseif ( code == "e1" ) then
		tempstring = "1/2, 3/4"
	elseif ( code == "e2" ) then
		tempstring = "5/6, 7/8"
		
	elseif ( code == "tba" ) then 
		tempstring = "Order TBA, Sorry"
	elseif ( code == nil) then
		tempstring = "No School Today!"
	end

	return tempstring
	
end

-- Takes the block code, returns a table of blocks
-- Takes result of bsgen
-- for viewblocks
adt.tablegen = function(code) 
	local tempstring = {}
	
	if ( code == "d1" ) then
		tempstring = {2, 3, 5, "l", 6, 8}
	elseif ( code == "d2" ) then
		tempstring = {4, 5, 7, "l", 8, 1}
	elseif ( code == "d3" ) then
		tempstring = {6, 7, 2, "l", 1, 3}
	elseif ( code == "d4" ) then
		tempstring = {8, 2, 4, "l", 3, 5}
		
	elseif ( code == "f1" ) then
		tempstring = {1, 4, "l", 6, 7}
	elseif ( code == "f2" ) then
		tempstring = {4, 6, "l", 7, 1}
	elseif ( code == "f3" ) then
		tempstring = {6, 7, "l", 1, 4}
	elseif ( code == "f4" ) then
		tempstring = {7, 1, "l", 4, 6}
		
	elseif ( code == "p1") then
		tempstring = {2, 3, 5, "l", 6}
	elseif ( code == "p2") then
		tempstring = {4, 5, 7, "l", 8}
	elseif ( code == "p3") then
		tempstring = {6, 7, 2, "l", 1}
	elseif ( code == "p4") then
		tempstring = {8, 2, 4, "l", 3}
		
	elseif ( code == "e1" ) then
		tempstring = {1, 2,  "l", 3, 4}
	elseif ( code == "e2" ) then
		tempstring = {5, 6,  "l", 7, 8}
		
	elseif ( code == "tba" ) then 
		tempstring = {"To Be Announced"}
	elseif ( code == nil ) then
		tempstring = {"No School Today!"}
	end

	return tempstring
	
end

-- Gets tablelength
adt.tablelength = function(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

end
local downloadfromurl = "http://semiahmoo.geogamez.com/download/"
--local downloadfromurl = "http://asdfasdfasdasfas.geogamez.com/download/"

local testconnect = "www.google.com"

-- 2015/07/29
-- Tricks system into thinking that it is downloading from a new url each time
-- Prevents downloading from cache
local cachebust = "?a=" .. os.time()
--========================================================================================================================
-- "scene:show()"
function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Called when the scene is still off screen (but is about to come on screen).
	elseif ( phase == "did" ) then

	local testnotes = adt.l("events.json")
	
	local notest = {}
	local todot = {}
	local classes = {}
	
	local morningt = {}
	local luncht = {}
	local afternoont = {}
	
	local blocks = {}
	local events = {}
	--========================================================================================================================
	if testnotes == nil then
		print("YOU OPENED THIS APP FOR THE FIRST TIME!")
		
		todot.n1 = {}
		todot.n1.title = "Tap the add button on the top right"
		todot.n1.desc = "Delete this note by swiping left on this note in the previous screen"
		todot.n1.rem = 1416005285
	
		todot.i = 1
		adt.s(todot, "todot.json")
		
		--==================================================		
		classes[1] = "Course 1 s1"
		classes[2] = "Course 2 s1"
		classes[3] = "Course 3 s1"
		classes[4] = "Course 4 s1"
		classes[5] = "Course 5 s1"
		classes[6] = "Course 6 s1"
		classes[7] = "Course 7 s1"
		classes[8] = "Course 8 s1"
		
		classes[9] = "Course 1 s2"
		classes[10] = "Course 2 s2"
		classes[11] = "Course 3 s2"
		classes[12] = "Course 4 s2"
		classes[13] = "Course 5 s2"
		classes[14] = "Course 6 s2"
		classes[15] = "Course 7 s2"
		classes[16] = "Course 8 s2"

		adt.s(classes, "classes.json")
		--========================================================================================================================
		-- Download events, blocks, and mobilenews.html
		
		local test = socket.tcp()
		test:settimeout(5)
		local testResult = test:connect(testconnect, 80)
		isconnected = 0
			
		if not(testResult == nil) then
			print("Internet access is available")
			isconnected = 1
			
			-- Download three hashes
			
			network.download(
				downloadfromurl  .. "md5/events.md5" .. cachebust,
				"GET",
				eventsmlistener,
				params,
				"events.md5",
				system.documentsDirectory
			)
			
			network.download(
				downloadfromurl  .. "md5/blocks.md5" .. cachebust,
				"GET",
				blocksmlistener,
				params,
				"blocks.md5",
				system.documentsDirectory
			)
			
			network.download(
				downloadfromurl  .. "md5/news.md5" .. cachebust,
				"GET",
				newsmlistener,
				params,
				"news.md5",
				system.documentsDirectory
			)
			
			-- Downlo0ad JSON
			network.download(
				downloadfromurl  .. "json/events.json" .. cachebust,
				"GET",
				eventsjlistener,
				params,
				"events.json",
				system.documentsDirectory
			)
			
			network.download(
				downloadfromurl  .. "json/blocks.json" .. cachebust,
				"GET",
				blocksjlistener,
				params,
				"blocks.json",
				system.documentsDirectory
			)
			
			network.download(
				downloadfromurl  .. "html/mobilenews.html" .. cachebust,
				"GET",
				newsjlistener,
				params,
				"mobilenews.html",
				system.documentsDirectory
			)
			
		--=======================================
		-- Looping timer checking whether everthing has been downloaded
		local sanitytimer
		
		-- Checked 10 times = checked one second, after fifteen seconds 
		local havechecked = 0
		
		local function checkdownloaded()
			if ( downloadedeventsm == 1 and downloadedblocksm == 1 and downloadednewsm == 1 and downloadedeventsj == 1 and downloadedblocksj == 1 and downloadednewsj == 1 ) then
				composer.gotoScene( "menu", {effect = "fade", time = 800 } )
				setupdefaults()
				timer.cancel(sanitytimer)
			elseif ( havechecked > 51 ) then
				timer.cancel( sanitytimer )
				local function onComplete( event )
				   if event.action == "clicked" then
						local i = event.index
						if i == 1 then
							if system.getInfo( "platformName" ) == "Android" then
								os.exit()
							else
								os.exit()
							end
						end
					end
				end
				
				local alert = native.showAlert( "Internet Connection Required", "Initial setup requires an Internet connection.  Please connect this device to the Internet or check your connection and relaunch this app.", { "Ok" }, onComplete )

				--composer.gotoScene( "menu", {effect = "fade", time = 800 } )
				setupdefaults()
				sanitytimer = nil
			end
			print("Checking if all files are downloaded..")
			print(downloadedeventsm)
			print(downloadedblocksm)
			print(downloadednewsm)
			print(downloadedeventsj)
			print(downloadedblocksj)
			print(downloadednewsj)
			havechecked = havechecked + 1
			print(havechecked)
		end
		
		sanitytimer = timer.performWithDelay( 100, checkdownloaded, 0)
		--=======================================
		else
			print("Internet access is not available")
			print("YOU NEED INTERNET TO LAUNCH THIS APP")
			
			local function onComplete( event )
			   if event.action == "clicked" then
					local i = event.index
					if i == 1 then
						if system.getInfo( "platformName" ) == "Android" then
							os.exit()
						else
							os.exit()
						end
					end
				end
			end
			
			local alert = native.showAlert( "Internet Connection Required", "Initial setup requires an Internet connection.  Please connect this device to the Internet or check your connection and relaunch this app.", { "Ok" }, onComplete )
		end
		--========================================================================================================================
	else
		print("YOU CAME BACK!  THIS APP DOESN'T SUCK!")
		-- Download events, blocks, and mobilenews.html
		-- Functions
		local checkeventsupdate
		local checkblocksupdate
		local checknewsupdate
		
		local eventscontent, tempeventscontent
		local blockscontent, tempblockscontent
		local newscontent, tempnewscontent
		
		local function eventsnetworkListener( event )
			if ( event.phase == "ended" ) then
				-- Files have been downloaded
				-- Compare hashes with existing
				eventscontent = adt.lws("events.md5")
				print("EXISTING events.md5 contents: " .. eventscontent)
				
				-- read tempevents
				tempeventscontent = adt.lws("tempevents.md5")
				
				print("EXISTING tempevents.md5 contents: " .. tempeventscontent)
				
				checkeventsupdate()
			end
		end
		
		local function blocksnetworkListener( event )
			if ( event.phase == "ended" ) then
				-- Files have been downloaded
				-- Compare hashes with existing
				blockscontent = adt.lws("blocks.md5")
				print("EXISTING blocks.md5 contents: " .. blockscontent)
				
				-- read tempblocks
				tempblockscontent = adt.lws("tempblocks.md5")
				
				print("EXISTING tempblocks.md5 contents: " .. tempblockscontent)
				
				checkblocksupdate()
			end
		end
		
		local function newsnetworkListener( event )
			if ( event.phase == "ended" ) then
				-- Files have been downloaded
				-- Compare hashes with existing
				--=========================================
				-- Compare news content
				newscontent = adt.lws("news.md5")
				print("EXISTING NEWS.md5 contents: " .. newscontent)
				
				-- read tempnews
				tempnewscontent = adt.lws("tempnews.md5")
				
				print("EXISTING tempnews.md5 contents: " .. tempnewscontent)
				
				checknewsupdate()
			end
		end
		
		local test = socket.tcp()
		test:settimeout(5)
		local testResult = test:connect(testconnect, 80)
		isconnected = 0
		
		-- The following function will not execute if there is no internet connection
		if not(testResult == nil) then
			
			if not(testResult == nil) then
				print("Internet access is available")
				isconnected = 1
				
				-- Delete old hashes
				
				local resultevents, reasonevents = os.remove( system.pathForFile( "tempevents.md5", system.DocumentsDirectory ) )
				local resultblocks, reasonblocks = os.remove( system.pathForFile( "tempblocks.md5", system.DocumentsDirectory ) )
				local resultsnews, reasonnews = os.remove( system.pathForFile( "tempnews.md5", system.DocumentsDirectory ) )
				
				-- Download three temp hashes
				network.download(
					downloadfromurl  .. "md5/events.md5" .. cachebust,
					"GET",
					eventsnetworkListener,
					params,
					"tempevents.md5",
					system.DocumentsDirectory
				)
				
				network.download(
					downloadfromurl  .. "md5/blocks.md5" .. cachebust,
					"GET",
					blocksnetworkListener,
					params,
					"tempblocks.md5",
					system.DocumentsDirectory
				)
				
				network.download(
					downloadfromurl  .. "md5/news.md5" .. cachebust,
					"GET",
					newsnetworkListener,
					params,
					"tempnews.md5",
					system.DocumentsDirectory
				)
			else
				print("Internet access is not available")
				isconnected = 0
			end
			--========================================================================================================================
			checknewsupdate = function()
				if (newscontent == tempnewscontent) then
					print("News didn't change")
					downloadednewsj = 1
					downloadednewsm = 1
					local resultsnews, reasonnews = os.remove( system.pathForFile( "tempnews.md5", system.DocumentsDirectory ) )
				else
					print("News Changed!")
					if not(testResult == nil) then
						-- Replace existing news
						local resultsnews, reasonnews = os.remove( system.pathForFile( "mobilenews.html", system.DocumentsDirectory ) )
						local resultsnews2, reasonnews2 = os.remove( system.pathForFile( "tempnews.md5", system.DocumentsDirectory ) )
						
						local function downloadnews()
							network.download(
								downloadfromurl  .. "html/mobilenews.html" .. cachebust,
								"GET",
								newsjlistener,
								params,
								"mobilenews.html",
								system.documentsDirectory
							)
							
							-- Replace current hash with temp hash
							network.download(
								downloadfromurl  .. "md5/news.md5" .. cachebust,
								"GET",
								newsmlistener,
								params,
								"news.md5",
								system.documentsDirectory
							)
						end
						timer.performWithDelay(200, downloadnews)
					end
				end
			end
			--========================================================================================================================
			checkblocksupdate = function()
				if (blockscontent == tempblockscontent) then
					print("blocks didn't change")
					downloadedblocksj = 1
					downloadedblocksm = 1
					local resultsblocks, reasonblocks = os.remove( system.pathForFile( "tempblocks.md5", system.DocumentsDirectory ) )
				else
					print("blocks Changed!")
					if not(testResult == nil) then
						-- Replace existing blocks
						local resultsblocks, reasonblocks = os.remove( system.pathForFile( "blocks.json", system.DocumentsDirectory ) )
						local resultsblocks2, reasonblocks2 = os.remove( system.pathForFile( "tempblocks.md5", system.DocumentsDirectory ) )
						
						local function downloadblocks()
							network.download(
								downloadfromurl  .. "json/blocks.json" .. cachebust,
								"GET",
								blocksjlistener,
								params,
								"blocks.json",
								system.documentsDirectory
							)
							
							-- Replace current hash with temp hash
							network.download(
								downloadfromurl  .. "md5/blocks.md5" .. cachebust,
								"GET",
								blocksmlistener,
								params,
								"blocks.md5",
								system.documentsDirectory
							)
						end
						timer.performWithDelay(200, downloadblocks)
					end
				end
			end
			--========================================================================================================================
			checkeventsupdate = function()
				if (eventscontent == tempeventscontent) then
					print("events didn't change")
					downloadedeventsj = 1
					downloadedeventsm = 1
					local resultsevents, reasonevents = os.remove( system.pathForFile( "tempevents.md5", system.DocumentsDirectory ) )
				else
					print("events Changed!")
					if not(testResult == nil) then
						-- Replace existing events
						local resultsevents, reasonevents = os.remove( system.pathForFile( "events.json", system.DocumentsDirectory ) )
						local resultsevents2, reasonevents2 = os.remove( system.pathForFile( "tempevents.md5", system.DocumentsDirectory ) )
						
						local function downloadevents()
							network.download(
								downloadfromurl  .. "json/events.json" .. cachebust,
								"GET",
								eventsjlistener,
								params,
								"events.json",
								system.documentsDirectory
							)
							
							-- Replace current hash with temp hash
							network.download(
								downloadfromurl  .. "md5/events.md5" .. cachebust,
								"GET",
								eventsmlistener,
								params,
								"events.md5",
								system.documentsDirectory
							)
						end
						timer.performWithDelay(200, downloadevents)
					end
				end
			end
		--=======================================
		-- Looping timer checking whether everthing has been downloaded
		local sanitytimer
		
		-- Checked 10 times = checked one second, after fifteen seconds 
		local havechecked = 0
		
		local function checkdownloaded()
			if ( downloadedeventsm == 1 and downloadedblocksm == 1 and downloadednewsm == 1 and downloadedeventsj == 1 and downloadedblocksj == 1 and downloadednewsj == 1 ) then
				composer.gotoScene( "menu", {effect = "fade", time = 800 } )
				setupdefaults()
				timer.cancel(sanitytimer)
			elseif ( havechecked > 51 ) then
				timer.cancel( sanitytimer )
				local alert = native.showAlert( "Cannot fetch updated information from server", "The information provided may have been updated.", { "Ok" } )
				composer.gotoScene( "menu", {effect = "fade", time = 800 } )
				setupdefaults()
				sanitytimer = nil
			end
			print("Checking if all files are downloaded..")
			print(downloadedeventsm)
			print(downloadedblocksm)
			print(downloadednewsm)
			print(downloadedeventsj)
			print(downloadedblocksj)
			print(downloadednewsj)
			havechecked = havechecked + 1
			print(havechecked)
		end
		
		sanitytimer = timer.performWithDelay( 100, checkdownloaded, 0)
		--========================================================================================================================
		else
			-- There is no internet connection
			local alert = native.showAlert( "Cannot fetch updated information from server", "The information provided may have been updated.", { "Ok" } )
			print("No Internet Connection")
			composer.gotoScene( "menu", {effect = "fade", time = 800 } )
			setupdefaults()
		end
	end
	end
end


-- "scene:hide()"
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Called when the scene is on screen (but is about to go off screen).
		-- Insert code here to "pause" the scene.
		-- Example: stop timers, stop animation, stop audio, etc.
	elseif ( phase == "did" ) then
		-- Called immediately after scene goes off screen.
	end
end


-- "scene:destroy()"
function scene:destroy( event )

	local sceneGroup = self.view
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene