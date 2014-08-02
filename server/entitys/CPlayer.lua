-- ###############################
-- ## Project: MTA:scp-088		##
-- ## Name: CPlayer				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Player = {};
Player.__index = Player;

-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////



-- ///////////////////////////////
-- ///// getIP          	//////
-- ///////////////////////////////

function Player:GetIP()
	return getPlayerIP(self);
end


-- ///////////////////////////////
-- ///// getSerial         	//////
-- ///////////////////////////////

function Player:GetSerial()
	return getPlayerSerial(self);
end

-- ///////////////////////////////
-- ///// getName         	//////
-- ///////////////////////////////

function Player:GetName()
	return getPlayerName(self);
end

-- ///////////////////////////////
-- ///// getPing         	//////
-- ///////////////////////////////

function Player:GetPing()
	return getPlayerPing(self);
end

-- ///////////////////////////////
-- ///// getVehicle         //////
-- ///////////////////////////////

function Player:GetVehicle()
	return getPedOccupiedVehicle(self);
end

-- ///////////////////////////////
-- ///// getPos				//////
-- ///////////////////////////////

function Player:GetPos()
	return gtElementPosition(self);
end

-- ///////////////////////////////
-- ///// setPos				//////
-- ///////////////////////////////

function Player:SetPos(...)
	return setElementPosition(self, ...);
end

-- ///////////////////////////////
-- ///// setInt				//////
-- ///////////////////////////////

function Player:SetInt(...)
	return setElementInterior(self, ...);
end

-- ///////////////////////////////
-- ///// getInt				//////
-- ///////////////////////////////

function Player:GetInt()
	return getElementInterior(self);
end

-- ///////////////////////////////
-- ///// setDim				//////
-- ///////////////////////////////

function Player:SetDim(...)
	return setElementDimension(self, ...);
end

-- ///////////////////////////////
-- ///// getDim				//////
-- ///////////////////////////////

function Player:GetDim()
	return getElementDimension(self);
end

-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////



-- ///////////////////////////////
-- ///// WarpInto         	//////
-- ///////////////////////////////

function Player:WarpInto(vehicle, ...)
	self.vehicle = vehicle
	return warpPedIntoVehicle(self, vehicle, ...);
end

-- ///////////////////////////////
-- ///// TriggerEvent       //////
-- ///////////////////////////////

function Player:TriggerEvent(eventname, ...)
	return triggerClientEvent(self, eventname, self, ...);
end

-- ///////////////////////////////
-- ///// SendMapContent      //////
-- ///////////////////////////////

function Player:SendMapContent(dim)
	return mapLoader:LoadResourceMap(self, dim);
end	

-- SET ID
function Player:SetID(iID)
	self.iID	= iID;
end

-- GET ID
function Player:GetID()
	return self.iID
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Player:constructor()
	logger:OutputInfo("[CALLING] Player: Constructor");
	
end

-- ///////////////////////////////
-- ///// destructor 		//////
-- ///////////////////////////////

function Player:destructor()

end

-- EVENT HANDLER --
registerElementClass("player", Player);
