-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: WinText.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

WinText = {};
WinText.__index = WinText;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function WinText:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render				//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function WinText:Render()
	local sx, sy = guiGetScreenSize()
	
	dxDrawRectangle(0, 0, sx, sy, tocolor(0, 0, 0, 255));
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function WinText:Constructor(...)
	self.renderFunc = function()
		self:Render()
	end

	soundManager:SetCategoryVolume("music", 0);
	soundManager:SetCategoryVolume("sounds", 0);
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	
	messageBox:Show("You made it! Thanks for Playing!\nRooms visited: "..doors.doorsOpened.." / "..(#doors.doors-1), {255, 255, 255}, {0, 255, 0}, 999999999)
	logger:OutputInfo("[CALLING] WinText: Constructor");
end

-- EVENT HANDLER --
