local composer = require( "composer" )
local scene = composer.newScene()

local adt = require("adata")
local widget = require("widget")

local _W = display.contentWidth
local _H = display.contentHeight

local hw = _W/2
local hh = _H/2 

local notest = adt.l("notest.json")
local todot = adt.l("todot.json")
local uclasst = adt.l("uclasst.json")

local morningt = adt.l("morningt.json")
local luncht = adt.l("luncht.json")
local afternoont = adt.l("afternoont.json")

-- "scene:create()"
function scene:create( event )
	local group = self.view
end

local rowi = 0
local date = os.date
local time = os.time()
local mod = math.fmod

local blocks = {}
blocks = adt.l("blocks.json")

local events = {}
events = adt.l("events.json")

local slideView = require("slideViewNew")

-- "scene:show()"
function scene:show( event )
	
	local group = self.view
	local phase = event.phase

if ( phase == "will" ) then
	
elseif ( phase == "did" ) then
	
	-- Months from 2015/08 - 2016/07
	local calgroups = {}
	-- Title and bakcground for the calgroups
	local calessentials = {}
	-- Storage of the days that are displayed in the calendar
	local days = {}
	
	-- Populate the days children with.. more children
	for i=1, 12 do
		days[i] = {}
	end
--========================================================================================================================	
	--[[		
		If month is 08-12
			display from this year's august to next year's december
			
			feb detection next year
			
			08-12 is from this year
			01-07 is from next year
		if month is 01-07
			display from last year's august to this year's july
			
			feb detection this year
			
			08-12 is from last year
			01-07 is from this year
		end
	]]
	
	local febdetectionyear
	
	--[[
		If one is in the former half, the value will be one
		If one is in the latter half, the value will be zero
	]]
	
	local isinformer
	
	if ( adt.mtodayn > 7) then
		-- This is the former half
		febdetectionyear = adt.ytodayn + 1
		isinformer = 1
	else
		-- Latter half
		febdetectionyear = adt.ytodayn
		isinformer = 0
	end
	
	print(febdetectionyear)
	
--========================================================================================================================
-- This function depopulates and repopulates the table with the date that the user clicks.
-- The table takes the raw numbers and runs the numbers through adt.tfevents

-- Function way below that populates the table
local populatet
local tableView

local tableparams = {}
tableparams["year"] = adt.ytodayn
tableparams["month"] = adt.mtodayn
tableparams["day"] = adt.dtodayn

tableparams["datestring"] = adt.mtodayn .. "/" .. adt.dtodayn

local tappedday = function(year, month, day)
	tableparams["year"] = year
	tableparams["month"] = month
	tableparams["day"] = day
	tableparams["datestring"] = month .. "/" .. day
	tableView:deleteAllRows()
	populatet()
end
--========================================================================================================================
	-- Monday third parameter is one, vice versa

	--	https://gist.github.com/perusio/6551715
	-- Function that determines whether the year is a leap year
	local function leap_year(year)
	   if mod(year, 4) == 0 then
		  local m = mod(year, 400)
		  return not (m == 100 or m == 200 or m == 300)
	   else
		  return false
	   end
	end
	
local function populate( month, year, start)
	-- Month in three letters, year in four, start day (1-7), number of days, abbreviation of month two nums.
	-- Used to label groups and Day buttons

	-- Find the number of days in the month provided
	if (month == 2) then
		if (leap_year(febdetectionyear) == true) then
			nd = 29
		else
			nd = 28
		end
	
	elseif (month == 1 or month == 3 or month == 5 or month == 7 or month == 8 or month == 10 or month == 12) then
		nd = 31
	else
		nd = 30
	end
	
	local oneseventh = _W/7
	local onefifth = _W/(7)
	local ini = 40
	
	local row1 = ini + onefifth
	local row2 = ini + onefifth*2
	local row3 = ini + onefifth*3
	local row4 = ini + onefifth*4
	local row5 = ini + onefifth*5
	local row6 = ini + onefifth*6

	-- Will add up throughout
	local rowid = 2

	if (start == 5 or start == 6) then
		rowid = 1
	end
		
	-- For loop loops round and round until all days has been displayed
	for i = 1, nd, 1 do
		-- Tables do not accept numbers as children
		local dayid = i

		local textr = adt.textr
		local textg = adt.textg
		local textb = adt.textb

		--========================================
		-- DETECT SPECIAL DAYS
		if ( adt.tfevents( year, month, dayid )  == 0 ) then
			-- No special event
		else
			textr = adt.btextr
			textg = adt.btextg
			textb = adt.btextb
		end
		--========================================
		--print(adt.tfblocks( year, month, dayid ))
		if ( adt.tfblocks( year, month, dayid )  == 0 ) then
			-- No school
			textr = adt.rtextr
			textg = adt.rtextg
			textb = adt.rtextb
		else
			-- School
		end
		
		-- Weekends/noschool aka no blocks table present are red
		if ( start == 7 or start == 6) then
			textr = adt.rtextr
			textg = adt.rtextg
			textb = adt.rtextb
		end
		--========================================

		days[month][dayid] = widget.newButton
		{
			defaultFile = "images/blank.png",
			overFile = "images/blank.png",
			font = adt.font,
			fontSize = 15,
			emboss = false,
			label = i,
			labelColor = { default = {textr, textg, textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
			width = 44,
			height = 44,
			labelYOffset = adt.exof + adt.ishift,
		}
		days[month][dayid].anchorX = 1
		
		-- Corresponding months to their group
		local monthgroupid = adt.gengroupnum(month)
		--print("GROUP ID: " .. monthgroupid)
		calgroups[monthgroupid]:insert(days[month][dayid])
		
		days[month][dayid].year = year
		days[month][dayid].month = month
		days[month][dayid].day = dayid

		local function tappeddayif()
			print("DAY CLICKED " .. year .. "   " .. month .. "   " .. dayid)
			tappedday( days[month][dayid].year, days[month][dayid].month, days[month][dayid].day )
		end

		days[month][dayid]:addEventListener("tap", tappeddayif)

		-- Displays the y values of the buttons first, default is 1 and adds up
		if ( rowid == 1 ) then
			days[month][dayid].y = row1
		elseif (rowid == 2) then
			days[month][dayid].y = row2
		elseif (rowid == 3) then
			days[month][dayid].y = row3
		elseif (rowid == 4) then
			days[month][dayid].y = row4
		elseif (rowid == 5) then
			days[month][dayid].y = row5
		elseif (rowid == 6) then
			days[month][dayid].y = row6
		end

		-- Monday is second row lol
		if ( start == 1 ) then
			days[month][dayid].x = oneseventh *2
			start = 2
		elseif (start == 2) then
			days[month][dayid].x = oneseventh *3
			start = 3
		elseif (start == 3) then
			days[month][dayid].x = oneseventh *4
			start = 4
		elseif (start == 4) then
			days[month][dayid].x = oneseventh *5
			start = 5
		elseif (start == 5) then
			days[month][dayid].x = oneseventh *6
			start = 6
		elseif (start == 6) then
			days[month][dayid].x = _W
			start = 7
			-- Add one to rowid to go to second row
			rowid = rowid + 1
		elseif (start == 7) then
			days[month][dayid].x = oneseventh
			-- Reset day to Monday and start again
			start = 1
		end

	end
	
end
--========================================================================================================================
--http://lua-users.org/wiki/DayOfWeekAndDaysInMonthExample
-- Finds the day of the week
local function get_day_of_week(dd, mm, yy)
	dw=os.date('*t',os.time{year=yy,month=mm,day=dd})['wday']
	return ({7,1,2,3,4,5,6})[dw]
end
--========================================================================================================================
	-- Generate Calendar Groups, backgrounds, and titles
	--[[
		Generates automatically 12 screens, from august to july
		
		If month is 08-12
			display from this year's august to next year's december
		if month is 01-07
			display from last year's august to this year's july
			
		end
	]]
	for i=1, 12 do
		calgroups[i] = display.newGroup()
		
		calessentials[i] = {}
		
		calessentials[i]["rec"] = display.newRect(hw , hh, _W, _H)
		calessentials[i]["rec"]:setFillColor(1, 1, 1)
		
		calessentials[i]["text"] = display.newText( i, 100, 200, adt.font, 22 )
		calessentials[i]["text"]:setFillColor( adt.textr, adt.textg, adt.textb )
		calessentials[i]["text"].x = _W/2; calessentials[i]["text"].y = 42 + adt.ishift
		
		calgroups[i]:insert(calessentials[i]["rec"])
		calgroups[i]:insert(calessentials[i]["text"])
		
		-- Generate month ID for each group, 8 to 1 and vice versa
		local monthofgroup = adt.genmonthnum(i)
		print("MONTH ID: " .. monthofgroup)
		
		-- Detect if the month being generated is in the former or latter half
		local yearofgroup
		if ( isinformer == 1 ) then
			-- User is in former half, therefore
			-- August uses current year, January uses next year
			
			if ( monthofgroup > 7) then
				-- Aug to Dec
				yearofgroup = adt.ytodayn
			else
				-- Jan to Jul
				yearofgroup = adt.ytodayn + 1
			end
			
		elseif ( isinformer == 0 ) then
			-- User is in latter half, therefore
			-- August uses last year, January uses current year
			
			if ( monthofgroup > 7) then
				-- Aug to Dec
				yearofgroup = adt.ytodayn - 1
			else
				-- Jan to Jul
				yearofgroup = adt.ytodayn
			end
		end
		
		populate( monthofgroup, yearofgroup, get_day_of_week(1, monthofgroup, yearofgroup))
		
		calessentials[i]["text"].text = yearofgroup .. "/" .. monthofgroup
		
		print(i)
	end

	local calview = slideView.new( calgroups, adt.gengroupnum(adt.mtodayn), nil, 0, 0 )
	--========================================================================================================================
	-- Peripherals
	local titlebar = display.newImageRect( "images/topbar.png", _W, 64)
	titlebar.x = _W/2; titlebar.y = 32
	
	local titletext = display.newText( "Calendar", 100, 200, adt.font, 22 )
	titletext:setFillColor( adt.textr, adt.textg, adt.textb )
	titletext.x = _W/2; titletext.y = 42 + adt.ishift
	
	titletext.isVisible = false
	
	local backtomain = widget.newButton
	{
		defaultFile = "images/bbnn.png",
		overFile = "images/bbnnover.png",
		width = 30,
		height = 30,
		noLines = true,
	}
	backtomain.x = 22; backtomain.y = 42;
	
	--========================================================================================================================
	--========================================================================================================================
	
	local function onRowTouch( event )
		local row = event.row
		rowi = row.index

		-- If two
		if (event.phase == "release") then
			
		end
	end
	
	local rowtitle = {}

	local function onRowRender( event )
		local phase = event.phase
		local row = event.row
		--=================================================================
		--[[
			First row displays the datestring
			Second row displays the block order
			
			Events:
			Third
			Fourth
			Fifth
		]]--
		if ( row.index == 1) then
			-- First row displays the datestring
			rowtitle[row.index] = display.newText( tableparams["datestring"]  , 100, 200, adt.font, 20 )
			rowtitle[row.index]:setFillColor( adt.textr, adt.textg, adt.textb )
			rowtitle[row.index].x = _W/2; rowtitle[row.index].y = row.height/2
			row:insert(rowtitle[row.index])
			
		elseif (row.index == 2) then
			-- Second row displays
			rowtitle[row.index] = display.newText( "Block Order" , 100, 200, adt.font, 20 )
			rowtitle[row.index]:setFillColor( adt.textr, adt.textg, adt.textb )
			rowtitle[row.index].x = _W/2; rowtitle[row.index].y = row.height/2
	
			if ( adt.tfblocks(tableparams["year"], tableparams["month"], tableparams["day"]) == 0 ) then
				rowtitle[row.index].text = "No School Today!"
				rowtitle[row.index]:setFillColor( adt.rtextr, adt.rtextg, adt.rtextb )
			else
				rowtitle[row.index].text = adt.bsgen(adt.getblocks(tableparams["year"], tableparams["month"], tableparams["day"]))
			end
			
			row:insert(rowtitle[row.index])
		else
			rowtitle[row.index] = display.newText( " " , 100, 200, adt.font, 15 )
			rowtitle[row.index]:setFillColor( adt.btextr, adt.btextg, adt.btextb )
			rowtitle[row.index].x = _W/2; rowtitle[row.index].y = row.height/2
			row:insert(rowtitle[row.index])

			--==============
			local index = row.index-1

			-- Loop thorugh rows
			if ( row.index == 3 ) then
				if ( adt.tfevents(tableparams["year"], tableparams["month"], tableparams["day"])  == 0 ) then
					-- No events
				else
					print(adt.getevents(tableparams["year"], tableparams["month"], tableparams["day"])[1])
					-- Events 1
					if (adt.getevents(tableparams["year"], tableparams["month"], tableparams["day"])[1] ~= nil) then
						rowtitle[row.index].text = adt.getevents(tableparams["year"], tableparams["month"], tableparams["day"])[1]
					end
				end

			elseif ( row.index == 4 ) then
				if ( adt.tfevents(tableparams["year"], tableparams["month"], tableparams["day"])  == 0 ) then
					-- No events
				else
					-- Events 2
					if (adt.getevents(tableparams["year"], tableparams["month"], tableparams["day"])[2] ~= nil) then
						rowtitle[row.index].text = adt.getevents(tableparams["year"], tableparams["month"], tableparams["day"])[2]
					end
				end

			elseif ( row.index == 5 ) then
				if ( adt.tfevents(tableparams["year"], tableparams["month"], tableparams["day"])  == 0 ) then
					-- No events
				else
					-- Events 3
					if (adt.getevents(tableparams["year"], tableparams["month"], tableparams["day"])[3] ~= nil) then
						rowtitle[row.index].text = adt.getevents(tableparams["year"], tableparams["month"], tableparams["day"])[3]
					end
				end
			end
		end
		--==================================================================
	end

	tableView = widget.newTableView
	{
		height = _H - (20 + 44 + _W/7*6),
		width = _W,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
		
		backgroundColor = { 0.5, 0.5, 0.5, 0},
		hideBackground = true,
		--isLocked = false,
		hideScrollBar = false,
		noLines = true,
		maxVelocity = 0.7,
		friction = 2,
		isBounceEnabled = false,
		scrollBarOptions = 
		{
			sheet = scrollbar,
			topFrame = 1,
			middleFrame = 2,
			bottomFrame = 3
		},
		rowTouchDelay = 5,
		
	}
	tableView.anchorX = 0.5; tableView.anchorY = 0
	tableView.y = 20 + 44 + _W/7*6; tableView.x = _W/2
	--tableView.y = _H/2+ (40 + _W/7*6) - 8; tableView.x = _W/2
	
	
	populatet = function()
		for i = 1, 5 do

			local isCategory = false
			local rowHeight = 44
			local rowColor = { default = { 255/255, 255/255, 255/255, 0 }, over = { 235/255, 235/255, 235/255 } }

		    if ( i == 1 ) then
		        isCategory = true
		        rowHeight = 40
		        rowColor = { default={ 235/255, 235/255, 235/255 } }
		        lineColor = { 1, 0, 0 }
		    end

			print("INSERTED ROW")
			-- Insert the row into the tableView
			tableView:insertRow
			{
				isCategory = isCategory,
				rowHeight = rowHeight,
				rowColor = rowColor,
				onRender = onRowRender,

			}
		end
	end
	populatet()

	--========================================================================================================================
	--========================================================================================================================
	local ys = {}
	
	ys.titletext = titletext.y
	ys.titlebar = titlebar.y
	ys.backtomain = backtomain.y
	ys.tableView = tableView.x
	
	titletext.y = -700
	titlebar.y = -700
	backtomain.y = -700
	tableView.x = _W*4
	
	local enters = function()
		transition.to(titletext,{ time=502, y = ys.titletext, transition=easing.inOutExpo } )
		transition.to(titlebar,{ time=502, y = ys.titlebar, transition=easing.inOutExpo } )
		transition.to(backtomain,{ time=502, y = ys.backtomain, transition=easing.inOutExpo } )
		transition.to(tableView,{ time=502, x = ys.tableView, transition=easing.inOutExpo } )
	end
	
	local exitsc = function()
		transition.to(titletext,{ time=502, y = -700, transition=easing.inOutExpo } )
		transition.to(titlebar,{ time=502, y = -700, transition=easing.inOutExpo } )
		transition.to(backtomain,{ time=502, y = -700, transition=easing.inOutExpo } )
		transition.to(tableView,{ time=502, w = -_W*4, transition=easing.inOutExpo } )
		calview:cleanUp()
	end
	
	enters()
	--========================================================================================================================
	local bbnm = function()
		composer.gotoScene("menu", {effect = "fade", time = 200 } )
		exitsc()
	end
	backtomain:addEventListener("tap", bbnm)
	--========================================================================================================================
	group:insert(calview)
	group:insert(titlebar)
	group:insert(titletext)
	group:insert(backtomain)
	group:insert(tableView)
	
end

end


-- "scene:hide()"
function scene:hide( event )

	local group = self.view
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
	local group = self.view

	-- Called prior to the removal of scene's view ("group").
	-- Insert code here to clean up the scene.
	-- Example: remove display objects, save state, etc.
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene