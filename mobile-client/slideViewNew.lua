-- slideView.lua
-- 
-- Version 1.0 
--
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of 
-- this software and associated documentation files (the "Software"), to deal in the 
-- Software without restriction, including without limitation the rights to use, copy, 
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
-- and to permit persons to whom the Software is furnished to do so, subject to the 
-- following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all copies 
-- or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.

module(..., package.seeall)

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local imgNum = nil
local hasstarted = 0
local direction = nil
local touchListener, nextImage, prevImage, cancelMove, initImage
local background
local imageNumberText, imageNumberTextShadow

--[[
	Changed some x and y values of slides
	using originial display groups instead of taking uop new memory, copying into new display groups
	card style instead of ios style
	2014/02/09
]]--

function new( imageSet, imgNum ,slideBackground, top, bottom )	
	local pad = 0
	local top = top or 0 
	local bottom = bottom or 0

	local g = display.newGroup()
	
	if slideBackground then
		background = display.newImage(slideBackground, 0, 0, true)
	else
		background = display.newRect( 0, 0, screenW, screenH-(top+bottom) )

		-- set anchors on the background
		background.anchorX = 0
		background.anchorY = 0

		background:setFillColor(1, 1, 1)
		
		background.alpha = 0.01
	end
	
	
	for i = 1,#imageSet do
		--local p = require(imageSet[i]).new()
		--[[local p = imageSet[i]
		p.anchorX = 0.5
		p.anchorY = 0.5
]]--
		local h = viewableScreenH-(top+bottom)

		g:insert(imageSet[i])
	    
		if (i > 1) then
			imageSet[i].x = screenW + pad -- all imageSet offscreen except the first one
		else 
			imageSet[i].x = 10000
		end
		
		imageSet[i].y = 0

	end
	g:insert(background)
	local defaultString = "1 of " .. #imageSet

	local navBar = display.newGroup()
	g:insert(navBar)

	hasstarted = 0
	
	g.x = 0
	g.y = top + display.screenOriginY
			
	function touchListener (self, touch) 
		local phase = touch.phase
		--print("slides", phase)
		--print("slide ori " ..  imageSet[imgNum].x)
		if (imageSet[imgNum+1]) then
			--print("slide ori+1 " ..  imageSet[imgNum+1].x)
		end
		if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the contentBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

			startPos = touch.x
			prevPos = touch.x
			
			transition.to( navBar,  { time=200, alpha=math.abs(navBar.alpha-1) } )
									
        elseif( self.isFocus ) then
        
			if ( phase == "moved" ) then
			
				transition.to(navBar,  { time=400, alpha=0 } )
						
				if tween then transition.cancel(tween) end
	
				--print(imgNum)
				
				local delta = touch.x - prevPos
				prevPos = touch.x
				
				if hasstarted == 0 then
					hasstarted = 1
					
					if (delta <= 0) then
						-- swipe left
						direction = "l"
					elseif (delta > 0) then
						-- swipe right
						direction = "r"
					end
				end

					--left
				if (direction == "l") then
					
					if (imageSet[imgNum+1]) then
					
						if (imageSet[imgNum+1] and imageSet[imgNum+1].x >= 0) then
							imageSet[imgNum+1].x = imageSet[imgNum+1].x + delta
						elseif (imageSet[imgNum+1].x < 0) then
							imageSet[imgNum+1].x = 0
						end
					
					end

				elseif (direction == "r") then
					-- riught					
					if (imageSet[imgNum-1]) then
						imageSet[imgNum-1].x = 0
					end
					
					if (imgNum~=1 and imageSet[imgNum].x >= 0) then
						imageSet[imgNum].x = imageSet[imgNum].x + delta
					elseif (imageSet[imgNum].x < 0) then
						imageSet[imgNum].x = 0
					end
				end

			elseif ( phase == "ended" or phase == "cancelled" ) then
				
				dragDistance = touch.x - startPos
				print("dragDistance: " .. dragDistance)
				
				if (dragDistance < -40 and imgNum < #imageSet) then
					nextImage()
				elseif (dragDistance > 40 and imgNum > 1) then
					prevImage()
				else
					cancelMove()
				end
									
				if ( phase == "cancelled" ) then		
					cancelMove()
				end
				
				if (imageSet[imgNum-1]) then
					imageSet[imgNum-1].x = 100000
				end

                -- Allow touch events to be sent normally to the objects they "hit"
                display.getCurrentStage():setFocus( nil )
                self.isFocus = false
				
				hasstarted = 0
			end
		end
					
		return true
		
	end
	
	function setSlideNumber()
		print("setSlideNumber", imgNum .. " of " .. #imageSet)
	end
	
	function cancelTween()
		if prevTween then 
			transition.cancel(prevTween)
		end
		prevTween = tween 
	end
	
	local delay = function()
		for i = 1,#imageSet do
			imageSet[i].x = 10000
		end
	
		if imageSet[imgNum - 1] then
			imageSet[imgNum - 1].x = 10000
		end
		
		imageSet[imgNum].x = 0
		
		if imageSet[imgNum + 1] then
			imageSet[imgNum + 1].x = screenW
		end
	end
	timer.performWithDelay(502, delay)
	
	function nextImage()
		tween = transition.to( imageSet[imgNum], {time=400, x=0, transition=easing.outExpo } )
		tween = transition.to( imageSet[imgNum+1], {time=400, x=0, transition=easing.outExpo } )
		imgNum = imgNum + 1

		timer.performWithDelay(502, delay)
		initImage(imgNum)
	end
	
	function prevImage()
		tween = transition.to( imageSet[imgNum], {time=400, x=screenW, transition=easing.outExpo } )
		tween = transition.to( imageSet[imgNum-1], {time=400, x=0, transition=easing.outExpo } )
		imgNum = imgNum - 1
		
		timer.performWithDelay(502, delay)
		initImage(imgNum)
	end
	
	function cancelMove()
		tween = transition.to( imageSet[imgNum], {time=400, x=0, transition=easing.outExpo } )
		tween = transition.to( imageSet[imgNum-1], {time=400, x=0, transition=easing.outExpo } )
		tween = transition.to( imageSet[imgNum+1], {time=400, x=screenW, transition=easing.outExpo } )

		timer.performWithDelay(502, delay)
	end
	
	function initImage(num)
		if (num < #imageSet) then
			imageSet[num+1].x = screenW		
		end
		if (num > 1) then
			imageSet[num-1].x = 0
		end
		setSlideNumber()
	end

	background.touch = touchListener
	background:addEventListener( "touch", background )

	--nextImage()
	------------------------
	-- Define public methods
	
	function g:jumpToImage(num)
		local i
		print("jumpToImage")
		print("#imageSet", #imageSet)
		for i = 1, #imageSet do
			if i < num then
				imageSet[i].x = 0
			elseif i > num then
				imageSet[i].x = screenW
			else
				imageSet[i].x = 0
			end
		end
		imgNum = num
		initImage(imgNum)
	end
	
	-- jump to desired image
	g:jumpToImage(imgNum)

	function g:cleanUp()
		print("slides cleanUp")
		background:removeEventListener("touch", touchListener)
	end

	return g	
end

