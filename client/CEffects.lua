-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: Effects.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Effects = {};
Effects.__index = Effects;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Effects:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// AddSparksWorkingRoom/////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Effects:AddSparksWorkingRoom()
	self.pos = {328.59994506836, 168.17735290527, 1015.4137573242}
		
	table.insert(self.timer, setTimer(function()
		fxAddSparks(self.pos[1], self.pos[2], self.pos[3], 0, -3, 2, 1, 15, 0, 0, 0, false, 5, 4)
	end, 100, -1))

end


-- ///////////////////////////////
-- ///// RenderLogo 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Effects:RenderLogo()
	local sx, sy = guiGetScreenSize()
	local aesx, aesy = 1600, 900
	dxDrawText("SCP-049", 1393/aesx*sx, 843/aesy*sy, 1600/aesx*sx, 900/aesy*sy, tocolor(255, 255, 255, 255), (0.4)/(aesx+aesy)*(sx+sy), messageBox.font, "center", "center", false, false, true, false, false)

	
	-- Render Red Effect
	

		setFogDistance(-50/255*self.redEffect)
		
		setSkyGradient(self.redEffect, 0, 0, self.redEffect, 0, 0)

	if(self.reversed == true) then
		if(self.redEffect > 0) then
			self.redEffect = self.redEffect-0.5
		end
	end
end

-- ///////////////////////////////
-- ///// AddRedEffect 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Effects:AddRedEffect(time)
	self.redEffect = 255
	
	self.reversed = false
	
	setTimer(function()
		self.reversed = true;
	end, time, 1)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Effects:Constructor(...)
	self.timer = {}
	
	self.cops = {
		createObject(3092, 329.87377929688, 153.00994873047, 1015.1619262695, 0, 0, 9),
		createObject(3092, 329.02850341797, 153.95104980469, 1015.1619262695, 0, 0, 149),
		createObject(3092, 328.59228515625, 151.87471008301, 1015.1619262695, 0, 0, 220),
		createObject(3092, 326.623046875, 153.009765625, 1015.1619262695, 0, 0, 229),
		createObject(3092, 328.25897216797, 155.86584472656, 1015.1619262695, 0, 0, 229),
	}
	
	for index, cop in pairs(self.cops) do
		setElementInterior(cop, getElementInterior(localPlayer))
		setElementDimension(cop, getElementDimension(localPlayer))
	end

	
	self.reversed = false;
	self.redEffect = 0;
	
	--self:AddCopSparks()
	
	setInteriorSoundsEnabled(false)
	showPlayerHudComponent("all", false)
	showChat(false)

	addEventHandler("onClientRender", getRootElement(), function() self:RenderLogo() end)
	logger:OutputInfo("[CALLING] Effects: Constructor");
end

-- EVENT HANDLER --
