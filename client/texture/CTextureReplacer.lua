-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: TextureReplacer.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

TextureReplacer = {};
TextureReplacer.__index = TextureReplacer;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function TextureReplacer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// ReplaceColt 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function TextureReplacer:ReplaceColt()
	local dff = engineLoadDFF ("files/models/colt.dff", 346);
	engineReplaceModel (dff, 346)

end

-- ///////////////////////////////
-- ///// ImportAlien 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function TextureReplacer:ImportAlien()

	local txd = engineLoadTXD("files/models/alien.txd");
	engineImportTXD (txd, 61)
	
	local dff = engineLoadDFF ("files/models/alien.dff", 61);
	engineReplaceModel (dff, 61)

end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function TextureReplacer:Constructor(...)
	self:ReplaceColt();
	self:ImportAlien()
	
	logger:OutputInfo("[CALLING] TextureReplacer: Constructor");
end

-- EVENT HANDLER --
