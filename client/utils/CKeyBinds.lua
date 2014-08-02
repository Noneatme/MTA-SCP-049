-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: KeyBinds.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

KeyBinds = {};
KeyBinds.__index = KeyBinds;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function KeyBinds:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// unbindKeys			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function KeyBinds:UnbindKeys()

	toggleControl("next_weapon", false)
	toggleControl("previous_weapon", false)
	toggleControl("aim_weapon", false);
	toggleControl("fire", false)
	toggleControl("action", false)
	toggleControl("sprint", false)
	toggleControl("walk", false)
	
	setControlState("aim_weapon", false)
	setControlState("aim_weapon", true)
	setControlState("walk", true);
	setControlState("sprint", false);
	
	bindKey("sprint", "both", self.jogFunc)
	
	
	setTimer(function()
		setControlState("aim_weapon", false)
		setControlState("aim_weapon", true)
		setPedWeaponSlot(localPlayer, 2)
	end, 5000, -1)
end



-- ///////////////////////////////
-- ///// CheckElement 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function KeyBinds:CheckElement()
	local x, y, z = getElementPosition(localPlayer)
	
	
	for index, object in pairs(doors.keys) do
		if(isElement(object)) then
			local x, y, z = getElementPosition(object)
			local x2, y2, z2 = getElementPosition(localPlayer)
			if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 3) then
				local index = tonumber(getElementData(object, "key_index"));
				local name = getElementData(object, "key_name")
				if(index) then
					destroyElement(object);
					setElementData(doors.doors[index], "locked", false, false);
					messageBox:Show("You picked up a key:\nKey for "..name, {255, 255, 255}, {0, 255, 0})
					soundManager:PlaySound("files/sounds/key.ogg", false, "sounds");
					
					trigger:CheckForMusic(index);
				end
				break;
			end
		end
	end
	
	for index, object in pairs(doors.doors) do
		if(isElement(object)) then

			local x, y, z = getElementPosition(object)
			local x2, y2, z2 = getElementPosition(localPlayer)
			if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 3) then

				if(getElementData(object, "locked") == false) then

					if(getElementData(object, "door_state") == false) then

						doors:OpenDoor(tonumber(getElementData(object, "door_index")));

					else
						doors:CloseDoor(tonumber(getElementData(object, "door_index")));

					end
				else
					if not(isElement(self.lockedDoorSound)) then
						self.lockedDoorSound 	= 	soundManager:PlaySound("files/sounds/locked_door.ogg", false, "sounds");
						setSoundVolume(self.lockedDoorSound, 0.5);
					end
				end
				break;
			end
		end
	end
end

--[[
function KeyBinds:CheckElement()
	local x, y, z = getElementPosition(localPlayer)
	
	local col = createColSphere(x, y, z, 10);
	
	
	setElementDimension(col, getElementDimension(localPlayer));
	setElementInterior(col, getElementInterior(localPlayer));	
	outputChatBox(#getElementsWithinColShape(col))

	outputChatBox(tostring(col)..", "..tostring(x)..", "..tostring(y)..", "..tostring(z))
	
	
	for index, object in pairs(getElementsWithinColShape(col, "object")) do
		outputChatBox(object)
		if(getElementModel(object) == 1581) then
			local index = tonumber(getElementData(object, "key_index"));
			
			if(index) then
				destroyElement(object);
				setElementData(doors.doors[index], "locked", false, false);
			end
			break;
		end
	end
	
end]]

-- ///////////////////////////////
-- ///// BindEKey			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function KeyBinds:BindEKey()
	bindKey("e", "down", self.triggerCheckFunc);
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function KeyBinds:Constructor(...)
	self.triggerCheckFunc = function() self:CheckElement() end;

	self.jogFunc = function(key, state)
		if(state == "down") then 
			setControlState("walk", false)
			setGameSpeed(1.0)
		else
			setControlState("walk", true)
			setGameSpeed(1.5);
		end
	end;
	
	self:UnbindKeys();
	
	self:BindEKey();
	
	
	logger:OutputInfo("[CALLING] KeyBinds: Constructor");
end

-- EVENT HANDLER --
