local composer = require( "composer" )
local scene = composer.newScene()

local adt = require("adata")
local widget = require("widget")

local _W = display.contentWidth
local _H = display.contentHeight


-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
	
end

-- pupolate table
local populate

-- Variable to store the rowid of the row tapped
-- For desc and title alike
local rowi = 0

local classes = {}
classes = adt.l("classes.json")

-- "scene:show()"
function scene:show( event )
	composer.removeHidden()

	local sceneGroup = self.view
	local phase = event.phase

if ( phase == "will" ) then

elseif ( phase == "did" ) then
	
	local titlebar = display.newImageRect( "images/topbar.png", _W, 64)
	titlebar.x = _W*0.5; titlebar.y = 32
	
	local titletext = display.newText( "Edit Classes", 100, 200, adt.font, 22 )
	titletext:setFillColor( adt.textr, adt.textg, adt.textb )
	titletext.x = _W*0.5; titletext.y = 42 + adt.ishift
	
	local titletext2 = display.newText( "Editing", 100, 200, adt.font, 22 )
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
	
	-- There's a glitch in which the textboxes flicker for a while before moving to _W.
	-- Delayed the transition of the textboxes to their respective places.
	-- TODO
	local function titleinput( event )
		donebtn.isVisible = true
		if event.phase == "began" then

			print( event.target.text .. " EVENT.TEXT BEGINNING")

			classes[rowi] = event.target.text
			adt.s(classes, "classes.json")

		elseif event.phase == "submitted" then
			print( event.target.text .. " EVENT.TEXT")
			donebtn.isVisible = false
			native.setKeyboardFocus( nil )
		
		elseif event.phase == "editing" then
			print( event.newCharacters )
			print( event.oldText )
			print( event.startPosition )
			print( event.target.text )

			classes[rowi] = event.target.text
			print(classes[rowi] .. "   rowtitle")

			adt.s(classes, "classes.json")
		end
	end
	tbtitle:addEventListener( "userInput", titleinput )
		
	notegroup:insert(tbtitle)
	--========================================================================================================================
	local tableView
	-- Delete buttons, Row title texts
	local rowtitle = {}
	--========================================================================================================================
	
	local function onRowTouch( event )
		local row = event.row
		rowi = row.index
		print(event.phase)
		
		-- If two
		if (event.phase == "release") then
			print("User selected row " .. row.index)
			--titletext.text = rowtitle[row.index].text
			
			if rowi > 8 then
				titletext2.text = "Editing Semester 2 Block " .. rowi - 8
			else
				titletext2.text = "Editing Semester 1 Block " .. rowi
			end

			tbtitle.text = classes[rowi]

			print("User selected row " .. event.row.index)
			transition.to(tableView,{ time=150, x = -(_W*0.5), transition=easing.inBack})
			transition.to(notegroup,{ time=600, x = 0, transition=easing.inOutBack})
			
			-- Cluster one away
			transition.to(backtomain,{ time=301, x = -22, transition=easing.outQuad})
			transition.to(titletext,{ time=301, x = 0-_W*0.5, transition=easing.outQuad})
			
			transition.to(backtomain,{ time=500, alpha = 0.5})
			transition.to(titletext,{ time=500, alpha = 0.5})

			--Cluster 2 come here
			transition.to(backtonotes,{ time=301, x = 22, transition=easing.inQuad})
			transition.to(donebtn,{ time=301, x = _W-22, transition=easing.inQuad})
			transition.to(titletext2,{ time=301, x = _W*0.5, transition=easing.inQuad})
		end
	end
	
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row
		--=================================================================
		local tempclassesitle
		local templabel
		print(row.index)
		--print(tempclassesitle .. " title of each row")
		
		-- Short string to display left of the title, like an index
		if row.index > 8 then
			templabel = "S2 B" .. row.index - 8
		else
			templabel = "S1 B" .. row.index
		end
		
		rowtitle["n" .. row.index] = display.newText( templabel , 100, 200, adt.font, 20 )
		rowtitle["n" .. row.index]:setFillColor( adt.textr, adt.textg, adt.textb )
		rowtitle["n" .. row.index].x = 50; rowtitle["n" .. row.index].y = row.height/2

		-- Replacs the string with a shorter one plus three dots at the end if excedds 20 chars

		if string.len(classes[row.index]) > 15 then
			tempclassesitle = string.sub(classes[row.index], 1, 10)
			tempclassesitle = tempclassesitle .. "..."
		else
			tempclassesitle = classes[row.index]
		end
		
		rowtitle[row.index] = display.newText( tempclassesitle , 100, 200, adt.font, 20 )
		rowtitle[row.index]:setFillColor( adt.textr, adt.textg, adt.textb )
		rowtitle[row.index].x = _W*0.6; rowtitle[row.index].y = row.height/2
		
		row:insert(rowtitle[row.index])
		row:insert(rowtitle["n" .. row.index])
		--==================================================================
		-- The Current Semester is blue while the other is red

		if isformer == 1 then
			-- In the former
			if row.index > 8 then
				-- The latter rows
				rowtitle["n" .. row.index]:setFillColor( adt.rtextr, adt.rtextg, adt.rtextb )
				rowtitle[row.index]:setFillColor( adt.rtextr, adt.rtextg, adt.rtextb )
			else
				-- The former rows
				rowtitle["n" .. row.index]:setFillColor( adt.btextr, adt.btextg, adt.btextb )
				rowtitle[row.index]:setFillColor( adt.btextr, adt.btextg, adt.btextb )
			end
		else
			-- In the latter
			if row.index > 8 then
				-- The latter rows
				rowtitle["n" .. row.index]:setFillColor( adt.btextr, adt.btextg, adt.btextb )
				rowtitle[row.index]:setFillColor( adt.btextr, adt.btextg, adt.btextb )
			else
				-- The former rows
				rowtitle["n" .. row.index]:setFillColor( adt.rtextr, adt.rtextg, adt.rtextb )
				rowtitle[row.index]:setFillColor( adt.rtextr, adt.rtextg, adt.rtextb )
			end
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
		for i = 1,16 do
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
		transition.to(titletext,{ time=301, x = _W*0.5, transition=easing.inQuad})
		
		transition.to(backtomain,{ time=500, alpha = 1})
		transition.to(titletext,{ time=500, alpha = 1})
		
		-- Go Away
		transition.to(backtonotes,{ time=301, x = _W+42, transition=easing.outQuad})
		transition.to(donebtn,{ time=301, x = _W+42, transition=easing.outQuad})
		transition.to(titletext2,{ time=301, x = _W+_W*0.5, transition=easing.outQuad})
		
		donebtn.isVisible = false

		titletext.text = "Edit Classes"
		
		tableView:deleteAllRows()
		populate()
		
		adt.added = 0
		
	end
	backtonotes:addEventListener("tap", bbnt)
	--================================================
	-- Done btn removes the keyboard
	local hidekeys = function()
		donebtn.isVisible = false
		donebtn.isVisible = false

		native.setKeyboardFocus( nil )

		donebtn.isVisible = false
		donebtn.isVisible = false
	end
	
	donebtn:addEventListener("tap", hidekeys)
	--================================================
	
	--========================================================================================================================
	local ys = {}
	
	ys.tableView = tableView.y
	ys.titletext = titletext.y
	ys.titletext2 = titletext2.y
	ys.titlebar = titlebar.y
	ys.backtomain = backtomain.y
	ys.notegroup = notegroup.y
	
	tableView.y = _H+700
	titletext.y = -700
	titletext2.y = -700
	titlebar.y = -700
	backtomain.y = -700
	notegroup.y = _H+700
	
	local enters = function()
		transition.to(tableView,{ time=502, y = ys.tableView, transition=easing.inOutExpo})
		transition.to(titletext,{ time=502, y = ys.titletext, transition=easing.inOutExpo})
		transition.to(titletext2,{ time=502, y = ys.titletext, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = ys.titlebar, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = ys.backtomain, transition=easing.inOutExpo})
		transition.to(notegroup,{ time=502, y = ys.notegroup, transition=easing.inOutExpo})
	end
	
	local exitsc = function()
		transition.to(tableView,{ time=502, y = _W+700, transition=easing.inOutExpo})
		transition.to(titletext,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(titletext2,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = -700, transition=easing.inOutExpo})
	end
	
	enters()
	--========================================================================================================================
	local bbnm = function()
		composer.gotoScene("viewblocks", {effect = "fade", time = 200 } )
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