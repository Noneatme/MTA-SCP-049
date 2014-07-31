-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Development.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Development = {};
Development.__index = Development;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Development:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Development:Constructor(...)
	setDevelopmentMode(true);
	
	
		
	addCommandHandler("opendoors", function()
		for i = 1, #doors.doorPos, 1 do
			doors:OpenDoor(i);
		end
		
		messageBox:Show("All Doors opened", {255, 255, 255}, {0, 255, 255})
	end)
	
	
	addCommandHandler("teleport", function(cmd, typ)
		typ = tonumber(typ)
		if(typ == 0) then
			setElementPosition(localPlayer, 367.46697998047, 173.48818969727, 1008.3828125)
		elseif(typ == 1) then
			setElementPosition(localPlayer, 366.01290893555, 162.03164672852, 1014.1875)
		elseif(typ == 2) then
			setElementPosition(localPlayer, 367.67816162109, 162.24978637695, 1019.984375)
		elseif(typ == 3) then
			setElementPosition(localPlayer, 368.55902099609, 162.31114196777, 1025.7890625)
		
		end
	end)
	
	logger:OutputInfo("[CALLING] Development: Constructor");
	
end

-- EVENT HANDLER --
