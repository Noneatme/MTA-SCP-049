-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Remover.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Remover = {};
Remover.__index = Remover;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Remover:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// RemoveObjects 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Remover:RemoveObjects()
	-- removing level 1 room top
	--removeWorldModel(2008, 10, 326.65228271484, 187.49096679688, 1013.1875, 3)
	--removeWorldModel()
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Remover:Constructor(...)
	self:RemoveObjects()
	
	logger:OutputInfo("[CALLING] Remover: Constructor");
end

-- EVENT HANDLER --
