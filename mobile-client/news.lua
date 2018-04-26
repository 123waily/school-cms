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
	
	local titletext = display.newText( "News", 100, 200, adt.font, 22 )
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
	--=======================================================================================
	webView = native.newWebView( hw, hh+32, _W, _H-64 )
	webView:request( "mobilenews.html", system.DocumentsDirectory )
	
	webView.y = hh+32
	--========================================================================================================================
	local ys = {}
	
	ys.titletext = titletext.y
	ys.titlebar = titlebar.y
	ys.backtomain = backtomain.y
	
	titletext.y = -700
	titlebar.y = -700
	backtomain.y = -700
	
	local enters = function()
		transition.to(titletext,{ time=502, y = ys.titletext, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = ys.titlebar, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = ys.backtomain, transition=easing.inOutExpo})
	end
	
	local exitsc = function()
		transition.to(titletext,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(titlebar,{ time=502, y = -700, transition=easing.inOutExpo})
		transition.to(backtomain,{ time=502, y = -700, transition=easing.inOutExpo})
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