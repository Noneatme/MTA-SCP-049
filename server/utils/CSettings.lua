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
-- ///// StartResources		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Settings:StartResources()
	local resources	=
	{
		["shader_flashlight_test"] 	= true,
		["shader_gloom1"]			= true,
		["bone_attach"]				= true,
		["helpmanager"]				= false,
	};

	
	logger:OutputInfo("(Re)starting Resources...");
	
	for res, _ in pairs(resources) do
		if(getResourceFromName(res)) then
			res = getResourceFromName(res);
			if(_ == true) then
				if(getResourceState(res) == "running") then
					restartResource(res);
				else
					startResource(res);
				end
			else
				if(getResourceState(res) == "running") then
					stopResource(res);
					logger:OutputInfo("Resource '"..getResourceName(res).."' was shut down (not allowed resource)");
				end
			end
		else
			logger:OutputInfo("URGENT: Resource '"..getResourceName(res).."' was not found! Please install.");
			stopResource(getThisResource())
		end
	end
	
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

	-- Restart and Start resouces --
	self:StartResources();
	logger:OutputInfo("[CALLING] Settings: Constructor");
end

-- EVENT HANDLER --
