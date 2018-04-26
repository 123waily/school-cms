--Buy tokens
--Exactly stuff at center (hw )-(timetokentext.width+15)/3
local _W = display.contentWidth;
local _H = display.contentHeight;
local hw = _W*0.5
local hh = _H*0.5
local qw = _W*0.25
local sfx = require( "sfx" )

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require("widget")

local adt = require("adt")

local gameNetwork = require( "gameNetwork" )

local GGScore = require("GGScore")

local json = require("json")
--===================================================================
-- adtsaveTable

-- adtloadTable

data = {}
data = adt.loadTable("chkftl2.hl1")
--=============================================================================================================================================================
-- CODING BEGINS
-- Called when the scene's view does not exist: 315

local fontsize = 20

function scene:createScene( event )
	local group = self.view
	
	local timetokengroup2 = display.newGroup()
	local obtokengroup2 = display.newGroup()
	
	local bottombar = display.newImageRect(adt.button, _W, 40)
	bottombar.x = hw ; bottombar.y = _H-20
	
	local topbar = display.newImageRect(adt.button, _W, 62)
	topbar.x = hw ; topbar.y = -700
	
	local backbtn = widget.newButton
	{
		defaultFile = adt.backbtn,
		overFile = adt.backbtnover,
		width = 62,
		height = 62,
		noLines = true,
	}
	backbtn.x = 31; backbtn.y = -700;
	
	local title = display.newText( adt.tokenstring, qw, 0, adt.font, adt.ts )
	title.anchor = 0.5; title.anchor = 0.5
	title.x = hw +10; title.y = -700
	title:setFillColor(adt.textr, adt.textg, adt.textb)
	
	local bigtext = display.newText( adt.l.pw, qw, 0, adt.font, 50 )
	bigtext.anchor = 0.5; bigtext.anchor = 0.5
	bigtext.x = hw ; bigtext.y = hh 
	bigtext:setFillColor(adt.textr, adt.textg, adt.textb)
	bigtext.isVisible = false
	--==================================================================
	local centeralignright = hw +80
	local centeralignleft = hw -80
	
	local timetokengroup = display.newGroup()

	local timetokentext = display.newText( data.timetokens, qw, 0, adt.titlefont, adt.bbs )
	timetokentext.anchorX = 0; timetokentext.anchorY = 0.5
	timetokentext:setFillColor(adt.textr, adt.textg, adt.textb)
	
	timetokentext.x = 0; timetokentext.y = _H-21 + adt.tshift
	
	local timetoken = widget.newButton
	{
		defaultFile = adt.timetokenbtn,
		overFile = adt.timetokenbtn,
		width = 30,
		height = 30,
	}
	timetoken.anchorX = 0.5; timetoken.anchorY = 0.5
	timetoken.x = -15; timetoken.y = _H-20
	
	local timetokentap = widget.newButton
	{
		defaultFile = adt.cover,
		overFile = adt.cover,
		width = hw ,
		height = 40,
		onEvent = sfx.click,
	}
	timetokentap.x = qw ; timetokentap.y = _H-20
	timetokentap.isVisible = false
	
	local timetokentap2 = display.newImageRect("images/blank.png", hw , 40)
	timetokentap2.x = qw ; timetokentap2.y = _H-20

	timetokengroup:insert(timetokentext)
	timetokengroup:insert(timetoken)

	timetokengroup.x = hw -((hw -10)/2+timetokentext.width/3)
	--==================================================================
	local obtokengroup = display.newGroup()
	
	local obtokentext = display.newText( data.obtokens, qw, 0, adt.titlefont, adt.bbs )
	obtokentext.anchorX = 0; obtokentext.anchorY = 0.5
	obtokentext:setFillColor(adt.textr, adt.textg, adt.textb)
	obtokentext.x = 0; obtokentext.y = _H-21 + adt.tshift
	
	local obtoken = widget.newButton
	{
		defaultFile = adt.obtokenbtn,
		overFile = adt.obtokenbtn,
		width = 30,
		height = 30,
	}
	obtoken.x = - 15; obtoken.y = _H-20
	
	local obtokentap = widget.newButton
	{
		defaultFile = adt.cover,
		overFile = adt.cover,
		width = hw ,
		height = 40,
		onEvent = sfx.click,
	}
	obtokentap.x = (hw )/2+hw  ; obtokentap.y = _H-20
	obtokentap.isVisible = false
	
	local obtokentap2 = display.newImageRect("images/blank.png", hw , 40)
	obtokentap2.x = (hw )/2+hw  ; obtokentap2.y = _H-20
	
	obtokengroup:insert(obtokentext)
	obtokengroup:insert(obtoken)
	obtokengroup.x = hw +((hw -10)/2-obtokentext.width/3)
--=============================================================================================================================================================
-- Store Stuff

local store = require( "store" )

local appleProductList =
{

	"com.geogamez.dodge.obtokenpack1",
	"com.geogamez.dodge.obtokenpack2",
	"com.geogamez.dodge.obtokenpack3",
	"com.geogamez.dodge.timetokenpack1",
	"com.geogamez.dodge.timetokenpack2",
	"com.geogamez.dodge.timetokenpack3",
	
}

local googleProductList =
{

	"com.geogamez.dodge.obtokenpack1",
	"com.geogamez.dodge.obtokenpack2",
	"com.geogamez.dodge.obtokenpack3",
	"com.geogamez.dodge.timetokenpack1",
	"com.geogamez.dodge.timetokenpack2",
	"com.geogamez.dodge.timetokenpack3",

}

local function purchasetimetokenpack1( event )
    local phase = event.phase
		print("purchasetimetokenpack1")
		store.purchase( {"com.geogamez.dodge.timetokenpack1"} )
		sfx.click()
		timetokengroup2.isVisible = false
		obtokengroup2.isVisible = false
		bigtext.isVisible = true
		backbtn.isVisible = false
		
    if "ended" == phase then
        print( "You pressed and released a button!" )
    end
    return true
end

local function purchasetimetokenpack2( event )
    local phase = event.phase
		print("purchasetimetokenpack2")
		store.purchase( {"com.geogamez.dodge.timetokenpack2"} )
		sfx.click()
		timetokengroup2.isVisible = false
		obtokengroup2.isVisible = false
		bigtext.isVisible = true
		backbtn.isVisible = false
		
    if "ended" == phase then
        print( "You pressed and released a button!" )
    end
    return true
end

local function purchasetimetokenpack3( event )
    local phase = event.phase
		print("purchasetimetokenpack3")
		store.purchase( {"com.geogamez.dodge.timetokenpack3"} )
		sfx.click()
		timetokengroup2.isVisible = false
		obtokengroup2.isVisible = false
		bigtext.isVisible = true
		backbtn.isVisible = false
		
    if "ended" == phase then
        print( "You pressed and released a button!" )
    end
    return true
end

local function purchaseobtokenpack1( event )
    local phase = event.phase
		print("purchaseobtokenpack1")
		store.purchase( {"com.geogamez.dodge.obtokenpack1"} )
		sfx.click()
		timetokengroup2.isVisible = false
		obtokengroup2.isVisible = false
		bigtext.isVisible = true
		backbtn.isVisible = false
		
    if "ended" == phase then
        print( "You pressed and released a button!" )
    end
    return true
end

local function purchaseobtokenpack2( event )
    local phase = event.phase
		print("purchaseobtokenpack2")
		store.purchase( {"com.geogamez.dodge.obtokenpack2"} )
		sfx.click()
		timetokengroup2.isVisible = false
		obtokengroup2.isVisible = false
		bigtext.isVisible = true
		backbtn.isVisible = false
		
    if "ended" == phase then
        print( "You pressed and released a button!" )
    end
    return true
end

local function purchaseobtokenpack3( event )
    local phase = event.phase
		print("purchaseobtokenpack3")
		store.purchase( {"com.geogamez.dodge.obtokenpack3"} )
		sfx.click()
		timetokengroup2.isVisible = false
		obtokengroup2.isVisible = false
		bigtext.isVisible = true
		backbtn.isVisible = false
		
    if "ended" == phase then
        print( "You pressed and released a button!" )
    end
    return true
end
--===================================================================
local isSimulator = "simulator" == system.getInfo("environment")

function showStoreNotAvailableWarning()
	if isSimulator then
		native.showAlert("Notice", "In-app purchases is not supported by the Corona Simulator.", { "OK" } )
	else
		native.showAlert("Notice", "In-app purchases is not supported on this device.", { "OK" } )
	end
end
--===================================================================
local function storeTransaction( event )

	local transaction = event.transaction

	if ( transaction.state == "purchased" ) then

		--handle a successful transaction here
		print( "productIdentifier", transaction.productIdentifier )
		print( "receipt", transaction.receipt )
		print( "signature:", transaction.signature )
		print( "transactionIdentifier", transaction.identifier )
		print( "date", transaction.date )
		
		data.stuffpurchased = true
		adt.saveTable(data, "chkftl2.hl1")
		
		if( transaction.productIdentifier == "com.geogamez.dodge.timetokenpack1" )then
			data.timetokens = data.timetokens + 50
			adt.saveTable( data, "chkftl2.hl1" )
			timetokentext.text = data.timetokens
			
			timetokengroup.x = hw -((hw -10)/2+timetokentext.width/3)
			local alert = native.showAlert( adt.l.ps, "You purchased 50 time tokens.", { "OK" } )
			
		elseif( transaction.productIdentifier == "com.geogamez.dodge.timetokenpack2" )then
			data.timetokens = data.timetokens + 150
			adt.saveTable( data, "chkftl2.hl1" )
			timetokentext.text = data.timetokens
			
			timetokengroup.x = hw -((hw -10)/2+timetokentext.width/3)
			local alert = native.showAlert( adt.l.ps, "You purchased 150 time tokens.", { "OK" } )
			
		elseif( transaction.productIdentifier == "com.geogamez.dodge.timetokenpack3" )then
			data.timetokens = data.timetokens + 500
			adt.saveTable( data, "chkftl2.hl1" )
			timetokentext.text = data.timetokens
			
			timetokengroup.x = hw -((hw -10)/2+timetokentext.width/3)
			local alert = native.showAlert( adt.l.ps, "You purchased 500 time tokens.", { "OK" } )
			
		elseif( transaction.productIdentifier == "com.geogamez.dodge.obtokenpack1" )then
			data.obtokens = data.obtokens + 5000
			adt.saveTable( data, "chkftl2.hl1" )
			obtokentext.text = data.obtokens
			
			obtokengroup.x = hw +((hw -10)/2-obtokentext.width/3)
			local alert = native.showAlert( adt.l.ps, "You purchased 5000 obstacle tokens.", { "OK" } )
			
		elseif( transaction.productIdentifier == "com.geogamez.dodge.obtokenpack2" )then
			data.obtokens = data.obtokens + 15000
			adt.saveTable( data, "chkftl2.hl1" )
			obtokentext.text = data.obtokens
			
			obtokengroup.x = hw +((hw -10)/2-obtokentext.width/3)
			local alert = native.showAlert( adt.l.ps, "You purchased 15000 obstacle tokens.", { "OK" } )
			
		elseif( transaction.productIdentifier == "com.geogamez.dodge.obtokenpack3" )then
			data.obtokens = data.obtokens + 50000
			adt.saveTable( data, "chkftl2.hl1" )
			obtokentext.text = data.obtokens
			
			obtokengroup.x = hw +((hw -10)/2-obtokentext.width/3)
			local alert = native.showAlert( adt.l.ps, "You purchased 50000 obstacle tokens.", { "OK" } )
		end
		
		timetokengroup2.isVisible = true
		obtokengroup2.isVisible = true
		bigtext.isVisible = false
		backbtn.isVisible = true

	elseif ( transaction.state == "cancelled" ) then

		local alert = native.showAlert( "Purhase Cancelled!", adt.l.pc, { "OK" } )
		
		timetokengroup2.isVisible = true
		obtokengroup2.isVisible = true
		bigtext.isVisible = false
		backbtn.isVisible = true

	elseif ( transaction.state == "failed" ) then

		local alert = native.showAlert( "Purhase Failed!", adt.l.pf, { "OK" } )
		
		timetokengroup2.isVisible = true
		obtokengroup2.isVisible = true
		bigtext.isVisible = false
		backbtn.isVisible = true

	end

	--tell the store that the transaction is complete!
	--if you're providing downloadable content, do not call this until the download has completed
	store.finishTransaction( event.transaction )

end
--===================================================================
function loadProductsCallback( event )
	-- Debug info for testing
	print("In loadProductsCallback()")
	print("event, event.name", event, event.name)
	print(event.products)
	print("#event.products", #event.products)
	io.flush() -- remove for production

	-- save for later use
	validProducts = event.products
	invalidProducts = event.invalidProducts	
end
--===================================================================
local currentProductList = nil

-- Connect to store at startup, if available.
if store.availableStores.apple then
	currentProductList = appleProductList
	store.init("apple", storeTransaction)
	print("Using Apple's in-app purchase system.")
	
elseif store.availableStores.google then
	currentProductList = googleProductList
	store.init("google", storeTransaction)
	print("Using Google's Android In-App Billing system.")
	
else
	print("In-app purchases is not supported on this system/device.")
end

collectgarbage()
--===================================================================
local function setupstore()
	if ( store.isActive ) then

		if ( store.canLoadProducts ) then
			store.loadProducts( currentProductList, loadProductsCallback )
		else
			print("booo")
		end

	end
end
timer.performWithDelay(200, setupstore)

--=============================================================================================================================================================
	local obbutton1tap, obbutton2tap, obbutton3tap, obbutton4tap
	
	 -- Listen for tableView events
	local function tableViewListener( event )
		local phase = event.phase
		local row = event.target
	end

	-- Handle row rendering
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row

		if( row.index == 1 )then
		
			local upgrade = display.newText(row, adt.l.stor, 12, 0, adt.font, 18 )
			upgrade.anchorX = 0.5
			upgrade.x = hw 
			upgrade.y = row.height * 0.35 + adt.ishift
			upgrade:setFillColor( adt.textr, adt.textg, adt.textb )
			
		elseif( row.index == 2 )then
		
			local upgrade = display.newText(row, adt.l.stbm, 12, 0, adt.font, 18 )
			upgrade.anchorX = 0.5
			upgrade.x = hw +5
			upgrade.y = row.height * 0.4 + adt.ishift
			upgrade:setFillColor( adt.textr, adt.textg, adt.textb )

		elseif( row.index == 3 )then
		

		end
		
	end

	-- Create a tableView
	local tableView = widget.newTableView
	{
		top = 50,
		height = 288,
		Boolean = true,
		listener = tableViewListener,
		onRowRender = onRowRender,
		backgroundColor = { adt.bkgr, adt.bkgg, adt.bkgb},
		hideBackground = true,
		hideScrollBar = true,
		noLines = true,
		isLocked = true,
		
	}	tableView.y = -700

	-- Create rows
	for i = 1, 100 do
		if i <= 2 then
			local isCategory = false
			local rowHeight = 25
					local rowColor = { default = { 255, 255, 255, 0 } }
			
			-- Insert the row into the tableView
			tableView:insertRow
			{
				isCategory = isCategory,
				rowHeight = rowHeight,
				rowColor = rowColor,
				onRender = onRowRender,
			}
		elseif(i >= 3 and i < 4)then
			local isCategory = false
			local rowHeight = 70
					local rowColor = { default = { 255, 255, 255, 0 } }
			
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
	
	obtokengroup2:insert( tableView )
	--==================================================================
	local timebutton1tap, timebutton2tap, timebutton3tap, timebutton4tap
	
	 -- Listen for tableView2 events
	local function tableView2Listener( event )
		local phase = event.phase
		local row = event.target
	end

	-- Handle row rendering
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row

		if( row.index == 1 )then

			local upgrade = display.newText(row, adt.l.sttr, 12, 0, adt.font, 18 )
			upgrade.anchorX = 0.5
			upgrade.x = hw 
			upgrade.y = row.height * 0.35 + adt.ishift
			upgrade:setFillColor( adt.textr, adt.textg, adt.textb )

		elseif( row.index == 2 )then
		
			local upgrade = display.newText(row, adt.l.stbm, 12, 0, adt.font, 18 )
			upgrade.anchorX = 0.5
			upgrade.x = hw 
			upgrade.y = row.height * 0.35 + adt.ishift
			upgrade:setFillColor( adt.textr, adt.textg, adt.textb )
			
		elseif( row.index == 3 )then

end
		
	end

	-- Create a tableView2
	local tableView2 = widget.newTableView
	{
		top = 50,
		height = 288,
		Boolean = true,
		listener = tableView2Listener,
		onRowRender = onRowRender,
		backgroundColor = { adt.bkgr, adt.bkgg, adt.bkgb},
		hideBackground = true,
		isBounceEnabled = false,
		hideScrollBar = true,
		noLines = true,
		isLocked = true,
		
	}	tableView2.y = -700

	-- Create rows
	for i = 1, 100 do
		if i <= 2 then
			local isCategory = false
			local rowHeight = 25
					local rowColor = { default = { 255, 255, 255, 0 } }
			
			-- Insert the row into the tableView
			tableView2:insertRow
			{
				isCategory = isCategory,
				rowHeight = rowHeight,
				rowColor = rowColor,
				onRender = onRowRender,
			}
		elseif(i >= 3 and i < 4)then
			local isCategory = false
			local rowHeight = 70
			local rowColor = { default = { 255, 255, 255, 0 } }
			
			-- Insert the row into the tableView
			tableView2:insertRow
			{
				isCategory = isCategory,
				rowHeight = rowHeight,
				rowColor = rowColor,
				onRender = onRowRender,
			}
		end
	end
	
	--=============================================================================================================================================================	
	local buttonheight = hh  - 10
	local adlocation = buttonheight + 57
	
	if (data.stuffpurchased == false) then

	elseif (data.stuffpurchased == true) then
		buttonheight = hh  + 5
		adlocation = buttonheight + 65
	end
	
	
	local timetokengroupbtns = display.newGroup();
	timetokengroupbtns.y = _H+700

	local timerightlargebtn = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.button,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	timerightlargebtn.x = _W*0.8; timerightlargebtn.y = buttonheight 
	
	local timerightlargelabel = display.newText("500" , 12, 0, adt.titlefont, fontsize)
	timerightlargelabel.anchorX = 0.5
	timerightlargelabel.x = _W*0.8+5; timerightlargelabel.y = buttonheight + adt.ishift
	timerightlargelabel:setFillColor(adt.textr, adt.textg, adt.textb)
	
	local timerighticon = widget.newButton
	{
		defaultFile = adt.timetokenbtn,
		overFile = adt.timetokenbtn,
		width = 30,
		height = 30,
	}
	timerighticon.anchorX = 0.5; timerighticon.anchorY = 0.5
	timerighticon.x = _W*0.8-40; timerighticon.y = buttonheight;
	
	local timerightlargebtn2 = widget.newButton
	{
		defaultFile = "images/blank.png",
		overFile = adt.cover,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	timerightlargebtn2.x = _W*0.8; timerightlargebtn2.y = buttonheight 
	timerightlargebtn2:addEventListener("tap", purchasetimetokenpack3)
	
	timetokengroupbtns:insert(timerightlargebtn)
	timetokengroupbtns:insert(timerightlargelabel)
	timetokengroupbtns:insert(timerighticon)
	timetokengroupbtns:insert(timerightlargebtn2)
	--==================================================================
	local timecenterlargebtn = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.button,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	timecenterlargebtn.x = hw ; timecenterlargebtn.y = buttonheight 
	
	local timecenterlargelabel = display.newText("150" , 12, 0, adt.titlefont, fontsize)
	timecenterlargelabel.anchorX = 0.5
	timecenterlargelabel.x = hw +5; timecenterlargelabel.y = buttonheight + adt.ishift
	timecenterlargelabel:setFillColor(adt.textr, adt.textg, adt.textb)
	
	local timecentericon = widget.newButton
	{
		defaultFile = adt.timetokenbtn,
		overFile = adt.timetokenbtn,
		width = 30,
		height = 30,
	}
	timecentericon.anchorX = 0.5; timecentericon.anchorY = 0.5
	timecentericon.x = hw -40; timecentericon.y = buttonheight;
	
	local timecenterlargebtn2 = widget.newButton
	{
		defaultFile = "images/blank.png",
		overFile = adt.cover,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	timecenterlargebtn2.x = hw ; timecenterlargebtn2.y = buttonheight 
	timecenterlargebtn2:addEventListener("tap", purchasetimetokenpack2)
	
	timetokengroupbtns:insert(timecenterlargebtn)
	timetokengroupbtns:insert(timecenterlargelabel)
	timetokengroupbtns:insert(timecentericon)
	timetokengroupbtns:insert(timecenterlargebtn2)
	
	local adstatement = display.newText( adt.l.stra, 14, 0, adt.font, 18 )
	adstatement.anchorX = 0.5
	adstatement.x = hw 
	adstatement.y = hh +90 + adt.ishift
	adstatement:setFillColor( adt.textr, adt.textg, adt.textb )
	
	timetokengroup2:insert( tableView2 )
	timetokengroup2:insert( timetokengroupbtns )
	timetokengroupbtns:insert( adstatement )
	--==================================================================
	local timeleftlargebtn = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.button,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	timeleftlargebtn.x = _W*0.2; timeleftlargebtn.y = buttonheight 
	
	local timeleftlargelabel = display.newText("50" , 12, 0, adt.titlefont, fontsize)
	timeleftlargelabel.anchorX = 0.5
	timeleftlargelabel.x = _W*0.2+5; timeleftlargelabel.y = buttonheight + adt.ishift
	timeleftlargelabel:setFillColor(adt.textr, adt.textg, adt.textb)
	
	local timelefticon = widget.newButton
	{
		defaultFile = adt.timetokenbtn,
		overFile = adt.timetokenbtn,
		width = 30,
		height = 30,
	}
	timelefticon.anchorX = 0.5; timelefticon.anchorY = 0.5
	timelefticon.x = _W*0.2-40; timelefticon.y = buttonheight;
	
	local timeleftlargebtn2 = widget.newButton
	{
		defaultFile = "images/blank.png",
		overFile = adt.cover,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	timeleftlargebtn2.x = _W*0.2; timeleftlargebtn2.y = buttonheight
	timeleftlargebtn2:addEventListener("tap", purchasetimetokenpack1)
	
	local advertisement = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.buttonover,
		font = adt.font,
		fontSize = fontsize,
		label = adt.l.ftt,
		labelYOffset = adt.exof + adt.ishift,
		emboss = false,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 142,
		height = 40,
	}	advertisement.x = hw ; advertisement.y = adlocation
	
	timetokengroupbtns:insert(timeleftlargebtn)
	timetokengroupbtns:insert(timeleftlargelabel)
	timetokengroupbtns:insert(timelefticon)
	timetokengroupbtns:insert(timeleftlargebtn2)
	timetokengroupbtns:insert(advertisement)
	--=============================================================================================================================================================
	local obtokengroupbtns = display.newGroup();
	obtokengroupbtns.y = _H+700

	local obrightlargebtn = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.button,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	obrightlargebtn.x = _W*0.8; obrightlargebtn.y = buttonheight 
	
	local obrightlargelabel = display.newText("50000" , 12, 0, adt.titlefont, fontsize)
	obrightlargelabel.anchorX = 0.5
	obrightlargelabel.x = _W*0.8+13; obrightlargelabel.y = buttonheight + adt.ishift
	obrightlargelabel:setFillColor(adt.textr, adt.textg, adt.textb)
	
	local obrighticon = widget.newButton
	{
		defaultFile = adt.obtokenbtn,
		overFile = adt.obtokenbtn,
		width = 30,
		height = 30,
	}
	obrighticon.anchorX = 0.5; obrighticon.anchorY = 0.5
	obrighticon.x = _W*0.8-40; obrighticon.y = buttonheight;
	
	local obrightlargebtn2 = widget.newButton
	{
		defaultFile = "images/blank.png",
		overFile = adt.cover,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	obrightlargebtn2.x = _W*0.8; obrightlargebtn2.y = buttonheight 
	obrightlargebtn2:addEventListener("tap", purchaseobtokenpack3)
	
	local adstatementa = display.newText( adt.l.stra, 14, 0, adt.font, 18 )
	adstatementa.anchorX = 0.5
	adstatementa.x = hw 
	adstatementa.y = hh +90 + adt.ishift
	adstatementa:setFillColor( adt.textr, adt.textg, adt.textb )
	
	local advertisementa = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.buttonover,
		font = adt.font,
		fontSize = fontsize,
		emboss = false,
		label = adt.l.ftt,
		labelYOffset = adt.exof + adt.ishift,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 142,
		height = 40,
	}	advertisementa.x = hw ; advertisementa.y = adlocation
	
	obtokengroupbtns:insert(obrightlargebtn)
	obtokengroupbtns:insert(obrightlargelabel)
	obtokengroupbtns:insert(obrighticon)
	obtokengroupbtns:insert(obrightlargebtn2)
	obtokengroupbtns:insert(adstatementa)
	obtokengroupbtns:insert(advertisementa)
	--==================================================================
	local obcenterlargebtn = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.button,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	obcenterlargebtn.x = hw ; obcenterlargebtn.y = buttonheight 
	
	local obcenterlargelabel = display.newText("15000" , 12, 0, adt.titlefont, fontsize)
	obcenterlargelabel.anchorX = 0.5
	obcenterlargelabel.x = hw +13; obcenterlargelabel.y = buttonheight + adt.ishift
	obcenterlargelabel:setFillColor(adt.textr, adt.textg, adt.textb)
	
	local obcentericon = widget.newButton
	{
		defaultFile = adt.obtokenbtn,
		overFile = adt.obtokenbtn,
		width = 30,
		height = 30,
	}
	obcentericon.anchorX = 0.5; obcentericon.anchorY = 0.5
	obcentericon.x = hw -40; obcentericon.y = buttonheight;
	
	local obcenterlargebtn2 = widget.newButton
	{
		defaultFile = "images/blank.png",
		overFile = adt.cover,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	obcenterlargebtn2.x = hw ; obcenterlargebtn2.y = buttonheight 
	obcenterlargebtn2:addEventListener("tap", purchaseobtokenpack2)
	
	obtokengroupbtns:insert(obcenterlargebtn)
	obtokengroupbtns:insert(obcenterlargelabel)
	obtokengroupbtns:insert(obcentericon)
	obtokengroupbtns:insert(obcenterlargebtn2)
	
	obtokengroup2:insert( obtokengroupbtns )
	--==================================================================
	local obleftlargebtn = widget.newButton
	{
		defaultFile = adt.button,
		overFile = adt.button,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	obleftlargebtn.x = _W*0.2; obleftlargebtn.y = buttonheight 
	
	local obleftlargelabel = display.newText("5000" , 12, 0, adt.titlefont, fontsize)
	obleftlargelabel.anchorX = 0.5
	obleftlargelabel.x = _W*0.2+13; obleftlargelabel.y = buttonheight + adt.ishift
	obleftlargelabel:setFillColor(adt.textr, adt.textg, adt.textb)
	
	local oblefticon = widget.newButton
	{
		defaultFile = adt.obtokenbtn,
		overFile = adt.obtokenbtn,
		width = 30,
		height = 30,
	}
	oblefticon.anchorX = 0.5; oblefticon.anchorY = 0.5
	oblefticon.x = _W*0.2-40; oblefticon.y = buttonheight;
	
	local obleftlargebtn2 = widget.newButton
	{
		defaultFile = "images/blank.png",
		overFile = adt.cover,
		font = adt.font,
		fontSize = fontsize,
		labelColor = { default = {adt.textr, adt.textg, adt.textb}, over = {adt.textoverr, adt.textoverg, adt.textoverb}},
		width = 120,
		height = 40,
	}	obleftlargebtn2.x = _W*0.2; obleftlargebtn2.y = buttonheight 
	obleftlargebtn2:addEventListener("tap", purchaseobtokenpack1)
	
	obtokengroupbtns:insert(obleftlargebtn)
	obtokengroupbtns:insert(obleftlargelabel)
	obtokengroupbtns:insert(oblefticon)
	obtokengroupbtns:insert(obleftlargebtn2)
	--=============================================================================================================================================================	
	local timestuffisvisible = function()
		transition.to(timetokengroup2,{ time=250, x=0 , transition=easing.inOutExpo})
		transition.to(obtokengroup2,{ time=250, x=_W+700 , transition=easing.inOutExpo})
		timetokentap.isVisible = true
		timetokentap2.isVisible = false
		obtokentap.isVisible = false
		obtokentap2.isVisible = true
		adt.option = 0
		print("timestiffisvisible")
	end

	local timestuffisvisible2 = function()
		sfx.click()
		transition.to(timetokengroup2,{ time=250, x=0 , transition=easing.inOutExpo})
		transition.to(obtokengroup2,{ time=250, x=_W+700 , transition=easing.inOutExpo})
		timetokentap.isVisible = true
		timetokentap2.isVisible = false
		obtokentap.isVisible = false
		obtokentap2.isVisible = true
		adt.option = 0
		print("timestiffisvisible")
	end
	
	local obstuffisvisible = function()	
		transition.to(timetokengroup2,{ time=250, x=-700 , transition=easing.inOutExpo})
		transition.to(obtokengroup2,{ time=250, x=0 , transition=easing.inOutExpo})
		obtokentap.isVisible = true
		obtokentap2.isVisible = false
		timetokentap.isVisible = false
		timetokentap2.isVisible = true
		adt.option = 1
		print("obstiffisvisible")
	end

	local obstuffisvisible2 = function()
		sfx.click()
		transition.to(timetokengroup2,{ time=250, x=-700 , transition=easing.inOutExpo})
		transition.to(obtokengroup2,{ time=250, x=0 , transition=easing.inOutExpo})
		obtokentap.isVisible = true
		obtokentap2.isVisible = false
		timetokentap.isVisible = false
		timetokentap2.isVisible = true
		adt.option = 1
		print("obstiffisvisible")
	end

	print(adt.option)
	local function checkthings()
		if( adt.option == 0 )then
			adt.option = 0
			timestuffisvisible();
		elseif( adt.option == 1 )then
			adt.option = 1
			obstuffisvisible();
		else
			adt.option = 0
			timestuffisvisible();
		end
	end
	checkthings();
	
	obtokentap2:addEventListener("tap", obstuffisvisible2)
	timetokentap2:addEventListener("tap", timestuffisvisible2)
	
	-- Ad Statement visibility
	
	if (data.stuffpurchased == false) then
		adstatement.isVisible = true
		adstatementa.isVisible = true
	elseif (data.stuffpurchased == true) then
		adstatement.isVisible = false
		adstatementa.isVisible = false
	end
	--==================================================================
	local togame = function()
		transition.to(bottombar,{ time=400, y= _H-20 , transition=easing.inOutExpo})
		transition.to(topbar,{ time=400, y= 31 , transition=easing.inOutExpo})
		transition.to(tableView,{ time=700, y= hh +50 , transition=easing.inOutExpo})
		transition.to(tableView2,{ time=700, y= hh +50 , transition=easing.inOutExpo})
		transition.to(timetokengroupbtns,{ time=700, y= 0, transition=easing.inOutExpo})
		transition.to(obtokengroupbtns,{ time=700, y= 0, transition=easing.inOutExpo})
		transition.to(backbtn,{ time=400, y= 31 , transition=easing.inOutExpo})
		transition.to(title,{ time=400, y= 28 + adt.ishift , transition=easing.inOutExpo})
	end
	togame();
	
	local exitscene = function()
		sfx.click()
		transition.to(bottombar,{ time=700, y= _H+700 , transition=easing.inOutExpo})
		transition.to(tableView,{ time=700, y= _H+700 , transition=easing.outBounce})
		transition.to(tableView2,{ time=700, y= _H+700 , transition=easing.outBounce})
		transition.to(timetokengroupbtns,{ time=700, y= _H+700 , transition=easing.outBounce})
		transition.to(obtokengroupbtns,{ time=700, y= _H+700 , transition=easing.outBounce})
		transition.to(timetoken,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(obtoken,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(timetokentext,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(obtokentext,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(timetokentap,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(timetokentap2,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(obtokentap,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(obtokentap2,{ time=200, y= _H+700 , transition=easing.inOutExpo})
		transition.to(topbar,{ time=700, y= -700 , transition=easing.outBounce})
		transition.to(backbtn,{ time=700, y= -700 , transition=easing.outBounce})
		transition.to(title,{ time=700, y= -700 , transition=easing.outBounce})
		
		transition.to(bigtext,{ time=700, y= _H+700 , transition=easing.outBounce})
	end
	
	local tomenu = function()
		sfx.click()
		adt.tokenstring = adt.l.stt
		storyboard.gotoScene( "buystuff")
	end
	backbtn:addEventListener("tap", tomenu)
	
	local function advertisementaction()
		exitscene();
		storyboard.gotoScene( "freetokens", "fade", 400 )
	end
	advertisement:addEventListener( "tap", advertisementaction )
	advertisementa:addEventListener( "tap", advertisementaction )
	
	adt.backscene = function()
		sfx.click()
		adt.tokenstring = adt.l.stt
		adt.backscene = nil
		storyboard.gotoScene( "buystuff")
	end
	--==================================================================
	group:insert(obtokengroup2)
	group:insert(timetokengroup2)
	group:insert(bottombar)
	group:insert(topbar)
	group:insert(backbtn)
 	group:insert(title)
	group:insert(timetokengroup)
	group:insert(obtokengroup)
	group:insert(timetokentap)
	group:insert(timetokentap2)
	group:insert(obtokentap)
	group:insert(obtokentap2)
	group:insert(bigtext)
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	local prior_scene = storyboard.getPrevious()
	storyboard.purgeScene( prior_scene )	
	print("buytokens");
	
	storyboard.returnTo = "buystuff"
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	storyboard.purgeAll() 
	print(adt.option)
	
	storyboard.prevscene = "buytokens"

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	

	
end

--===============================================================================

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene