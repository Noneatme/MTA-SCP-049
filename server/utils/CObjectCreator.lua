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
	
	downloadManager = DownloadManager:New();

--	restartResource(getResourceFromName("shader_gloom1"))

end