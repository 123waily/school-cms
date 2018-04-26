local composer = require( "composer" )
local scene = composer.newScene()

local adt = require("adata")
local widget = require("widget")

local _W = display.contentWidth
local _H = display.contentHeight

local notest = adt.l("notest.json")
local todot = adt.l("todot.json")
local uclasst = adt.l("uclasst.json")

local morningt = adt.l("morningt.json")
local luncht = adt.l("luncht.json")
local afternoont = adt.l("afternoont.json")

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
	
end

local date = os.date

-- pupolate table
local populate

-- Variable to store the rowid of the row tapped
-- For desc and title alike
local rowi = 0
adt.isswipe = 0

-- Remove row function needed before that
--bbnr

-- Return to Notes Panel full of tables
-- bbnt

-- "scene:show()"
function scene:show( event )
	composer.removeHidden()

	local sceneGroup = self.view
	local phase = event.phase

if ( phase == "will" ) then

elseif ( phase == "did" ) then
	
	local titlebar = display.newImageRect( "images/topbar.png", _W, 64)
	titlebar.x = _W*0.5; titlebar.y = 32
	
	local titletext = display.newText( "Notes", 100, 200, adt.font, 22 )
	titletext:setFillColor( adt.textr, adt.textg, adt.textb )
	titletext.x = _W*0.5; titletext.y = 42 + adt.ishift
	
	local titletext2 = display.newText( "Edit Note", 100, 200, adt.font, 22 )
	titletext2:setFillColor( adt.textr, adt.textg, adt.textb )
	titletext2.x = _W*0.5+_W; titletext2.y = 42 + adt.ishift
	
	local backtomain = widget.newButton
	{
		defaultFile = "images/bbnn.png",
		overFile = "images/bbnnover.png",
		width = 30,
		height = 30,
		noLines = true,
	}
	backtomain.x = 22; backtomain.y = 42;
	
	local addbtn = widget.newButton
	{
		defaultFile = "images/badd.png",
		overFile = "images/baddover.png",
		width = 30,
		height = 30,
		noLines = true,
	}
	addbtn.x = _W - 22; addbtn.y = 42;
	
	-------=================================
	
	local backtonotes = widget.newButton
	{
		defaultFile = "images/bbnn.png",
		overFile = "images/bbnnover.png",
		width = 30,
		height = 30,
		noLines = true,
	}
	backtonotes.x = _W+22+_W; backtonotes.y = 42;
	
	-- After swiping, no longer needed
	-- Will purge later 20150129
	-- removebtn old
	local donebtn = widget.newButton
	{
		defaultFile = "images/done.png",
		overFile = "images/doneover.png",
		width = 30,
		height = 30,
		noLines = true,
	}
	donebtn.x = _W+22+_W; donebtn.y = 42;
	
	donebtn.isVisible = false
	
	local options =
	{
		width = 2,
		height = 2,
		numFrames = 3,
	}
	local scrollbar = graphics.newImageSheet( "images/scroll.png", options )
	--========================================================================================================================
	local notegroup = display.newGroup()
	notegroup.x = _W

	local tbtitle = native.newTextField( _W*0.5, 110, _W-50, 40 )
	tbtitle.text = "Title."
	tbtitle.isEditable = true

	local tbdesc = native.newTextBox( _W*0.5, _H*0.5-25, _W-50, _H*0.3 )
	tbdesc.text = "Desc."
	tbdesc.isEditable = true
	
	-- There's a glitch in which the textboxes flicker for a while before moving to _W.
	-- Delayed the transition of the textboxes to their respective places.
	-- TODO

	local function descinput( event )
		donebtn.isVisible = true
		if event.phase == "began" then
			todot["n" .. rowi].desc = event.text
			adt.s(todot, "todot.json")
			print( event.text )
			
		elseif event.phase == "ended" then
			donebtn.isVisible = false
			native.setKeyboardFocus( nil )

		elseif event.phase == "editing" then
			print( event.newCharacters )
			print( event.oldText )
			print( event.startPosition )
			print( event.text )
			
			todot["n" .. rowi].desc = event.text
			adt.s(todot, "todot.json")
		end
	end
	
	local function titleinput( event )
		donebtn.isVisible = true
		if event.phase == "began" then

			print( event.target.text .. " EVENT.TEXT BEGINNING")

			todot["n" .. rowi].title = event.target.text
			adt.s(todot, "todot.json")

		elseif event.phase == "submitted" then
			print( event.target.text .. " EVENT.TEXT")
			donebtn.isVisible = false
			native.setKeyboardFocus( nil )
		
		elseif event.phase == "editing" then
			print( event.newCharacters )
			print( event.oldText )
			print( event.startPosition )
			print( event.target.text )
			
			--[[
			local myNum = 20 -- max characters 
			
			-- Detects whether the string has excedded 20 characters
			if string.len(event.target.text) > myNum then
				print("Maximum Length Exceeded")
			end

			-- Trims the strings to 20 characters
			event.text = string.sub(event.text, 1, 20)

			-- Replaces every enter with nothing
			todot["n" .. rowi].title = string.gsub(event.text, "\n", "")
			]]

			todot["n" .. rowi].title = event.target.text
			print(todot["n" .. rowi].title .. "   rowtitle")

			adt.s(todot, "todot.json")
		end
	end
	tbdesc:addEventListener( "userInput", descinput )
	tbtitle:addEventListener( "userInput", titleinput )
		
	notegroup:insert(tbdesc)
	notegroup:insert(tbtitle)
	--========================================================================================================================
	local tableView
	
	-- Delete buttons, Row title texts
	local rowtitle = {}
	local dbs = {}
	
	--================================================
	-- Remove Row, needs to be above the renderrow function
	local bbnr = function()
		todot["n" .. rowi].title = nil
		todot["n" .. rowi].desc = nil
		adt.s(todot, "todot.json")
		
		for i = rowi, (todot.i-1), 1 do		
			todot["n" .. i].title = todot["n" .. (i+1)].title
			todot["n" .. i].desc = todot["n" .. (i+1)].desc
			todot["n" .. i].rem = todot["n" .. (i+1)].rem
			print( "Moved " .. (i+1) .. " to " .. i)
		end
		
		todot["n" .. todot.i].title = nil
		todot["n" .. todot.i].desc = nil
		todot["n" .. todot.i].rem = nil
		todot["n" .. todot.i] = nil
		
		todot.i = todot.i - 1
		adt.s(todot, "todot.json")
		
		tableView:deleteAllRows()
		populate()
		
	end
	--========================================================================================================================
	--[[	2015/01/31 Emerson Hsieh
	isswipe is zero.
	I touch the row.  event.phase is detected whether it is a swipe or not:
		If it is, isswipe becomes one, and the delete button shows.
		If it is not, isswipe remains zero and the function does nothing visually.
	Then, when the row is released the function is called again. it is detected whether isswipe is one or not:
		If it is, isswipe sets back to zero and nothing extra is done visually since the delete button is shown in the previous if statement
		IF it is not, the tableview gets shifted to the left.
	againandagain	]]
	
	local function onRowTouch( event )
		local row = event.row
		rowi = todot.i - (row.index - 1)

		print(event.phase)
		
		-- If one
		if ( "swipeLeft" == event.phase ) then
			print("isone")
			adt.isswipe = 1
			
			for i = 1, todot.i, 1 do		
				transition.to(dbs[i],{ time=301, x = _W+24, transition=easing.outQuad})
				transition.to(rowtitle[i],{ time=301, x = _W*0.6, transition=easing.outQuad})
			end
			
			transition.to(dbs[rowi],{ time=301, x = _W-22, transition=easing.outQuad})
			transition.to(rowtitle[rowi],{ time=301, x = _W*0.6-24, transition=easing.outQuad})
			print("swipeleftf")
			
		elseif ( "swipeRight" == event.phase) then
			print("isone")
			adt.isswipe = 1
			transition.to(dbs[rowi],{ time=301, x = _W+24, transition=easing.outQuad})
			transition.to(rowtitle[rowi],{ time=301, x = _W*0.6, transition=easing.outQuad})
			print("swiperightf")
		end
		
		-- If two
		if (event.phase == "release") then
			
			print(adt.isswipe .. "adt.isswipe")
			if (adt.isswipe == 0) then
				adt.isswipe = 0
				print("User selected row " .. row.index)
				--titletext.text = rowtitle[row.index].text
				
				transition.to(dbs[rowi],{ time=301, x = _W+22, transition=easing.outQuad})
				
				tbdesc.text = todot["n" .. rowi].desc
				tbtitle.text = todot["n" .. rowi].title
				
				print("User selected row " .. event.row.index)
				transition.to(tableView,{ time=150, x = -(_W*0.5), transition=easing.inBack})
				transition.to(notegroup,{ time=600, x = 0, transition=easing.inOutBack})
				
				-- Cluster one away
				transition.to(backtomain,{ time=301, x = -22, transition=easing.outQuad})
				transition.to(addbtn,{ time=301, x = -22-_W, transition=easing.outQuad})
				transition.to(titletext,{ time=301, x = 0-_W*0.5, transition=easing.outQuad})
				
				transition.to(backtomain,{ time=500, alpha = 0.5})
				transition.to(addbtn,{ time=500, alpha = 0.5})
				transition.to(titletext,{ time=500, alpha = 0.5})
				
				--Cluster 2 come here
				transition.to(backtonotes,{ time=301, x = 22, transition=easing.inQuad})
				transition.to(donebtn,{ time=301, x = _W-22, transition=easing.inQuad})
				transition.to(titletext2,{ time=301, x = _W*0.5, transition=easing.inQuad})
				
			
			elseif adt.isswipe == 1 then
				print("isonehaha")
				adt.isswipe = 0
			end
		end
	end
	
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row
		--=================================================================
		if ( todot.i == 0 ) then
			if( row.index == 1 ) then
				rowtitle[row.index] = display.newText( "No Notes!  Add One!", 100, 200, adt.font, 20 )
				rowtitle[row.index]:setFillColor( adt.textr, adt.textg, adt.textb )
				rowtitle[row.index].x = _W*0.5; rowtitle[row.index].y = row.height/2

				row:insert(rowtitle[row.index])
			end
			
		--=================================================================
		elseif ( todot.i ~= 0 ) then
			local temptodotitle
			print(row.index)
			--print(temptodotitle .. " title of each row")
			

			-- 2015/07/23
			-- The last row appears first
			--[[
				Subtract 1 from row.index
				todot.i minus the row.index

				At the end it would display row one.
			]]
			local temprowid = todot.i - (row.index - 1)
			--local temprowid = row.index
			-- Replacs the string with a shorter one plus three dots at the end if excedds 20 chars
			if string.len(todot["n" .. temprowid].title) > 20 then
				temptodotitle = string.sub(todot["n" .. temprowid].title, 1, 20)
				temptodotitle = temptodotitle .. "..."
			else
				temptodotitle = todot["n" .. temprowid].title
			end
			
			rowtitle[temprowid] = display.newText( temptodotitle , 100, 200, adt.font, 20 )
			rowtitle[temprowid]:setFillColor( adt.textr, adt.textg, adt.textb )
			rowtitle[temprowid].x = _W*0.6; rowtitle[temprowid].y = row.height/2
			
			dbs[temprowid] = widget.newButton
			{
				defaultFile = "images/bbr2.png",
				overFile = "images/bbr2over.png",
				width = 44,
				height = 44,
				noLines = true,
			}
			dbs[temprowid].x = _W+22; dbs[temprowid].y = row.height/2
			dbs[temprowid]:addEventListener( "tap", bbnr)

			-- Short string that shows the date of creation of the note
			rowtitle["n" .. temprowid] = display.newText( date( "%m", todot["n" .. temprowid].rem ) .. "/" .. date( "%d", todot["n" .. temprowid].rem ) , 100, 200, adt.font, 20 )
			rowtitle["n" .. temprowid]:setFillColor( adt.textr, adt.textg, adt.textb )
			rowtitle["n" .. temprowid].x = 40; rowtitle["n" .. temprowid].y = row.height/2
			rowtitle["n" .. temprowid]:setFillColor( adt.btextr, adt.btextg, adt.btextb )
			
			row:insert(rowtitle[temprowid])
			row:insert(rowtitle["n" .. temprowid])
			row:insert(dbs[temprowid])
		end
		--==================================================================
	end
	
	tableView = widget.newTableView
	{
		height = _H-64,
		width = _W,
		Boolean = true,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
		
		backgroundColor = { 0.5, 0.5, 0.5},
		hideBackground = true,
		isLocked = false,
		hideScrollBar = false,
		noLines = false,
		maxVelocity = 0.7,
		friction = 750,
		isBounceEnabled = true,
		scrollBarOptions = 
		{
			sheet = scrollbar,
			topFrame = 1,
			middleFrame = 2,
			bottomFrame = 3
		},
		rowTouchDelay = 5,
		
	}	tableView.y = _H*0.5+32; tableView.x = _W*0.5
	
	populate = function()
		for i = 1, todot.i do
			local isCategory = false
			local rowHeight = 44
			local rowColor = { default = { 0.5, 0.5, 0.5, 0 }, over = { 235/255, 235/255, 235/255 } }
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
	populate()
	--========================================================================================================================
	local bbnt = function()

		native.setKeyboardFocus( nil )
		native.setKeyboardFocus( nil )

		-- Return to Notes Panel full of tables
		rowi = 0
		
		transition.to(tableView,{ time=500, x = _W*0.5, transition=easing.inOutBack})
		transition.to(tableView,{ time=500, y = _H*0.5+32, transition=easing.inOutBack})
		transition.to(notegroup,{ time=250, x = _W, transition=easing.inBack})

		-- Come Here
		transition.to(backtomain,{ time=301, x = 22, transition=easing.inQuad})
		transition.to(addbtn,{ time=301, x = _W-22, transition=easing.inQuad})
		transition.to(titletext,{ time=301, x = _W*0.5, transition=easing.inQuad})
		
		transition.to(backtomain,{ time=500, alpha = 1})
		transition.to(addbtn,{ time=500, alpha = 1})
		transition.to(titletext,{ time=500, alpha = 1})
		
		-- Go Away
		transition.to(backtonotes,{ time=301, x = _W+42, transition=easing.outQuad})
		transition.to(donebtn,{ time=301, x = _W+42, transition=easing.outQuad})
		transition.to(titletext2,{ time=301, x = _W+_W*0.5, transition=easing.outQuad})
		
		donebtn.isVisible = false

		titletext.text = "Notes"
		
		tableView:deleteAllRows()
		populate()
		
		adt.added = 0
		
	end
	backtonotes:addEventListener("tap", bbnt)
	--================================================
	-- Done btn removes the keyboard
	local hidekeys = function()
		donebtn.isVisible = false

		native.setKeyboardFocus( nil )
	end
	
	donebtn:addEventListener("tap", hidekeys)
	--================================================
	local bbadd2 = function()
		local rowm = todot.i+1
		
		todot["n" .. rowm] = {}
		todot["n" .. rowm].title = "Homework"
		todot["n" .. rowm].desc = "Item"
		todot["n" .. rowm].rem = os.time()
		todot.i = todot.i + 1
		
		adt.s(todot, "todot.json")
		tableView:deleteAllRows()
		populate()
		
		local dummytable = {}
		
		dummytable.phase = "release"
		dummytable.row = {}
		dummytable.row.index = todot.i - (rowm - 1)
		
		onRowTouch(dummytable)
	end
	addbtn:addEventListener("tap", bbadd2)
	
	--========================================================================================================================
	local ys = {}
	
	ys.tableView = tableView.y
	ys.titletext = titletext.y
	ys.titletext2 = titletext2.y
	ys.titlebar = titlebar.y
	ys.addbtn = addbtn.y
	ys.backtomain = backtomain.y
	ys.notegroup = notegroup.y
	
	tableView.y = _H+700
	titletext.y = -700
	titletext2.y = -700
	titlebar.y = -700
	addbtn.y = -700
	backtomain.y = -700
	notegroup.y = _H+700
	
	local enters = function()
		transition.to(tableView,{ time=502, y = ys.tableView, transition=easing.inOutExpo})
		transition.to(titletext,{ time=502, y = ys.titletext, transition=easing.inOutExpo})
		transition.to(titletext2,{ time=502, y = ys.titletext, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = ys.titlebar, transition=easing.inOutExpo})
		transition.to(addbtn,{ time=502, y = ys.addbtn, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = ys.backtomain, transition=easing.inOutExpo})
		transition.to(notegroup,{ time=502, y = ys.notegroup, transition=easing.inOutExpo})
	end
	
	local exitsc = function()
		transition.to(tableView,{ time=502, y = _W+700, transition=easing.inOutExpo})
		transition.to(titletext,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(titletext2,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(addbtn,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = -700, transition=easing.inOutExpo})
	end
	
	enters()
	--========================================================================================================================
	local bbnm = function()
		composer.gotoScene("menu", {effect = "fade", time = 200 } )
		--exitsc()
	end
	backtomain:addEventListener("tap", bbnm)
	--========================================================================================================================
	
	sceneGroup:insert(tableView)
	sceneGroup:insert(titlebar)
	sceneGroup:insert(titletext)
	sceneGroup:insert(backtonotes)
	sceneGroup:insert(donebtn)
	sceneGroup:insert(backtomain)
	sceneGroup:insert(addbtn)
	sceneGroup:insert(notegroup)

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

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene