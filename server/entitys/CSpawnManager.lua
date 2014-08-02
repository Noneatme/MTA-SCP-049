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
	
	if not(player.iID) then
		enew(player, Player)
		spawnPlayer(player, self.spawnPos[1], self.spawnPos[2], self.spawnPos[3], 90, 60, 3, player:GetID());
		giveWeapon(player, 22, 999, true);
	end
	
	local id = self.lastID;
	
	if(player:GetID()) then
		id = player:GetID();
	else	
		self.lastID = self.lastID+1;
	end
	
	player:SendMapContent(id);
	player:SetID(id);

end

-- ///////////////////////////////
-- ///// SpawnPlayer 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function SpawnManager:SpawnPlayer(player)

	spawnPlayer(player, self.spawnPos[1], self.spawnPos[2], self.spawnPos[3], 90, 60, 3, player:GetID());
	
	fadeCamera(player, true);
	setCameraTarget(player, player);
	setElementAlpha(player, 0)
	
	giveWeapon(player, 22, 999, true);
	
	triggerClientEvent(player, "onDimensionGet", player, player:GetID());
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function SpawnManager:Constructor(...)
	self.joinFunc = function(...) self:JoinPlayer(...) end;
	self.joinSpawnFunc	= function(...) self:SpawnPlayer(...) end;
	self.spawnPos = {390.04821777344, 173.9736328125, 1008.3828125};
	
	self.lastID = 1;
	
	addEvent("onPlayerJoin2", true);
	addEvent("onPlayerJoinSpawn", true);
	
	addEventHandler("onPlayerJoin2", getRootElement(), self.joinFunc);
	addEventHandler("onPlayerJoinSpawn", getRootElement(), self.joinSpawnFunc);

	logger:OutputInfo("[CALLING] SpawnManager: Constructor");
end

-- EVENT HANDLER --
