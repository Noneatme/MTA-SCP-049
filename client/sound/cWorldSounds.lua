-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: WorldSounds.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

WorldSounds = {};
WorldSounds.__index = WorldSounds;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function WorldSounds:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// GenerateSounds		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function WorldSounds:GenerateSounds()
	self.soundEle		= {}
	
	soundManager:SetCategoryVolume("worldsounds", 0.7)
	
	for soundName, positions in pairs(self.sounds) do
		
		self.soundEle[soundName] = {};
		
		for _, position in pairs(positions) do
			local x, y, z, maxDistance	= position[1], position[2], position[3], position[4];
			
			self.soundEle[soundName][x..","..y..","..z] = soundManager:PlaySound3D(self.pfad..soundName, x, y, z, true, "worldsounds");
			
			local snd = self.soundEle[soundName][x..","..y..","..z];
			setSoundMaxDistance(snd, maxDistance)
			setElementDimension(snd, getElementDimension(localPlayer))
			setElementInterior(snd, getElementInterior(localPlayer));
			
			if(position[5]) then
				setSoundVolume(snd, position[5]);
			end
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function WorldSounds:Constructor(...)
	self.pfad	= "files/sounds/world/";

	self.sounds	=
	{
		["air_conditioner.ogg"] = 
		{ 
			{359.91036987305, 178.57553100586, 1021.915222168, 15},
			{345.45791625977, 173.95973205566, 1019.984375, 15},
		},
		["computer_noise.ogg"] =
		{
			{355.43731689453, 162.57208251953, 1019.984375, 10, 0.1},
			{331.24600219727, 177.75874328613, 1019.984375, 10, 0.1},
			{374.52728271484, 188.23300170898, 1008.3893432617, 10, 0.1},
			{361.6067199707, 159.35722351074, 1008.3828125, 10, 0.1},
			{361.87576293945, 203.85961914063, 1008.3828125, 10, 0.1},
			{355.07931518555, 209.84532165527, 1008.3828125, 10, 0.1},
			{331.29708862305, 174.18290710449, 1014.1875, 10, 0.1},
			{349.11163330078, 161.76977539063, 1014.1875, 10, 0.1},
		},
	};
	
	self:GenerateSounds();
	
	logger:OutputInfo("[CALLING] WorldSounds: Constructor");
end

-- EVENT HANDLER --
