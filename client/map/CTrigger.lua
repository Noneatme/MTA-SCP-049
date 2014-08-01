-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Trigger.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- TRIGGER:
-- For level things like cutscenes, sounds and so on

addEvent("onElementScreenStarted", true)

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Trigger = {};
Trigger.__index = Trigger;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Trigger:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// CheckForMusic 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:CheckForMusic(index)
	outputDebugString("Trigger Music: "..index)
	if(index == 1) then
		self:PlayMusic(2);
	elseif(index == 4) then
		self.medicRoomFunc();
	elseif(index == 9) then
		self.moveAlien1();
	elseif(index == 14) then
		messageBox:Show("Run to the exit in the bottom level fast!\nYou got the keycard!", {255, 255, 255}, {255, 0, 0}, 10000)
		alien:SetFailingEnabled(true);
		exports["shader_flashlight_test"]:fadeToColor({255, 150, 0, 255}, 10^10);
		
		alien:Appear(335.32077026367, 185.11631774902, 1014.1875, 180, false, true);
		
		
		self.thisFunc = function()
				local s = soundManager:PlaySound3D("files/sounds/HorrorAction22.mp3", 336.82791137695, 181.82263183594, 1014.1875, false, "sounds");
				setSoundMaxDistance(s, 50);
				--motionBlur:AddBlur(10000)
				motionBlur:AddEffect()
				alien:ChaseLocalPlayer()
				
				removeEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
			end
			
		addEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
	end
end

-- ///////////////////////////////
-- ///// PlayMusic	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:PlayMusic(level)
	if(isElement(self.music)) then
		destroyElement(self.music)
	end
	
	if(level == 2) then
		self.music = soundManager:PlaySound(self.musicPath.."mus_trt.mp3", false, "music");
		soundManager:SetCategoryVolume("music", 0.4);
		
		motionBlur:AddBlur()
	end
end

-- ///////////////////////////////
-- ///// DoWin				//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:DoWin()
	if(self.exitDoorUsed ~= true) then
		self.exitDoorUsed = true
		messageBox:Show("The door won't move!!", {255, 255, 255}, {255, 0, 0});
		alien:SetFailingEnabled(false);
		self.thisFunc = function()
			local x, y, z = getElementPosition(localPlayer)
		
			local s = soundManager:PlaySound3D("files/sounds/HorrorAction22.mp3", x, y, z, false, "sounds");
			setSoundMaxDistance(s, 50);
			motionBlur:AddEffect()

					
			removeEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
		end
				
		addEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
		
		setTimer(function()
			wintext = WinText:New(true)
			alien:Disappear(true);
		end, 5000, 1)
	end
end

-- ///////////////////////////////
-- ///// PlayDoorTrigger	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:PlayDoorTrigger(index)
	if not(self.doorTriggerPlayed[index]) then
		if(index == 3) then
			if(isElement(self.music)) then
				destroyElement(self.music)
			end
			self.music = soundManager:PlaySound(self.musicPath.."music2.ogg", true, "music");
			soundManager:SetCategoryVolume("music", 0.3);
			--messageBox:Show("You should let your flashlight turned on.", {255, 255, 255}, {0, 255, 255})
		elseif(index == 6) then
			moveObject(self.ele.schrank1, 1000, 365.52188110352, 189.61549377441, 1019.4406738281, 90, 0, 0, "InQuad")
			setTimer(function()
				local s = soundManager:PlaySound3D("files/sounds/schrank1.ogg", 365.52188110352, 189.61549377441, 1019.4406738281, false, "sounds");
				setSoundMaxDistance(s, 50)
				motionBlur:AddEffect()
			end, 800, 1)

		elseif(index == 9) then
			doors:OpenDoor(10)
			messageBox:Show("The working room 2 door opened...", {255, 255, 255}, {0, 255, 255})
			
		elseif(index == 10) then
			alien:SetFailingEnabled(false);
			alien:Appear(329.08306884766, 154.69798278809, 1014.1875, 288)
			
			self.thisFunc = function()
				local s = soundManager:PlaySound3D("files/sounds/boom.mp3", 329.08306884766, 154.69798278809, 1014.1875, false, "sounds");
				setSoundMaxDistance(s, 50);
				--motionBlur:AddBlur(10000)
				motionBlur:AddEffect()
				setTimer(function()
					alien:Disappear()
					
					for index, cop in pairs(effects.cops) do
						setElementVelocity(cop, 0, 0, -1)
					end
					
					setTimer(function()

					end, 5000, 1)
				end, 1000, 1)
				
				removeEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
			end
			
			addEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
		elseif(index == 14) then
			-- You made it!
		--	wintext = WinText:New()
		end
		
		self.doorTriggerPlayed[index] = true;
	end
end



-- ///////////////////////////////
-- ///// CreateTriggerElements////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:CreateTriggerElements()
	self.ele = {}

	self.ele.liege = createObject(1997, 337.20770263672, 172.36854553223, 1018.984375, 0, 0, 90);


	self.ele.wc = {
		createObject(2949, 344.01156616211, 164.56755065918, 1013.2032470703, 0, 0, 90),
		createObject(2949, 345.63494873047, 164.5673828125, 1013.2032470703, 0, 0, 90),
		createObject(2949, 347.25152587891, 164.5673828125, 1013.2032470703, 0, 0, 90),
		createObject(2949, 348.86291503906, 164.5673828125, 1013.2032470703, 0, 0, 90),
	}
	
	self.ele.schrank1 = createObject(2167, 366.00161743164, 189.61549377441, 1018.984375, 0, 0, 270)
	setElementDoubleSided(self.ele.schrank1, true)
	
	self.ele.rolly = createObject(1789, 335.25213623047, 172.41461181641, 1019.5405883789, 0, 0, 90)
	
	self.ele.staticsound = soundManager:PlaySound3D("files/sounds/static.mp3", 322.28359985352, 183.37240600586, 1013.8850097656, true, "sounds")
	setSoundVolume(self.ele.staticsound, 0.5);

	
	
	for index, ele in pairs(self.ele) do
		if(type(ele) == "table") then
			for index, e in pairs(ele) do
				setElementDimension(e, getElementDimension(localPlayer));
				setElementInterior(e, getElementInterior(localPlayer));
			end
		else
			setElementDimension(ele, getElementDimension(localPlayer));
			setElementInterior(ele, getElementInterior(localPlayer));
		end
	end
end


-- ///////////////////////////////
-- ///// CreateTrigger 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////


function Trigger:CreateTrigger()
	self.triggerMarkerPos = {
		-- x, y, z, size, function, repeat(destroy source)
		{372.82260131836, 154.12501525879, 1010.1875, 1, self.playScream1Func, true},
		{364.56106567383, 164.23191833496, 1019.984375, 4, self.moveLiegeFunc, true},
		{345.67922973633, 158.68232727051, 1014.1875, 1, self.openWCDoorsFunc, true},
		{327.83029174805, 173.31246948242, 1019.9912109375, 1, self.rollyFunc, false},
		{331.52404785156, 166.35241699219, 1014.1875, 1, self.sparksFunc, true},
		{371.93774414063, 153.51057434082, 1010.1875, 2, self.chasePlayerWin, false},
		{365.08126831055, 170.38128662109, 1014.1875, 5, self.showAlienRunning, true},
	}
	
	
	
	for index, pos in pairs(self.triggerMarkerPos) do
		self.triggerMarker[index] = createMarker(pos[1], pos[2], pos[3], "corona", (pos[4] or 1.0), 0, 0, 0, 0)
		setElementDimension(self.triggerMarker[index], getElementDimension(localPlayer));
		setElementInterior(self.triggerMarker[index], getElementInterior(localPlayer));
		
		addEventHandler("onClientMarkerHit", self.triggerMarker[index], function(hitElement, dim)
			if(dim == true) and (hitElement == localPlayer) then
				pos[5](source);
				logger:OutputInfo("Trigger "..index.." played");
				if(pos[6] == true) then
					destroyElement(source)
				end
			end
		end)
	end
end

-- ///////////////////////////////
-- ///// PlayTrigger 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:PlayTrigger(index)
	if(index == 1) then
		local s = soundManager:PlaySound3D("files/sounds/scream1.mp3", 379.5212097168, 162.10943603516, 1014.1875, false, "sounds");
		setElementDimension(s, getElementDimension(localPlayer))
		setElementInterior(s, getElementInterior(localPlayer))
		setSoundMaxDistance(s, 50);
		setSoundVolume(s, 0.7)
	end	
end


-- ///////////////////////////////
-- ///// CheckTriggerElement//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:CheckTriggerElements()
	local elements = {}
	
	for index, element in pairs(getElementsByType("ped", getRootElement(), true)) do
		elements[index] = element;
	end

	
	for index, element in pairs(elements) do
		if(isElement(element)) and (self.triggered[element] ~= true) then
			local x, y, z = getElementPosition(localPlayer)
			local x2, y2, z2 = getElementPosition(element)
			
			if(isLineOfSightClear(x, y, z, x2, y2, z2, true, false, false, true)) then
				if(isElementOnScreen(element)) then
					-- Trigger
					self.triggered[element] = true;
					triggerEvent("onElementScreenStarted", element);
				--	outputChatBox("Trigger: "..element)
				end
			end
		end
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Trigger:Constructor(...)

	self.musicPath	= "files/music/";

	-- TRIGGER FUNCTIONS --
	self.playScream1Func = function() self:PlayTrigger(1) end;
	
	self.moveLiegeFunc = function()
		moveObject(self.ele.liege, 10000, 366.98371582031, 172.36854553223, 1018.984375, 0, 0, 0, "OutQuad")
		local s = soundManager:PlaySound3D("files/sounds/liege.mp3", 366.18371582031, 172.36854553223, 1018.984375, false, "sounds");
		attachElements(s, self.ele.liege);
		setSoundMaxDistance(s, 50);
	--	motionBlur:AddBlur(5000, 0.005)
		exports["shader_flashlight_test"]:fadeToColor({255, 150, 150, 255}, 10000);
		
	end;
	
	self.openWCDoorsFunc = function()
		for i = 1, 4, 1 do
			for i2 = 1, 8, 1 do
				setTimer(function()
					local x, y, z = getElementPosition(self.ele.wc[i])
					stopObject(self.ele.wc[i])
					
					local _, _, r = getElementRotation(self.ele.wc[i])
					
					if(r > 89) then
						moveObject(self.ele.wc[i], 100, x, y, z, 0, 0, 90)
					else
						moveObject(self.ele.wc[i], 100, x, y, z, 0, 0, -90)
					end
					
					
				end, 100*i2, 1)
			end		
			setTimer(function()
				stopObject(self.ele.wc[i])
				setElementRotation(self.ele.wc[i], 0, 0, 90)
			end, 100*8, 1)
		end
		
		local s = soundManager:PlaySound3D("files/sounds/HorrorAction22.mp3", 346.78454589844, 165.34469604492, 1014.1875, false, "sounds");
		setSoundMaxDistance(s, 50);
		
		motionBlur:AddBlur(10000)
	end
	
	self.medicRoomFunc = function()
		doors:CloseDoor(5);
		
		alien:SetFailingEnabled(false);
		alien:Appear(354.07373046875, 170.25527954102, 1019.984375, 180);
		
		self.thisFunc = function()
			local s = soundManager:PlaySound3D("files/sounds/boom.mp3", 354.07373046875, 170.25527954102, 1019.984375, false, "sounds");
			setSoundMaxDistance(s, 50);
			motionBlur:AddBlur(10000)
			motionBlur:AddEffect()
			--effects:AddRedEffect(5000)
			exports["shader_flashlight_test"]:fadeToColor({255, 0, 0, 255}, 10000, 5);
		
			setTimer(function()
				alien:Disappear()

			end, 1000, 1)
			
			removeEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
		end
		
		addEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
	end
	
	self.rollyFunc = function(so)
		if(getElementData(doors.doors[6], "locked") == false) then
			moveObject(self.ele.rolly, 3000, 335.25213623047, 177.31280517578, 1019.5405883789, 0, 0, 0, "OutQuad")
			local s = soundManager:PlaySound3D("files/sounds/rolly.mp3", 335.25213623047, 177.31280517578, 1019.5405883789, false, "sounds");
			setSoundMaxDistance(s, 50);
			attachElements(s, self.ele.rolly)
			
			destroyElement(so)
			
			motionBlur:AddBlur(5000, 0.005)
		end
	end
	
	self.chasePlayerWin = function(so)
		if(getElementData(doors.doors[14], "locked") == false) then
			alien:Disappear()
			
			destroyElement(so)
			alien:SetFailingEnabled(false);
			alien:Appear(364.30459594727, 182.78366088867, 1008.3828125, 201, false, false);
			
			self.thisFunc = function()
				local s = soundManager:PlaySound3D("files/sounds/HorrorAction2.mp3", 366.99230957031, 178.576171875, 1008.3828125, false, "sounds");
				setSoundMaxDistance(s, 50);
				alien:ChaseLocalPlayer()
				motionBlur:AddEffect()
				exports["shader_flashlight_test"]:flashLightFlicker(10^10);
				exports["shader_flashlight_test"]:fadeToColor({255, 0, 0, 200}, 10^10, 5);
		
				
				
				removeEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
			end
			addEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
		end
	end
	
	self.showAlienRunning = function()
		alien:SetFailingEnabled(true);
		alien:Appear(335.95956420898, 181.49426269531, 1014.1875, 180);
		alien:MoveToPosition(336.85598754883, 157.41949462891, 1014.1875, 6500, "win");
		
		exports["shader_flashlight_test"]:flashLightFlicker(5000);
		
	end
	
	self.moveAlien1 = function()
		alien:SetFailingEnabled(false);
		alien:Appear(351.36999511719, 191.72988891602, 1014.1796875, 82);
		
		exports["shader_flashlight_test"]:flashLightFlicker(5000);
		
		self.thisFunc = function()
			--local s = soundManager:PlaySound3D("files/sounds/boom.mp3", 354.07373046875, 170.25527954102, 1019.984375, false, "sounds");
			--setSoundMaxDistance(s, 50);
			--motionBlur:AddBlur(10000)
			setTimer(function()
				local x, y, z = getElementPosition(localPlayer)
				alien:MoveToPosition(x, y, z, 1500)
				motionBlur:AddEffect()

				local x1, y1 = getElementPosition(alien.alien)
				local x2, y2 = x, y
				local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
				
				setPedRotation(alien.alien, rot+270)
				
				setTimer(function()
					local s = soundManager:PlaySound3D("files/sounds/HorrorAction2.mp3", x, y, z, false, "sounds");
					setSoundMaxDistance(s, 50);
					
					
					setTimer(function()
						motionBlur:AddBlur(5000)
					end, 1000, 1)
				end, 50, 1)
				--setSoundMaxDistance(s, 50);
			--	setTimer(function()
			--		alien:Disappear()
	--
			--	end, 3000, 1)
			end, 150, 1)
			removeEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
		end
		
		addEventHandler("onElementScreenStarted", alien.alien, self.thisFunc)
	end
	
	self.sparksFunc = function()
		effects:AddSparksWorkingRoom()
		local s = soundManager:PlaySound3D("files/sounds/fuzzle.mp3", 328.59994506836, 168.17735290527, 1015.413757324, true, "sounds");
		setSoundMaxDistance(s, 20);
		setSoundVolume(s, 0.5)
		
		
	end
	
	self.checkTriggerElements = function() self:CheckTriggerElements() end
	
	addEventHandler("onClientRender", getRootElement(), self.checkTriggerElements)

	self.triggerMarker = {};
	
	self.triggered = {}
	
	self.doorTriggerPlayed = {}
	
	self:CreateTriggerElements()
	self:CreateTrigger()
	logger:OutputInfo("[CALLING] Trigger: Constructor");
end

-- EVENT HANDLER --
