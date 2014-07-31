-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: MessageBox.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MessageBox = {};
MessageBox.__index = MessageBox;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MessageBox:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MessageBox:Render()
	if(self.stopped == true) then
		if(self.currentAlpha > 0) then
			self.currentAlpha = self.currentAlpha-1;
		else
			removeEventHandler("onClientRender", getRootElement(), self.renderFunc)
		end
	else
		if(self.currentAlpha < self.maxAlpha) then
			self.currentAlpha = self.currentAlpha+1;
		end
	end
	local sx, sy = guiGetScreenSize()
	local aesx, aesy = 1600, 900
	dxDrawRectangle(255/aesx*sx, 49/aesy*sy, 1097/aesx*sx, 189/aesy*sy, tocolor(self.boxColor[1], self.boxColor[2], self.boxColor[3], self.currentAlpha), true)
	dxDrawText(self.title, 255/aesx*sx, 47/aesy*sy, 1351/aesx*sx, 238/aesy*sy, tocolor(self.color[1], self.color[2], self.color[3], self.currentAlpha*4), 0.5/(aesx+aesy)*(sx+sy), self.font, "center", "center", false, false, true, false, false)
end

-- ///////////////////////////////
-- ///// Show		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MessageBox:Show(title, textColor, boxColor, time)
	self.title = title;
	
	if(textColor) then
		self.color = textColor;
	else
		self.color = {255, 255, 255};
	end
	
	if(boxColor) then
		self.boxColor = boxColor;
	else
		self.boxColor = {255, 0, 0}
	end
	
	if(isTimer(self.stopTimer)) then
		killTimer(self.stopTimer)
	end
	self.stopped = false;
	self.currentAlpha = 0;
	
	self.stopTimer = setTimer(self.stopFunc, (time or 5000), 1);
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
end

-- ///////////////////////////////
-- ///// Stop		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MessageBox:Stop()
	self.stopped = true;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MessageBox:Constructor(...)
	self.renderFunc = function() self:Render() end
	self.stopFunc = function() self:Stop() end
	
	self.stopped = false;
	self.maxAlpha = 60;
	self.currentAlpha = 0;
	
	self.font = dxCreateFont("files/fonts/FEASFBRG.ttf", 60)
	
	logger:OutputInfo("[CALLING] MessageBox: Constructor");
end

-- EVENT HANDLER --
