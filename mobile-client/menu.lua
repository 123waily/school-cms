local composer = require( "composer" )
local scene = composer.newScene()

local adt = require("adata")
local widget = require("widget")

local _W = display.contentWidth
local _H = display.contentHeight

local hw = _W*0.5
local hh = _H*0.5 

local notest = adt.l("notest.hl1")
local todot = adt.l("todot.hl1")

local morningt = adt.l("morningt.hl1")
local luncht = adt.l("luncht.hl1")
local afternoont = adt.l("afternoont.hl1")

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
	
end

local date = os.date
local time = os.time()

local blocks = {}
blocks = adt.l("blocks.json")

local events = {}
events = adt.l("events.json")

-- "scene:show()"
function scene:show( event )
	
	--composer.removeHidden()

    local sceneGroup = self.view
    local phase = event.phase

if ( phase == "will" ) then
	composer.removeHidden(true)

elseif ( phase == "did" ) then
print("Menu Scene")
		
	-- For iphone 4 (height 480), the y of st2 should be 70
	local st2y = (70/480) * _H
	
	local st2 = display.newText( adt.today , hh/2, 0, adt.font, 39 )
	st2.anchor = 0.5; st2.anchor = 0.5
	st2.x = hw ; st2.y = st2y
	st2:setFillColor(adt.titler, adt.titleg, adt.titleb)
	
	--========================================================================================================================
	local blockordert = display.newText( "Block Order?" , hh/2, 0, adt.font, 28 )
	blockordert.anchor = 0.5; blockordert.anchor = 0.5
	blockordert.x = hw ; blockordert.y = st2y + 50 + adt.exof + adt.ishift
	blockordert:setFillColor(adt.titler, adt.titleg, adt.titleb)
	
	-- Vuiew the day block order: viewblocksbtn
	local vbbtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = " ",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = _W,
		height = 45,
		labelYOffset = adt.exof + adt.ishift,
	}
	vbbtn.x = hw ; vbbtn.y = st2y + 50
	
	local eventt1 = display.newText( "Holahola" , hh/2, 0, adt.font, 15 )
	eventt1.anchor = 0.5; eventt1.anchor = 0.5
	eventt1.x = hw ; eventt1.y = st2y + 90
	eventt1:setFillColor(adt.titler, adt.titleg, adt.titleb)
	
	local eventt2 = display.newText( "Holahola" , hh/2, 0, adt.font, 15 )
	eventt2.anchor = 0.5; eventt2.anchor = 0.5
	eventt2.x = hw ; eventt2.y = st2y + 90 + 30
	eventt2:setFillColor(adt.titler, adt.titleg, adt.titleb)
	
	local eventt3 = display.newText( "Holahola" , hh/2, 0, adt.font, 15 )
	eventt3.anchor = 0.5; eventt3.anchor = 0.5
	eventt3.x = hw ; eventt3.y = st2y + 90 + 30*2
	eventt3:setFillColor(adt.titler, adt.titleg, adt.titleb)
	
	--========================================================================================================================
	-- Set Block order Text
	--adt.dtoday = "d0409"
	print(adt.ytoday)
	print(adt.mtoday)
	print(adt.dtoday)
	--print(blocks[adt.dtoday][1])
	
	local function displaynoschool()
		blockordert.text = "No School Today!"
		blockordert:setFillColor( adt.rtextr, adt.rtextg, adt.rtextb )
	end
	
	if ( adt.tfblocks( adt.ytodayn, adt.mtodayn, adt.dtodayn ) == 0 ) then
		displaynoschool()
	else
		blockordert.text = adt.bsgen(blocks["d"][adt.ytoday][adt.mtoday][adt.dtoday])
	end
	
	--========================================================================================================================
	-- Set event text to today's event
	
	local function displaynoevent()
		eventt1.text = "No Special Event"
		eventt2.text = " "
		eventt3.text = " "
	end
	
	if ( events["d"][adt.ytoday] == nil ) then
		displaynoevent()
	elseif ( events["d"][adt.ytoday][adt.mtoday] == nil ) then
		displaynoevent()
	elseif ( events["d"][adt.ytoday][adt.mtoday][adt.dtoday] == nil ) then
		displaynoevent()
	else
		-- There is an event
		-- Lua ARRAYS START FROM ONE
		
		if ( events["d"][adt.ytoday][adt.mtoday][adt.dtoday][1] ~= nil ) then
			-- Event one exists
			print("EVENT ONE EXISTS")
			eventt1.text = events["d"][adt.ytoday][adt.mtoday][adt.dtoday][1]
			
			if ( events["d"][adt.ytoday][adt.mtoday][adt.dtoday][2] ~= nil ) then
				-- Event two exists
				eventt2.text = events["d"][adt.ytoday][adt.mtoday][adt.dtoday][2]
				
				if ( events["d"][adt.ytoday][adt.mtoday][adt.dtoday][3] ~= nil ) then
					eventt3.text = events["d"][adt.ytoday][adt.mtoday][adt.dtoday][3]
				else
					eventt3.text = " "
				end
			else
				eventt2.text = " "
				eventt3.text = " "
			end
		end
	end
	
	-- Make text 
	eventt1:setFillColor( adt.btextr, adt.btextg, adt.btextb )
	eventt2:setFillColor( adt.btextr, adt.btextg, adt.btextb )
	eventt3:setFillColor( adt.btextr, adt.btextg, adt.btextb )
	--========================================================================================================================
	--buttonbaseline y
	local bbb = 30
	
	local todobtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = "Notes",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 30,
		labelYOffset = adt.exof + adt.ishift,
	}
	todobtn.x = hw ; todobtn.y = hh + bbb
	
	local anniebtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = "Announcements",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 30,
		labelYOffset = adt.exof + adt.ishift,
	}
	anniebtn.x = hw ; anniebtn.y = hh + 42 + bbb
	
	local newsbtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = "News",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 30,
		labelYOffset = adt.exof + adt.ishift,
	}
	newsbtn.x = hw ; newsbtn.y = hh + 42*3 + bbb
	
	local calbtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = "Calendar",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 30,
		labelYOffset = adt.exof + adt.ishift,
	}
	calbtn.x = hw ; calbtn.y = hh + 42*2 + bbb
	--========================================================================================================================
	-- Bottom Bar
	-- School news + contact Information
	-- At bottom or not?
	local atbottom = false
	
	local uparrow = display.newImageRect( "images/bbnn.png", 30, 30 )
	uparrow.x = hw; uparrow.y = _H-20
	uparrow.rotation = 90
	
	local bottombar = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = " ",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = _W,
		height = 64,
		labelYOffset = adt.exof + adt.ishift,
	}
	bottombar.anchorY = 0
	bottombar.x = hw ; bottombar.y = _H-40
	
	--================================================================================
	-- Bottom Content: School Handbook + Contact Info and about
	
	local semilogo = display.newImageRect( "images/semilogo.png", 100, 98)
	semilogo.x = _W*0.5 ; semilogo.y = _H+700

	-- Generates necessary strings for friday's block order
		local nfstring = adt.nextfriday()

		local blockordernf
		local nfdate = nfstring.y .. "/" .. nfstring.m .. "/" .. nfstring.d

		if ( adt.tfblocks( nfstring.y, nfstring.m, nfstring.d ) == 0 ) then
			blockordernf = "There is no school " .. adt.ton .. "."
		else
			blockordernf = adt.bsgen(blocks["d"][nfstring.y][nfstring.m][nfstring.d])
		end

	-- "This Friday's block order"
	local fridaydesc = display.newText( "Block order of " .. adt.ton .. ", " .. nfdate , hh/2, 0, adt.font, 18 )
	fridaydesc.anchor = 0.5; fridaydesc.anchor = 0.5
	fridaydesc.x = hw ; fridaydesc.y = _H+700
	fridaydesc:setFillColor(adt.titler, adt.titleg, adt.titleb)

	-- 1, 3, 5, 7
	local fridayblockorder = display.newText( blockordernf , hh/2, 0, adt.font, 18 )
	fridayblockorder.anchor = 0.5; fridayblockorder.anchor = 0.5
	fridayblockorder.x = hw ; fridayblockorder.y = _H+700
	fridayblockorder:setFillColor(adt.titler, adt.titleg, adt.titleb)

	--======================================================================
	local handbookbtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = "School Handbook",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 30,
		labelYOffset = adt.exof + adt.ishift,
	}
	handbookbtn.x = _W*0.5 ; handbookbtn.y = _H+700

	local contactbtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = "School Contact",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 30,
		labelYOffset = adt.exof + adt.ishift,
	}
	contactbtn.x = _W*0.5 ; contactbtn.y = _H+700

	local websitebtn = widget.newButton
	{
		defaultFile = "images/topbar.png",
		overFile = "images/topbarover.png",
		font = adt.font,
		fontSize = 15,
		emboss = false,
		label = "School Website",
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 30,
		labelYOffset = adt.exof + adt.ishift,
	}
	websitebtn.x = _W*0.5 ; websitebtn.y = _H+700
	--========================================================================================================================
	local ys = {}
	
	ys.st2 = st2.y
	ys.blockordert = blockordert.y
	ys.vbbtn = vbbtn.y
	ys.eventt1 = eventt1.y
	ys.eventt2 = eventt2.y
	ys.eventt3 = eventt3.y
	ys.todobtn = todobtn.y
	ys.anniebtn = anniebtn.y
	ys.newsbtn = newsbtn.y
	ys.calbtn = calbtn.y

	ys.semilogo = _H*0.75
	ys.fridaydesc = st2y+30
	ys.fridayblockorder = st2y+30*2

	ys.handbookbtn = st2y+60 + 50
	ys.contactbtn = st2y+60 + 50 + 42
	ys.websitebtn = st2y+60 + 50 + 42*2
	
	st2.y = -700
	blockordert.y = -700
	vbbtn.y = -700
	eventt1.y = -700
	eventt2.y = -700
	eventt3.y = -700
	todobtn.y = _H+700
	anniebtn.y = _H+700
	newsbtn.y = _H+700
	calbtn.y = _H+700
	
	local enters = function()
		transition.to(st2,{ time=550, y = ys.st2, transition=easing.inOutExpo})
		transition.to(blockordert,{ time=500, y = ys.blockordert, transition=easing.inOutExpo})
		transition.to(vbbtn,{ time=500, y = ys.vbbtn, transition=easing.inOutExpo})
		transition.to(eventt1,{ time=450, y = ys.eventt1, transition=easing.inOutExpo})
		transition.to(eventt2,{ time=400, y = ys.eventt2, transition=easing.inOutExpo})
		transition.to(eventt3,{ time=300, y = ys.eventt3, transition=easing.inOutExpo})
		transition.to(todobtn,{ time=400, y = ys.todobtn, transition=easing.inOutExpo})
		transition.to(anniebtn,{ time=450, y = ys.anniebtn, transition=easing.inOutExpo})
		transition.to(newsbtn,{ time=550, y = ys.newsbtn, transition=easing.inOutExpo})
		transition.to(calbtn,{ time=500, y = ys.calbtn, transition=easing.inOutExpo})
	end
	
	local exitsc = function()
		transition.to(st2,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(blockordert,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(vbbtn,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(eventt1,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(eventt2,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(eventt3,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(todobtn,{ time=500, y = _H+700, transition=easing.inOutExpo})
		transition.to(anniebtn,{ time=500, y = _H+700, transition=easing.inOutExpo})
		transition.to(newsbtn,{ time=500, y = _H+700, transition=easing.inOutExpo})
		transition.to(calbtn,{ time=500, y = _H+700, transition=easing.inOutExpo})
	end
	
	enters()
	--========================================================================================================================
	local totodo = function()
		exitsc()
		composer.gotoScene("todo", {effect = "fade", time = 200})
	end
	
	todobtn:addEventListener("tap", totodo)
	
	local toannie = function()
		exitsc()
		composer.gotoScene("annie", {effect = "fade", time = 200})
	end
	
	anniebtn:addEventListener("tap", toannie)
	
	local tocal = function()
		exitsc()
		composer.gotoScene("calendar", {effect = "fade", time = 200 } )
	end
	
	calbtn:addEventListener("tap", tocal)
	
	local tonews = function()
		exitsc()
		composer.gotoScene("news", {effect = "fade", time = 200 } )
	end
	
	newsbtn:addEventListener("tap", tonews)
	--==========
	local tovb = function()
		exitsc()
		composer.gotoScene("viewblocks", {effect = "fade", time = 200 } )
	end
	
	vbbtn:addEventListener("tap", tovb)
		
	-- Displays bottom stuff only accessible by the arrow
	
	local tobottom = function()
		if atbottom == true then
		-- Go to top if at bottom
			transition.to(bottombar,{ time=500, y = _H-40, transition=easing.inOutExpo})
			transition.to(uparrow,{ time=500, y = _H-20, transition=easing.inOutExpo})
			uparrow.rotation = 90
			atbottom = false
			
			enters()

			transition.to(semilogo,{ time=500, y = _H+700, transition=easing.inOutExpo})
			transition.to(handbookbtn,{ time=500, y = _H+700, transition=easing.inOutExpo})
			transition.to(contactbtn,{ time=500, y = _H+700, transition=easing.inOutExpo})
			transition.to(websitebtn,{ time=500, y = _H+700, transition=easing.inOutExpo})

			transition.to(fridaydesc,{ time=500, y = _H+700, transition=easing.inOutExpo})
			transition.to(fridayblockorder,{ time=500, y = _H+700, transition=easing.inOutExpo})
			
		elseif atbottom == false then
		-- Go to bototm if at top
			transition.to(bottombar,{ time=500, y = 0, transition=easing.inOutExpo})
			transition.to(uparrow,{ time=500, y = 40, transition=easing.inOutExpo})
			uparrow.rotation = -90
			atbottom = true
			
		transition.to(st2,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(blockordert,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(vbbtn,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(eventt1,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(eventt2,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(eventt3,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(todobtn,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(anniebtn,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(newsbtn,{ time=500, y = -700, transition=easing.inOutExpo})
		transition.to(calbtn,{ time=500, y = -700, transition=easing.inOutExpo})
		
			transition.to(semilogo,{ time=500, y = ys.semilogo, transition=easing.inOutExpo})
			transition.to(handbookbtn,{ time=500, y = ys.handbookbtn, transition=easing.inOutExpo})
			transition.to(contactbtn,{ time=500, y = ys.contactbtn, transition=easing.inOutExpo})
			transition.to(websitebtn,{ time=500, y = ys.websitebtn, transition=easing.inOutExpo})

			transition.to(fridaydesc,{ time=500, y = ys.fridaydesc, transition=easing.inOutExpo})
			transition.to(fridayblockorder,{ time=500, y = ys.fridayblockorder, transition=easing.inOutExpo})

		end
		
	end
	bottombar:addEventListener( "tap", tobottom)
	
	
	local tohandbook = function()
		
	end
		
	handbookbtn:addEventListener("tap", tohandbook)

	local towebsite = function()
		
	end

	websitebtn:addEventListener("tap", towebsite)
	--========================================================================================================================
	sceneGroup:insert(st2)
	sceneGroup:insert(blockordert)
	sceneGroup:insert(vbbtn)
	sceneGroup:insert(eventt1)
	sceneGroup:insert(eventt2)
	sceneGroup:insert(eventt3)
	sceneGroup:insert(todobtn)
	sceneGroup:insert(anniebtn)
	sceneGroup:insert(newsbtn)
	sceneGroup:insert(calbtn)
	sceneGroup:insert(uparrow)
	sceneGroup:insert(bottombar)

	sceneGroup:insert(handbookbtn)
	sceneGroup:insert(contactbtn)
	sceneGroup:insert(fridaydesc)
	sceneGroup:insert(fridayblockorder)
	sceneGroup:insert(semilogo)
	
	adt.backscene = function()
		print("hello")
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

		--composer.removeHidden()
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