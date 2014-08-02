-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Alien.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Alien = {};
Alien.__index = Alien;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Alien:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Disappear			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:Disappear(bForce)
	if(self.chasingFailing ~= true) or (bForce == true) and (isElement(self.alien)) then
		setElementPosition(self.alien, 0, 0, -100)
		
		setElementFrozen(self.alien, true)
		
		setElementAlpha(self.alien, 0);
		
		trigger.triggered[self.alien] 	= false;
		
		self.bColShapeEnabled			= true;
		
		self:StopChasing()
	
	end
end


-- ///////////////////////////////
-- ///// StopChasing		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:StopChasing()
	if(self.chasing) then
		
		self.chasing = false;
	end
end

-- ///////////////////////////////
-- ///// ChaseLocalPlayer	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:ChaseLocalPlayer(fast)
	if not(self.chasing) then
	
		if(isTimer(self.disaperTimer)) then
			killTimer(self.disaperTimer);
		end
		
		self.chasFunc = function()		
					
			if not(isElement(self.alien)) then
				killTimer(self.chaseTimer)
				self = nil;
				return
			end
			
			local x1, y1 = getElementPosition(self.alien)
			local x2, y2 = getElementPosition(localPlayer)
			local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
				
			setPedRotation(self.alien, rot+270);
			
			local w 	= "win"
			if(fast == true) then
				w = "wat"
			end
			self:MoveToPosition(x2, y2, 0, false, w);

		end
	
		self.chaseTimer = setTimer(self.chasFunc, 100, -1)
		self.chasing = true;
	end
end

-- ///////////////////////////////
-- ///// Appear				//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:Appear(x, y, z, rotation, time, chasing, bDisableColsphere)
	setElementFrozen(self.alien, false)
	
	setElementPosition(self.alien, x, y, z)
	setElementAlpha(self.alien, 250);
	setPedRotation(self.alien, rotation);
	
	if(bDisableColsphere ~= nil) then
		self.bColShapeEnabled = bDisableColsphere
	end
	
	if(time) then
		self.disaperTimer = setTimer(function()
			self:Disappear()
		end, (time or 2000), 1) 
	end
	
	if(chasing) then
		self:ChaseLocalPlayer()
	end
end

-- ///////////////////////////////
-- ///// MoveToPosition		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:MoveToPosition(x, y, z, timeToDissapear, sprint)
	local x1, y1 = getElementPosition(self.alien)
	local x2, y2 = x, y

	
	setPedControlState(self.alien, "forwards", true);
	
	if(sprint ~= "win") then
		setPedControlState(self.alien, "sprint", true);
	else
		setPedControlState(self.alien, "walk", true);
	end
	if(timeToDissapear) then
		self.disaperTimer = setTimer(function()
			setPedControlState(self.alien, "forwards", false);
			setPedControlState(self.alien, "sprint", false);
			
			self:Disappear()
			
		end, timeToDissapear, 1)
	end
end


function Alien:ColHit(id, hitElement, bDim)
	if(bDim) and (hitElement == localPlayer) then
		if(self.bColShapeEnabled) then
			-- id: 	1 - Near
			-- 		2 - Far

			if(id == 2) then -- Zu nahe gekommen?
				-- Follow
				-- FAILED!
				self:ChaseLocalPlayer(true);
				self.chasingFailing	= true;
				local x, y, z = getElementPosition(self.alien)
				
				local s = soundManager:PlaySound3D("files/sounds/rawr.ogg", x, y, z, false, "sounds");
				attachElements(s, self.alien);
		
			end
			
			if(id == 1) then
				wintext = WinText:New(false)
				alien:Disappear(true)
			end
		end
	end
end

-- ///////////////////////////////
-- ///// SetFailingEnabled	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:SetFailingEnabled(bBool)
	self.bColShapeEnabled = bBool;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:Constructor(...)
	self.bColShapeEnabled	= true;
	
	self.chasingFailing		= false;

	self.alien = createPed(61, 0, 0, -100)
	setPedVoice(self.alien, "PED_TYPE_DISABLED", "PED_TYPE_DISABLED");
	setElementInterior(self.alien, getElementInterior(localPlayer));
	setElementDimension(self.alien, getElementDimension(localPlayer));
	setElementFrozen(self.alien, false);
	
	
	self.colShape1	= createColSphere(354.07373046875, 170.25527954102, 1100.984375, 3);
	setElementInterior(self.colShape1, getElementInterior(localPlayer));
	setElementDimension(self.colShape1, getElementDimension(localPlayer));
	
	attachElements(self.colShape1, self.alien);
	
	self.colShape2	= createColSphere(354.07373046875, 170.25527954102, 1100.984375, 15);
	setElementInterior(self.colShape2, getElementInterior(localPlayer));
	setElementDimension(self.colShape2, getElementDimension(localPlayer));
	
	attachElements(self.colShape2, self.alien);
	attachElements(self.colShape1, self.alien);
	
	self.colShapeHitFunc		= function(...) self:ColHit(1, ...) end;
	self.colShapeHitFunc2		= function(...) self:ColHit(2, ...) end;
	
	addEventHandler("onClientPedDamage", self.alien, cancelEvent)
	addEventHandler("onClientColShapeHit", self.colShape1, self.colShapeHitFunc);
	addEventHandler("onClientColShapeHit", self.colShape2, self.colShapeHitFunc2);
	
	logger:OutputInfo("[CALLING] Alien: Constructor");
end

-- EVENT HANDLER --
