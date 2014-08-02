-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Doors.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Doors = {};
Doors.__index = Doors;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Doors:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// OpenDoor			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Doors:OpenDoor(index)
	if not(self.doorMoving[index])  and (getElementData(self.doors[index], "door_state") ~= true)  then
	
		if(index ~= 14) then
			local movex, movey, movez, moverx, movery, moverz = self.doorPos[index][8], self.doorPos[index][9], self.doorPos[index][10], self.doorPos[index][11], self.doorPos[index][12], self.doorPos[index][13]
			moveObject(self.doors[index], 1000, movex, movey, movez, moverx, movery, moverz, "OutBounce");
			self.doorMoving[index] = true;
			local s = soundManager:PlaySound3D("files/sounds/door_open.ogg", movex, movey, movez, false, "sounds");
			setElementInterior(s, getElementInterior(localPlayer))
			setElementDimension(s, getElementDimension(localPlayer))
			setTimer(function()
				self.doorMoving[index] = false;
				setElementData(self.doors[index], "door_state", true, false)
			end, 1000, 1)
			
			if(trigger) then
				trigger:PlayDoorTrigger(index)
			end
			
			if(self.doorOpened[index] ~= true) then
				self.doorOpened[index] = true;
				self.doorsOpened = self.doorsOpened+1;
			end
		else
			trigger:DoWin()
		end
	end
end


-- ///////////////////////////////
-- ///// CloseDoor			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Doors:CloseDoor(index)
	if not(self.doorMoving[index]) and (getElementData(self.doors[index], "door_state") == true) then
		local movex, movey, movez, moverx, movery, moverz = self.doorPos[index][1], self.doorPos[index][2], self.doorPos[index][3], self.doorPos[index][4], self.doorPos[index][5], self.doorPos[index][6]
		moveObject(self.doors[index], 1000, movex, movey, movez, moverx, movery, -90, "OutBounce");
		self.doorMoving[index] = true;
		local s = soundManager:PlaySound3D("files/sounds/door_close.ogg", movex, movey, movez, false, "sounds");
		setElementInterior(s, getElementInterior(localPlayer))
		setElementDimension(s, getElementDimension(localPlayer))
		setTimer(function()
			self.doorMoving[index] = false;
			setElementData(self.doors[index], "door_state", false, false)
		end, 1000, 1)
	end
end

-- ///////////////////////////////
-- ///// BuildDoors			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Doors:BuildDoors()

	-- x, y, z, rx, ry, rz, name, movex, movey, movez, mrx, mry, mrz
	self.doorPos = {
		[1] = {372.79998779297, 166.69999694824, 1007.4000244141, 0, 0, 180, "Staircase", 372.7998046875, 166.69921875, 1007.4000244141, 0, 0, 90},
		[2] = {365.79998779297, 189.5, 1007.4000244141, 0, 0, 360, "Laboratory 1", 365.79998779297, 189.5, 1007.4000244141, 0, 0, 90},
		[3] = {369.40582275391, 161.56640625, 1018.984375, 0, 0, 90, "Level 2 Door", 369.40582275391, 161.56640625, 1018.984375, 0, 0, 90},
		[4] = {369.19921875, 161.57421875, 1013.200012207, 0, 0, 90, "Level 1 Door", 369.19921875, 161.57421875, 1013.200012207, 0, 0, 90},
		[5] = {354.90106201172, 168.91969299316, 1018.9912109375, 0, 0, 180, "First Aid Room", 354.90106201172, 168.91969299316, 1018.9912109375, 0, 0, 90},
		[6] = {363.93719482422, 187.0627746582, 1018.984375, 0, 0, 0, "Document Deposity Room", 363.93719482422, 187.0627746582, 1018.984375, 0, 0, 90},
		[7] = {341.14440917969, 168.92028808594, 1018.9912109375, 0, 0, 180, "Unknow Room 1", 341.14440917969, 168.92028808594, 1018.9912109375, 0, 0, 90},
		
		[8] = {363.72937011719, 187.26507568359, 1013.1875, 0, 0, 0, "Conference Room 1", 363.72937011719, 187.26507568359, 1013.1875, 0, 0, 90, true},
		[9] = {332.98635864258, 183.50650024414, 1013.1875, 0, 0, 90, "Working Room 1", 332.98635864258, 183.50650024414, 1013.1875, 0, 0, 90},
		[10] = {332.90118408203, 165.54641723633, 1013.1796875, 0, 0, 90, "Working Room 2", 332.90118408203, 165.54641723633, 1013.1796875, 0, 0, 90},
		[11] = {332.96408081055, 154.06271362305, 1013.1875, 0, 0, 90, "Working Room 3", 332.96408081055, 154.06271362305, 1013.1875, 0, 0, 90},
		[12] = {344.87338256836, 156.943359375, 1013.1875, 0, 0, 0, "Toilet Room", 344.87338256836, 156.943359375, 1013.1875, 0, 0, 90, true},
		[13] = {370.80255126953, 179.0284576416, 1013.1875, 0, 0, 0, "Working Room 5", 370.80255126953, 179.0284576416, 1013.1875, 0, 0, 90},
		[14] = {391.09121704102, 174.53036499023, 1007.3828125, 0, 0, 270, "The Exit", 391.09121704102, 174.53036499023, 1007.3828125, 0, 0, -90},
	}
	
	
	for index, door in pairs(self.doorPos) do
		self.doors[index] = createObject(1533, door[1], door[2], door[3], door[4], door[5], door[6])
		setElementInterior(self.doors[index], self.int);
		setElementDimension(self.doors[index], self.dim);
		
		setElementData(self.doors[index], "door_name", door[7], false);
		setElementData(self.doors[index], "locked", true, false);
		setElementData(self.doors[index], "door_state", false, false);
		setElementData(self.doors[index], "door_index", index, false);
		
		if(door[14] == true) then
			setElementData(self.doors[index], "locked", false, false);
		--	self:OpenDoor(index);
		end
	end
end


-- ///////////////////////////////
-- ///// BuildKeys	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Doors:BuildKeys()
	self.keyPos = {
		{367.45266723633, 159.92720031738, 1008.3874511719, 0, 0, 181, "Laboratory 1", 2},
		{354.42822265625, 209.4970703125, 1008.3217773438, 0, 0, 81.5, "Staircase", 1},
		{357.50650024414, 184.00096130371, 1008.4891357422, 0, 0, 60, "Level 2 Door", 3},
		{349.99993896484, 198.98025512695, 1020.1817626953, 0, 0, 0, "First Aid Room", 5},
		{327.31771850586, 169.45837402344, 1018.9821777344, 270, 0, 120, "Document Deposity Room", 6},
		{355.79614257813, 163.48010253906, 1019.9414672852, 350, 0, 210, "Level 1 Door", 4},
		{340.77182006836, 160.39659118652, 1019.7796020508, 270, 180, 0, "Unknow Room 1", 7},
		{334.60537719727, 198.17149353027, 1013.9013671875, 0, 0, 20, "Working Room 1", 9},
		{320.79919433594, 167.0927734375, 1014.6748046875, 0, 0, 40, "Working Room 3", 11},
		{325.09194946289, 153.22113037109, 1014.2227172852, 0, 0, 60, "The Exit", 14},
	}
	
	for index, keys in pairs(self.keyPos) do
		self.keys[index] = createObject(1581, keys[1], keys[2], keys[3], keys[4], keys[5], keys[6])
		setElementInterior(self.keys[index], self.int);
		setElementDimension(self.keys[index], self.dim);
		
		setElementData(self.keys[index], "key_name", keys[7], false);
		setElementData(self.keys[index], "key_index", keys[8], false);
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Doors:Constructor(dim)
	self.doors = {}
	self.doorMoving = {};
	
	self.keys = {}

	self.int = 3;
	
	self.dim = dim;
	self:BuildDoors()
	self:BuildKeys()
	
	self.doorsOpened = 0;
	self.doorOpened = {};
	
	removeWorldModel(1502, 100, 366.69216918945, 189.46553039551, 1008.3828125, 3)
	logger:OutputInfo("[CALLING] Doors: Constructor");
	
	
end

-- EVENT HANDLER --
