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

function WinText:Constructor(bBool)
	ego:Stop();
	mapLoader:DestroyEverything()
	exports["shader_flashlight_test"]:stopFade();
		
	setElementPosition(localPlayer, 0, 0, 0)
	setElementFrozen(localPlayer, true);
	
	self.renderFunc = function()
		self:Render()
	end

	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	
	if(bBool == false) then
		soundManager:SetCategoryVolume("sounds", 1);
		soundManager:PlaySound("files/sounds/failed.ogg", false, "sounds");
		
		setTimer(function()
			mainMenu:Show();
			messageBox:Show("You failed. The alien killed you.\nRooms visited: "..doors.doorsOpened.." / "..(#doors.doors-3), {255, 255, 255}, {255, 0, 0}, 10000)
			removeEventHandler("onClientRender", getRootElement(), self.renderFunc)
	
		end, 5000, 1)
	else
		messageBox:Show("You made it! Thanks for Playing!\nRooms visited: "..doors.doorsOpened.." / "..(#doors.doors-3), {255, 255, 255}, {0, 255, 0}, 10000)
		removeEventHandler("onClientRender", getRootElement(), self.renderFunc)
		mainMenu:Show();
			
	end
	
	
	logger:OutputInfo("[CALLING] WinText: Constructor");
end

-- EVENT HANDLER --
