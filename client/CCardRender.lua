-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: CardRender.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

CardRender = {};
CardRender.__index = CardRender;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function CardRender:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function CardRender:Render()
	--[[
	for index, object in pairs(getElementsByType("object", getRootElement(), true)) do
	if(getElementModel(object) == 1581) then	-- Key
	local name = getElementData(object, "key_name");
	if(name) then
	local x, y, z = getElementPosition(object)
	local x2, y2, z2 = getElementPosition(localPlayer)

	if(isLineOfSightClear(x, y, z+1, x2, y2, z2, true, false, false, true)) then
	z = z+0.5

	local sx, sy = getScreenFromWorldPosition(x, y, z)
	if(sx) and (sy) then
	local distance = getDistanceBetweenElements(object, localPlayer)
	if(distance < 20) then
	local fontbig = 2-(distance/10)
	local a = 200
	a = a/distance

	dxDrawText("#000000Room Key: "..name.."\nPress 'E' to pick up", sx+2, sy+2, sx, sy, tocolor(255, 255, 255, a), fontbig, "default-bold", "center", "top", false, false, false, true)
	dxDrawText("#FFFFFFRoom Key: #00FFFF"..name.."\nPress 'E' to pick up", sx, sy, sx, sy, tocolor(0, 0, 0, a), fontbig, "default-bold", "center", "top", false, false, false, true)
	end

	end
	end
	end
	elseif(getElementModel(object) == 1533) then	-- Tuer
	local name = getElementData(object, "door_name");
	if(name) then
	local x, y, z = getElementPosition(object)
	z = z+1
	local x2, y2, z2 = getElementPosition(localPlayer)

	local locked = getElementData(object, "locked");
	if(locked) then
	locked = "Yes\nI need a key for that!"
	else
	if(getElementData(object, "door_state") == false) then
	locked = "No\n#00FF00Press 'E' to open";
	else
	locked = "No\n#00FFFFPress 'E' to close";

	end
	end

	if(isLineOfSightClear(x, y, z+1, x2, y2, z2, false, false, false, true)) then
	z = z+0.5

	local sx, sy = getScreenFromWorldPosition(x, y, z)
	if(sx) and (sy) then

	local distance = getDistanceBetweenElements(object, localPlayer)
	if(distance < 20) then
	local fontbig = 2-(distance/8)
	local a = 255
	a = (a/distance)


	if(fontbig > 0) then

	dxDrawText("#000000"..name.."\nLocked: "..locked, sx+2, sy+2, sx, sy, tocolor(255, 255, 255, a), fontbig, "default-bold", "center", "top", false, false, false, true)
	dxDrawText("#FFFFFF"..name.."\nLocked: "..locked, sx, sy, sx, sy, tocolor(0, 0, 0, a), fontbig, "default-bold", "center", "top", false, false, false, true)
	end
	end

	end
	end
	end
	end
	end]]
	
	-- Render Cop Dingens --
	

	for index, object in pairs(doors.keys) do
		if(isElement(object)) then
			if(getElementModel(object) == 1581) then	-- Key
				local name = getElementData(object, "key_name");
				if(name) then
					local x, y, z = getElementPosition(object)
					local x2, y2, z2 = getElementPosition(localPlayer)

					if(isLineOfSightClear(x, y, z+1, x2, y2, z2, true, false, false, true)) then
						z = z+0.5

						local sx, sy = getScreenFromWorldPosition(x, y, z)
						if(sx) and (sy) then
							local distance = getDistanceBetweenElements(object, localPlayer)
							if(distance < 20) then
								local fontbig = 2-(distance/10)
								local a = 200
								a = a/distance

								dxDrawText("#000000Room Key: "..name.."\nPress 'E' to pick up", sx+2, sy+2, sx, sy, tocolor(255, 255, 255, a), fontbig, "default-bold", "center", "top", false, false, false, true)
								dxDrawText("#FFFFFFRoom Key: #00FFFF"..name.."\nPress 'E' to pick up", sx, sy, sx, sy, tocolor(0, 0, 0, a), fontbig, "default-bold", "center", "top", false, false, false, true)
							end

						end
					end
				end
			end
		end
	end
	for index, object in pairs(doors.doors) do
		if(isElement(object)) then
			local name = getElementData(object, "door_name");
			if(name) then
				local x, y, z = getElementPosition(object)
				z = z+1
				local x2, y2, z2 = getElementPosition(localPlayer)

				local locked = getElementData(object, "locked");
				if(locked) then
					locked = "Yes\nI need a key for that!"
				else
					if(getElementData(object, "door_state") == false) then
						locked = "No\n#00FF00Press 'E' to open";
					else
						locked = "No\n#00FFFFPress 'E' to close";

					end
				end

				if(isLineOfSightClear(x, y, z+1, x2, y2, z2, false, false, false, true)) then
					z = z+0.5

					local sx, sy = getScreenFromWorldPosition(x, y, z)
					if(sx) and (sy) then

						local distance = getDistanceBetweenElements(object, localPlayer)
						if(distance < 20) then
							local fontbig = 2-(distance/8)
							local a = 255
							a = (a/distance)


							if(fontbig > 0) then

								dxDrawText("#000000"..name.."\nLocked: "..locked, sx+2, sy+2, sx, sy, tocolor(255, 255, 255, a), fontbig, "default-bold", "center", "top", false, false, false, true)
								dxDrawText("#FFFFFF"..name.."\nLocked: "..locked, sx, sy, sx, sy, tocolor(0, 0, 0, a), fontbig, "default-bold", "center", "top", false, false, false, true)
							end
						end

					end
				end
			end
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function CardRender:Constructor(...)
	self.renderFunc = function() self:Render() end;

	addEventHandler("onClientRender", getRootElement(), self.renderFunc)

	logger:OutputInfo("[CALLING] CardRender: Constructor");
end

-- EVENT HANDLER --

function getDistanceBetweenElements(element1, element2)
	local x, y, z = getElementPosition(element1)
	local x1, y1, z1 = getElementPosition(element2)
	return getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
end