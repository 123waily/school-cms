-- This is push notifications
local notifications = require( "plugin.notifications" )
notifications.registerForPushNotifications()

--===================================================================================================
local composer = require("composer")
composer.isDebug = true -- uncomment to show the swipe detection bar
composer.recycleOnSceneChange = true
local _W = display.contentWidth
local _H = display.contentHeight

local hw = _W*0.5
local hh = _H*0.5 

local adt = require("adata")

local widget = require "widget"
widget.setTheme( "widget_theme_ios7" )

--===================================================================================================
-- OneSignal Notifications
local apikey = "708df132-1ca3-11e5-9ed6-ef6ba6b9864e"
if ( platform == "Android" ) then
    apikey = "708df132-1ca3-11e5-9ed6-ef6ba6b9864e"
elseif ( platform == "iPhone OS" ) then
	apikey = "708df132-1ca3-11e5-9ed6-ef6ba6b9864e"
end

-- This function gets called when the user opens a notification or one is received when the app is open and active.
-- Change the code below to fit your app's needs.
function DidReceiveRemoteNotification(message, additionalData, isActive)
    if (additionalData) then
        if (additionalData.discount) then
            native.showAlert( "Discount!", message, { "OK" } )
            -- Take user to your app store
        elseif (additionalData.actionSelected) then -- Interactive notification button pressed
            native.showAlert("Button Pressed!", "ButtonID:" .. additionalData.actionSelected, { "OK"} )
        end
    else
        native.showAlert("OneSignal Message", message, { "OK" } )
    end
end

local OneSignal = require("plugin.OneSignal")
OneSignal.Init(apikey, "256367913383", DidReceiveRemoteNotification)
--===================================================================================================
-- Set default background color (white)
display.setDefault( "background", 255/255, 255/255, 255/255 )
display.setStatusBar( display.DarkStatusBar )

-- black text
adt.textr = 50/255
adt.textg = 50/255
adt.textb = 50/255

-- Blue text
adt.btextr = 0/255
adt.btextg = 122/255
adt.btextb = 255/255

-- Red text
adt.rtextr = 255/255
adt.rtextg = 59/255
adt.rtextb = 48/255

adt.btn = "images/topbar.png"
adt.btnover = "images/topbarover.png"
--===================================================================================================
-- Font display issues
if "Win" == system.getInfo( "platformName" ) then
	adt.font = "Josefin Sans"
	adt.ishift = 0	
	adt.exof = -1
	
elseif "Android" == system.getInfo( "platformName" ) then
	adt.font = "Josefin Sans"
	adt.ishift = 0
	adt.exof = -1

elseif "iPhone OS" == system.getInfo( "platformName" )then
	adt.font = "Josefin Sans"
	adt.ishift = 3
	adt.exof = -1

elseif "Mac OS X" == system.getInfo( "platformName" )then
	adt.font = "Josefin Sans"
	adt.ishift = 0
	adt.exof = -1

end
--===================================================================================================
-- File functions
local json = require("json")

-- Reading and Writing a file with encoded JSON
adt.s = function(t, filename)
	local path = system.pathForFile( filename, system.DocumentsDirectory)
	local file = io.open(path, "w")
	if file then
		local contents = json.encode(t)
		
		file:write( contents )
		io.close( file )
		return true
	else
		return false
	end
end

adt.l = function(filename)
	local path = system.pathForFile( filename, system.DocumentsDirectory)
	local contents = ""
	local myTable = {}
	local file = io.open( path, "r" )
	if file then
		local contents = file:read( "*a" )
		
		myTable = json.decode(contents);
		io.close( file )
		return myTable 
	end
	return nil
end

-- Reading of a file with a string for md5
adt.lws = function(filename)
	local path = system.pathForFile( filename, system.DocumentsDirectory)
	local contents = ""
	local file = io.open( path, "r" )
	if file then
		local contents = file:read( "*a" )
		
		io.close( file )
		return contents 
	end
	return nil
end
--===================================================================================================
local date = os.date
local time = os.time()

-- Today's string
-- Displays in the format of "Friday, 12/21"
adt.today = date( "%A", time ) .. ", " .. date( "%m", time ) .. "/" ..  date( "%d", time )

-- Today's string
-- http://www.lua.org/pil/22.1.html
--[[
adt.ytoday = tostring(date( "%Y", time ))
adt.mtoday = tostring(date( "%m", time ))
adt.dtoday = tostring(date( "%d", time ))]]--

adt.ytoday = tostring(date( "%Y", time ))
adt.mtoday = tostring(date( "%m", time ))
adt.dtoday = tostring(date( "%d", time ))

adt.ytodayn = tonumber(date( "%Y", time ))
adt.mtodayn = tonumber(date( "%m", time ))
adt.dtodayn = tonumber(date( "%d", time ))

-- Add leading zeroes if the string length for m and d is one
if ( string.len(adt.mtoday) == 1 ) then
	adt.mtoday = "0" .. adt.mtoday
end

if ( string.len(adt.dtoday) == 1 ) then
	adt.dtoday = "0" .. adt.dtoday
end

-- Detects whether the user is in the Former or the Latter half of the school year
-- Former = 8 - 12, Latter = 1 - 7
adt.isinformer = 1
if ( adt.mtodayn > 7) then
	print("Semester 1")
	adt.isinformer = 1
else
	print("Semester 2")
	adt.isinformer = 0
end

-- Takes the month number, returns the according group for calendar
-- o8 to 1
-- 09 to 2
adt.gengroupnum = function(month)
	if ( month  == 8 ) then
		return 1
	elseif ( month == 9 ) then
		return 2
	elseif ( month == 10 ) then
		return 3
	elseif ( month == 11 ) then
		return 4
	elseif ( month == 12 ) then
		return 5
	elseif ( month == 1 ) then
		return 6
	elseif ( month == 2 ) then
		return 7
	elseif ( month == 3 ) then
		return 8
	elseif ( month == 4 ) then
		return 9
	elseif ( month == 5 ) then
		return 10
	elseif ( month == 6 ) then
		return 11
	elseif ( month == 7 ) then
		return 12
	end
end

-- Takes the group number, returns the according month for calendar
-- 1 to 8
-- 2 to 9
adt.genmonthnum = function(month)
	if ( month  == 1 ) then
		return 8
	elseif ( month == 2 ) then
		return 9
	elseif ( month == 3 ) then
		return 10
	elseif ( month == 4 ) then
		return 11
	elseif ( month == 5 ) then
		return 12
	elseif ( month == 6 ) then
		return 1
	elseif ( month == 7 ) then
		return 2
	elseif ( month == 8 ) then
		return 3
	elseif ( month == 9 ) then
		return 4
	elseif ( month == 10 ) then
		return 5
	elseif ( month == 11 ) then
		return 6
	elseif ( month == 12 ) then
		return 7
	end
end
--================================================================================================
-- Returns yymmdd of nearest Friday
-- For "Friday" button in menu
-- If Friday get today
-- If Saturday add 6 days etc

-- Text that shows "This Friday" or "Next Friday"
adt.ton = "This Friday"

local function get_day_of_week(dd, mm, yy)
	dw=os.date('*t',os.time{year=yy,month=mm,day=dd})['wday']
	return ({7,1,2,3,4,5,6})[dw]
end

adt.nextfriday = function()
	local today = os.time()
	local todaydow = get_day_of_week(adt.ytoday, adt.mtoday, adt.dtoday)

	local tempunixtime
	local nextfriday = {}

	-- todaydow: Sunday = 0, Monday = 1 etc
	if todaydow == 0 then
		tempunixtime = today + 86400 * 5
		adt.ton = "this Friday"
	elseif todaydow == 1 then
		tempunixtime = today + 86400 * 4
		adt.ton = "this Friday"
	elseif todaydow == 2 then
		tempunixtime = today + 86400 * 3
		adt.ton = "this Friday"
	elseif todaydow == 3 then
		tempunixtime = today + 86400 * 2
		adt.ton = "this Friday"
	elseif todaydow == 4 then
		tempunixtime = today + 86400 * 1
		adt.ton = "this Friday"
		print("TODAY IS THURS")
	elseif todaydow == 5 then
		tempunixtime = today
		adt.ton = "today"
	elseif todaydow == 6 then
		tempunixtime = today + 86400 * 6
		adt.ton = "next Friday"
	end

	nextfriday.y = date("%Y", tempunixtime)
	nextfriday.m = date("%m", tempunixtime)
	nextfriday.d = date("%d", tempunixtime)

	return nextfriday
end
--================================================================================================
-- Android Back button function
adt.backbuttond = function(e)
	if (e.phase == "down" and e.keyName == "back") then
		downPress = true
		return true
		
	elseif (e.phase == "up" and e.keyName == "back" and downPress) then

		if ( composer.currentScene == "main" ) then
		
			local function onBackComplete( event )
				if "clicked" == event.action then
					local i = event.index
					
					if 1 == i then
						
					elseif 2 == i then
						native.requestExit()

					end
				end
			end
			
			local alert = native.showAlert( "Quit Dodge?", "", { "No", "Yes" }, onBackComplete )

		else
			if ( composer.isOverlay ) then
				composer.hideOverlay()
			else
				local lastScene = composer.returnTo
				print( "previous scene", lastScene )
				if ( lastScene ) then
					adt.backscene();
					--adt.backscene = nil
				else
					native.requestExit()
				end
			end
		end
		
		return true
	end
	
	return false; --THE LINE YOU REALLY NEED IS THIS ONE!!!
end

Runtime:addEventListener( "key", adt.backbuttond )
--================================================================================================
-- Go to Chk first time launch
composer.gotoScene( "chkftl", { effect="fade", time=250 } )