local composer = require( "composer" )
local scene = composer.newScene()

local adt = require("adata")
local widget = require("widget")

local _W = display.contentWidth
local _H = display.contentHeight

local hw = _W*0.5
local hh = _H*0.5 

local todot = adt.l("todot.json")

-- "scene:create()"
function scene:create( event )
	local group = self.view
end

local date = os.date
local time = os.time()

local blocks = {}
blocks = adt.l("blocks.json")

local events = {}
events = adt.l("events.json")

local classes = {}
classes = adt.l("classes.json")

-- Rowtitle table
local rowtitle = {}

-- "scene:show()"
function scene:show( event )

	local group = self.view
	local phase = event.phase

if ( phase == "will" ) then

elseif ( phase == "did" ) then
	
	local titlebar = display.newImageRect( "images/topbar.png", _W, 64)
	titlebar.x = _W*0.5; titlebar.y = 32
	
	local titletext = display.newText( adt.today, 100, 200, adt.font, 22 )
	titletext:setFillColor( adt.textr, adt.textg, adt.textb )
	titletext.x = _W*0.5; titletext.y = 42 + adt.ishift
	
	local backtomain = widget.newButton
	{
		defaultFile = "images/bbnn.png",
		overFile = "images/bbnnover.png",
		width = 30,
		height = 30,
		noLines = true,
	}
	backtomain.x = 22; backtomain.y = 42;
	
	local editbtn = widget.newButton
	{
		defaultFile = "images/editbtn.png",
		overFile = "images/editbtnover.png",
		width = 25,
		height = 25,
		noLines = true,
	}
	editbtn.x = _W - 22; editbtn.y = 42;
	--========================================================================================================================
	--	2015/07/21
	local function onRowTouch( event )
		local row = event.row
	end
	
	local blocktable = adt.tablegen(blocks["d"][adt.ytoday][adt.mtoday][adt.dtoday])
	local numofblocks = adt.tablelength(blocktable)
	print(numofblocks .. " NUMOFBLOCKS TODAY")
	--[[
		Show blocks for todayl.
		
		blocktable returns a table, e.g. {6, 5, 2, 1}
		blocktable[1] = 6

		classes[blocktable[6]/] = block 6, semester 1 
		
	]]--
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row

		-- No school print no school
		
		local temptext
		local tempicon = blocktable[row.index] .. "."
		
		if blocktable[row.index] == "l" then
			-- Detect if block is lunch
			temptext = "Lunch"
			tempicon = " "
		elseif blocktable[row.index] == "No School Today!" then
			-- No school!
			temptext = "No School Today!"
			tempicon = " "
		elseif blocktable[row.index] == "To Be Announced" then
			-- Block order tba
			temptext = "To Be Announced"
			tempicon = " "
		else
			-- Block is a number
			if ( adt.isinformer == 1 ) then
				temptext = classes[tonumber(blocktable[row.index])]
			else
				temptext = classes[tonumber(blocktable[row.index])+8]
			end
		end
		
		print(temptext .. " " .. row.index)
		
		rowtitle[row.index] = display.newText( temptext, 100, 200, adt.font, 20 )
		rowtitle[row.index]:setFillColor( adt.textr, adt.textg, adt.textb )
		rowtitle[row.index].x = _W*0.5; rowtitle[row.index].y = row.height/2

		rowtitle["n" .. row.index] = display.newText( tempicon , 100, 200, adt.font, 20 )
		rowtitle["n" .. row.index]:setFillColor( adt.textr, adt.textg, adt.textb )
		rowtitle["n" .. row.index].x = 40; rowtitle["n" .. row.index].y = row.height/2
		rowtitle["n" .. row.index]:setFillColor( adt.btextr, adt.btextg, adt.btextb )

		row:insert(rowtitle[row.index])
		row:insert(rowtitle["n" .. row.index])
		
	end
	
	local tableView = widget.newTableView
	{
		height = _H-64,
		width = _W,
		Boolean = true,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
		
		backgroundColor = { 0.5, 0.5, 0.5},
		hideBackground = true,
		isLocked = true,
		hideScrollBar = false,
		noLines = true,
		maxVelocity = 0.7,
		friction = 2,
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
	
	local numofrows = numofblocks
	
	if numofblocks == 0 then
		numofrows = 1
	end
	
	local populate = function()
		for i = 1, numofrows do
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
	local ys = {}
	
	ys.titletext = titletext.y
	ys.titlebar = titlebar.y
	ys.backtomain = backtomain.y
	ys.editbtn = editbtn.y
	ys.tableView = tableView.y
	
	titletext.y = -700
	titlebar.y = -700
	backtomain.y = -700
	editbtn.y = -700
	tableView.y = _H+700
	
	local enters = function()
		transition.to(titletext,{ time=502, y = ys.titletext, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(titlebar,{ time=502, y = ys.titlebar, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(backtomain,{ time=502, y = ys.backtomain, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(editbtn,{ time=502, y = ys.editbtn, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(tableView,{ time=502, y = ys.tableView, transition=easing.inOutExpo, isBackSwipe=false } )
	end
	
	local exitsc = function()
		transition.to(titletext,{ time=502, y = -700, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(titlebar,{ time=502, y = -700, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(backtomain,{ time=502, y = -700, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(editbtn,{ time=502, y = -700, transition=easing.inOutExpo, isBackSwipe=false } )
		transition.to(tableView,{ time=502, y = _H+700, transition=easing.inOutExpo, isBackSwipe=false } )

	end
	
	enters()
	--==========================================
	local bbnm = function()
		composer.gotoScene("menu", {effect = "fade", time = 200, isBackSwipe=false } )
		--exitsc()
	end
	backtomain:addEventListener("tap", bbnm)

	local tonotes = function()	
		composer.gotoScene("editclasses", {effect = "fade", time = 200, isBackSwipe=false } )
	end
	
	editbtn:addEventListener("tap", tonotes)
	--========================================================================================================================
	group:insert(titlebar)
	group:insert(titletext)
	group:insert(backtomain)
	group:insert(editbtn)
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
scene:addEventListener( "swipe", scene )


return scene