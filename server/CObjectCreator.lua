-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Script						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings


-- EVENT HANDLER --


do
	logger = Logger:New();
	
	mapLoader = MapLoader:New();
	
	spawnManager = SpawnManager:New();
	
	settings = Settings:New();
	
	restartResource(getResourceFromName("shader_flashlight_test"))
--	restartResource(getResourceFromName("shader_gloom1"))

	stopResource(getResourceFromName("helpmanager"))
end