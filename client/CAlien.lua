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

function Alien:Disappear()
	setElementPosition(self.alien, 354.07373046875, 170.25527954102, 1100.984375)
	
	setElementFrozen(self.alien, true)
	
	setElementAlpha(self.alien, 0);
	
	trigger.triggered[self.alien] = false;
	
	self:StopChasing()
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

function Alien:ChaseLocalPlayer()
	if not(self.chasing) then
	
		self.chasFunc = function()		
			local x1, y1 = getElementPosition(self.alien)
			local x2, y2 = getElementPosition(localPlayer)
			local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
				
			setPedRotation(self.alien, rot+270);
			
			self:MoveToPosition(x2, y2, 0, false, "win");
		end
	
		self.chaseTimer = setTimer(self.chasFunc, 100, -1)
		self.chasing = false;
	end
end

-- ///////////////////////////////
-- ///// Appear				//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:Appear(x, y, z, rotation, time, chasing)
	setElementFrozen(self.alien, false)
	
	setElementPosition(self.alien, x, y, z)
	setElementAlpha(self.alien, 250);
	setPedRotation(self.alien, rotation);
	
	if(time) then
		setTimer(function()
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
		setTimer(function()
			setPedControlState(self.alien, "forwards", false);
			setPedControlState(self.alien, "sprint", false);
			
			self:Disappear()
		end, timeToDissapear, 1)
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Alien:Constructor(...)
	self.alien = createPed(61, 354.07373046875, 170.25527954102, 1100.984375)
	setElementInterior(self.alien, getElementInterior(localPlayer));
	setElementDimension(self.alien, getElementDimension(localPlayer));
	setElementFrozen(self.alien, false);
	
	addEventHandler("onClientPedDamage", self.alien, cancelEvent)
	
	logger:OutputInfo("[CALLING] Alien: Constructor");
end

-- EVENT HANDLER --
