local composer = require( "composer" )
local scene = composer.newScene()

local adt = require("adata")
local widget = require("widget")

local _W = display.contentWidth
local _H = display.contentHeight

local hw = _W/2
local hh = _H/2 

local notest = adt.l("notest.hl1")
local todot = adt.l("todot.hl1")
local uclasst = adt.l("uclasst.hl1")

local morningt = adt.l("morningt.hl1")
local luncht = adt.l("luncht.hl1")
local afternoont = adt.l("afternoont.hl1")

local date = os.date
local time = os.time()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
	
end

local webView
-- "scene:show()"
function scene:show( event )
	composer.removeHidden()

	local sceneGroup = self.view
	local phase = event.phase

if ( phase == "will" ) then

elseif ( phase == "did" ) then

	
	local titlebar = display.newImageRect( "images/topbar.png", _W, 64)
	titlebar.x = _W/2; titlebar.y = 32
	
	local titletext = display.newText( "Announcements", 100, 200, adt.font, 22 )
	titletext:setFillColor( adt.textr, adt.textg, adt.textb )
	titletext.x = _W/2; titletext.y = 42 + adt.ishift
	
	local backtomain = widget.newButton
	{
		defaultFile = "images/bbnn.png",
		overFile = "images/bbnnover.png",
		width = 30,
		height = 30,
		noLines = true,
	}
	backtomain.x = 22; backtomain.y = 42;
	
	local yon = display.newText( "Loading..." , hh/2, 0, adt.font, 28 )
	yon.anchor = 0.5; yon.anchor = 0.5
	yon.x = hw ; yon.y = hh
	yon:setFillColor(adt.titler, adt.titleg, adt.titleb)
	
	--=======================================================================================
	--local urltest = "http://thinkingsprout.cloudvent.net/announcements/annie.pdf"
	--local urltest = "http://192.168.1.64/public/annie/annie.pdf"

	local urltest = "http://semiahmoo.geogamez.com/download/annie/annie.pdf"
	
	local url = "https://docs.google.com/viewer?url=" .. urltest .. "&embedded=true"
	--local url = urltest
	--=======================================================================================
	local function webListener( event )
		if event.url then
			print( "You are visiting: " .. event.url )
		end

		if event.type then
			print( "The event.type is " .. event.type ) -- print the type of request
		end

		if event.errorCode then
			native.showAlert( "Error!", event.errorMessage, { "OK"  } )
		end
	end
	
	webView = native.newWebView( hw, hh+32, _W, _H-64 )
	webView:request( url )
	webView:addEventListener( "urlRequest", webListener )
	
	webView.y = 100000
	--=======================================================================================
	print(urltest)
	
	local function networkListener( event )
		if ( event.isError ) then
			yon.isVisible = true
			yon.text = "No Internet Connection"
		else
			print ( "RESPONSE: " .. event.response )
			yon.isVisible = false
			
			print(event.response)
			webView.y = hh+32
		end
	end

	local netreq = network.request( url, "GET", networkListener )
	--========================================================================================================================
	local ys = {}
	
	ys.titletext = titletext.y
	ys.titlebar = titlebar.y
	ys.backtomain = backtomain.y
	ys.yon = yon.y
	
	titletext.y = -700
	titlebar.y = -700
	backtomain.y = -700
	yon.y = -700
	
	local enters = function()
		transition.to(titletext,{ time=502, y = ys.titletext, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = ys.titlebar, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = ys.backtomain, transition=easing.inOutExpo})
		transition.to(yon,{ time=502, y = ys.yon, transition=easing.inOutExpo})
	end
	
	local exitsc = function()
		transition.to(titletext,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(yon,{ time=502, y = _H+700, transition=easing.inOutExpo})
		netreq = nil
		webView:removeSelf()
		webView = nil
	end
	
	enters()
	--========================================================================================================================
	local bbnm = function()
		composer.gotoScene("menu", {effect = "fade", time = 200 } )
		exitsc()
	end
	backtomain:addEventListener("tap", bbnm)
	--========================================================================================================================
	
	sceneGroup:insert(titlebar)
	sceneGroup:insert(titletext)
	sceneGroup:insert(backtomain)
	sceneGroup:insert(yon)

end

end

-- 132593427
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