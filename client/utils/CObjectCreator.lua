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

addEvent("onDimensionGet", true)

cFunc["join"] = function()
	triggerServerEvent("onPlayerJoin2", getLocalPlayer())
end

-- EVENT HANDLER --


do
	logger = Logger:New();
	soundManager = SoundManager:New();
	
	soundManager:AddCategory("music");
	soundManager:AddCategory("sounds");
	
	mapLoader = MapLoader:New();
	
	ego = Ego:New();
	ego:Start();
	
	messageBox = MessageBox:New();
	messageBox:Show("Please wait for your download to finish.", {255, 255, 255}, {0, 255, 0}, 7500);
		
	downloadManager 		= DownloadManager:New();
	
	addEvent("onClientDownloadFinnished", true)
	addEventHandler("onClientDownloadFinnished", localPlayer, function()
	
		cFunc["join"]();
	
		textureReplacer = TextureReplacer:New()
	
		
		imageDrawer = ImageDrawer:New();
		imageDrawer:DrawImage("files/images/warning1.jpg", 386.41137695313, 177.89517822266, 1008.3828125, 385.41137695313, 177.89517822266, 1008.3828125, 386.93344116211, 177.13700866699, 1008.3828125, 10)
		
		imageDrawer:DrawImage("files/images/blood.png", 376.27880859375, 170.95959472656, 1007.4828125, 371.0126953125, 175.6275177002, 1007.4828125, false, false, false, 10, 2)
		imageDrawer:DrawImage("files/images/blood.png", 360.81546020508, 167.9128112793, 1007.4828125, 362.77044677734, 171.22283935547, 1007.4828125, false, false, false, 10, 2)
		imageDrawer:DrawImage("files/images/blood.png", 362.60089111328, 177.07765197754, 1007.4828125, 372.17129516602, 169.67088317871, 1007.4828125, false, false, false, 15, 10)
		
		imageDrawer:DrawImage("files/images/blood.png", 362.29183959961, 168.39797973633, 1018.99, 367.1819152832, 157.44789123535, 1018.99, false, false, false, 15, 10)
		
		imageDrawer:DrawImage("files/images/blood.png", 331.68951416016, 157.8910369873, 1013.1875, 325.07022094727, 148.87399291992, 1013.1875, false, false, false, 15, 10)
		
		--imageDrawer:DrawImage("files/images/warning1.jpg", 364.2912902832, 172.98876953125, 1014.1278076172, 365.11483764648, 172.98876953125, 1015.0776977539, 364.64837646484, 170.54354858398, 1014.1875, 10, 2)
		
	
		messageBox:Show("Find a way out.\nCollect keycards to pass through doors.", {255, 255, 255}, {0, 255, 0}, 7500)
		
		
		motionBlur = MotionBlur:New()
		
		
		setTimer(function()
		--	motionBlur:AddEffect()
		end, 2000, 1)
	end)
end


cFunc["get_dimension"] = function(dim)
	
	doors 			= Doors:New(dim)
	cardRender 		= CardRender:New();
	keyBinds 		= KeyBinds:New();
	trigger 		= Trigger:New();
	development 	= Development:New();
	alien 			= Alien:New();
	effects 		= Effects:New();
	worldSounds		= WorldSounds:New();
		
	setPedTargetingMarkerEnabled(false);
	
end

--addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), cFunc["join"]);
addEventHandler("onDimensionGet", getLocalPlayer(), cFunc["get_dimension"])