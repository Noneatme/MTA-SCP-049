-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: MainMenu.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

MainMenu = {};
MainMenu.__index = MainMenu;

addEvent("onClientDownloadFinnishedMAINMENU", true);
addEvent("onClientDownloadFinnishedGAME", true);

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MainMenu:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Show		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:Show(...)
	if not(self.enabled) then
		self.enabled = not (self.enabled);
		downloadManager:RequestFiles("mainmenu");
		fadeCamera(false, 0);
		setTimer(fadeCamera, 1000, 1, true)


		self:ShowGui();
	end
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:Render(...)
	if(self.enabled) then
		dxDrawRectangle(27/self.aesx*self.sx, 290/self.aesy*self.sy, 568/self.aesx*self.sx, 116/self.aesy*self.sy, tocolor(0, 0, 0, 200), true)
		dxDrawText("Start Game", 27/self.aesx*self.sx, 290/self.aesy*self.sy, 596/self.aesx*self.sx, 408/self.aesy*self.sy, tocolor(255, 255, 255, 255), 1/(self.aesx+self.aesy)*(self.sx+self.sy), messageBox.font, "center", "center", false, false, true, false, false)

		dxDrawRectangle(27/self.aesx*self.sx, 441/self.aesy*self.sy, 568/self.aesx*self.sx, 116/self.aesy*self.sy, tocolor(0, 0, 0, 200), true)
		dxDrawText("About", 27/self.aesx*self.sx, 441/self.aesy*self.sy, 596/self.aesx*self.sx, 559/self.aesy*self.sy, tocolor(255, 255, 255, 255), 1/(self.aesx+self.aesy)*(self.sx+self.sy), messageBox.font, "center", "center", false, false, true, false, false)

		--	showCursor(true);

		exports["shader_gloom1"]:setBrightness(0.30+math.random(0.00, 0.15));


		if(self.cameraMovePos == "up") then
			if(self.cz > 1016) then
				self.cameraMovePos = "down";
			end

			self.cz = self.cz+0.0005;
		else
			if(self.cz < 1014) then
				self.cameraMovePos = "up";
			end
			self.cz = self.cz-0.0005;
		end
		setCameraMatrix(self.cx, self.cy, self.cz, self.crx, self.cry, self.crz)

	else
		self.enabled = true;
		self:Hide();
	end
end

-- ///////////////////////////////
-- ///// Launch		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:Launch()
	self:Hide();

	setTimer(function()
		triggerServerEvent("onPlayerJoinSpawn", getLocalPlayer(), getLocalPlayer())
		ego:Start();
		exports["shader_gloom1"]:setBrightness(0.03);

		if not(textureReplacer) then

			textureReplacer = TextureReplacer:New()
			imageDrawer = ImageDrawer:New();

			imageDrawer:DrawImage("files/images/warning1.jpg", 386.41137695313, 177.89517822266, 1008.3828125, 385.41137695313, 177.89517822266, 1008.3828125, 386.93344116211, 177.13700866699, 1008.3828125, 10)

			imageDrawer:DrawImage("files/images/blood.png", 376.27880859375, 170.95959472656, 1007.4828125, 371.0126953125, 175.6275177002, 1007.4828125, false, false, false, 10, 2)
			imageDrawer:DrawImage("files/images/blood.png", 360.81546020508, 167.9128112793, 1007.4828125, 362.77044677734, 171.22283935547, 1007.4828125, false, false, false, 10, 2)
			imageDrawer:DrawImage("files/images/blood.png", 362.60089111328, 177.07765197754, 1007.4828125, 372.17129516602, 169.67088317871, 1007.4828125, false, false, false, 15, 10)

			imageDrawer:DrawImage("files/images/blood.png", 362.29183959961, 168.39797973633, 1018.99, 367.1819152832, 157.44789123535, 1018.99, false, false, false, 15, 10)

			imageDrawer:DrawImage("files/images/blood.png", 331.68951416016, 157.8910369873, 1013.1875, 325.07022094727, 148.87399291992, 1013.1875, false, false, false, 15, 10)

			motionBlur = MotionBlur:New()

		end
	end, 1000, 1)
	
	removeEventHandler("onClientDownloadFinnishedGAME", localPlayer, self.launchFunc)
	
end

-- ///////////////////////////////
-- ///// LaunchGame	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:LaunchGame()

	guiSetEnabled(self.guiEle.button1, false);
	downloadManager:RequestFiles("game");


	addEventHandler("onClientDownloadFinnishedGAME", localPlayer, self.launchFunc)

end

-- ///////////////////////////////
-- ///// HideGui	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:HideGui()

	for index, ele in pairs(self.guiEle) do
		if(isElement(ele)) then
			destroyElement(ele)
		end
	end
	showCursor(false);
end

-- ///////////////////////////////
-- ///// ShowGui	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:ShowGui()
	self.guiEle = {}


	self.guiEle.button1 = guiCreateButton(27/self.aesx*self.sx, 290/self.aesy*self.sy, 568/self.aesx*self.sx, 116/self.aesy*self.sy, "", false)
	self.guiEle.button2 = guiCreateButton(27/self.aesx*self.sx, 441/self.aesy*self.sy, 568/self.aesx*self.sx, 116/self.aesy*self.sy, "", false)

	guiSetAlpha(self.guiEle.button1, 0)
	guiSetAlpha(self.guiEle.button2, 0)

	addEventHandler("onClientGUIClick", self.guiEle.button1, function()
		self:LaunchGame()
	end, false)

	addEventHandler("onClientGUIClick", self.guiEle.button2, function()
		messageBox:Show("SCP-049 gamemode made by Noneatme\nThis gamemode is open source.", {0, 0, 0}, {255, 255, 255}, 5000);
	end, false)

	showCursor(true);
end

-- ///////////////////////////////
-- ///// Hide		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:Hide()
	if(self.enabled) then
		self.enabled = false;
		removeEventHandler("onClientRender", getRootElement(), self.renderFunc)

		self:HideGui();

		destroyElement(self.sound);
		fadeCamera(false);

	end
end

-- ///////////////////////////////
-- ///// GenerateSparks		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:GenerateSparks()
	self.timers	= {}
	local rndSounds	= {"02", "03", "04", "05", "06", "07", "09", "10", "13", "14", "15", "17", "18", "19", "20", "21", "24", "26", "28", "29", "30"};
	local function createLampSpark()
		if(self.enabled) then
			local x, y, z = 325.43823242188, 186.52961730957, 1017.1555786133
			fxAddSparks(x, y, z, 0, 0, 1, 1, math.random(5, 25), 0, 0, 0, false, 1, 5)
			local rnd = rndSounds[math.random(1, #rndSounds)];

			local snd = soundManager:PlaySound3D("files/sounds/light_flicker/light_flicker_"..rnd..".ogg", x, y, z, false, "sounds");

			setSoundVolume(snd, 0.5);
		end
		setTimer(createLampSpark, math.random(50, 3000), 1);
	end

	createLampSpark()
end

-- ///////////////////////////////
-- ///// InitMainMenu		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:InitMainMenu()
	if not(messageBox) then
		messageBox 				= MessageBox:New();
	end
	effects 					= Effects:New();
	
	self.cameraMovePos			= "up";
	self.sound					= soundManager:PlaySound("files/music/game_menu.ogg", true, "music");

	addEventHandler("onClientRender", getRootElement(), self.renderFunc)

	triggerServerEvent("onPlayerJoin2", localPlayer);

	setCameraMatrix(self.cx, self.cy, self.cz, self.crx, self.cry, self.crz)

	self:GenerateSparks()
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:Constructor(...)
	-- Klassenvariablen --
	self.sx, self.sy		= guiGetScreenSize();
	self.aesx, self.aesy	= 1600, 900;

	self.enabled	= false;

	self.renderFunc	= function(...) self:Render(...) end;
	self.launchFunc	= function(...) self:Launch(...) end;

	self.cx, self.cy, self.cz 		= 332.21002197266, 180.98417663574, 1013.8770141602;
	self.crx, self.cry, self.crz	= 326.72052001953, 185.95335388184, 1015.1970825195;

	setCameraMatrix(self.cx, self.cy, self.cz, self.crx, self.cry, self.crz)


	addEventHandler("onClientDownloadFinnishedMAINMENU", localPlayer, function()
		self:InitMainMenu();
	end)

	logger:OutputInfo("[CALLING] MainMenu: Constructor");
end

-- EVENT HANDLER --
