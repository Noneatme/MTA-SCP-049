-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Settings.lua				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Settings = {};
Settings.__index = Settings;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Settings:New(...)
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

function Settings:Constructor(...)
	setFPSLimit(60)
	setTime(0, 0)
	setMinuteDuration(99999999)
	setSkyGradient(0, 0, 0, 0, 0, 0)
	
	logger:OutputInfo("[CALLING] Settings: Constructor");
end

-- EVENT HANDLER --
