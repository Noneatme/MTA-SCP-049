-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: SpawnManager				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

SpawnManager = {};
SpawnManager.__index = SpawnManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function SpawnManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// JoinPlayer 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function SpawnManager:JoinPlayer(player)
	if not(player) then
		player = source;
	end
	
	enew(player, Player)
	spawnPlayer(player, self.spawnPos[1], self.spawnPos[2], self.spawnPos[3], 90, 60, 3, self.lastID);
	
	fadeCamera(player, true);
	setCameraTarget(player, player);
	setElementAlpha(player, 0)
	
	giveWeapon(player, 22, 999, true);
	
	player:SendMapContent(self.lastID);
	
	triggerClientEvent(player, "onDimensionGet", player, self.lastID);
	self.lastID = self.lastID+1;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function SpawnManager:Constructor(...)
	self.joinFunc = function(...) self:JoinPlayer(...) end;
	
	self.spawnPos = {390.04821777344, 173.9736328125, 1008.3828125};
	
	self.lastID = 1;
	
	addEvent("onPlayerJoin2", true);
	
	addEventHandler("onPlayerJoin2", getRootElement(), self.joinFunc);

	logger:OutputInfo("[CALLING] SpawnManager: Constructor");
end

-- EVENT HANDLER --
