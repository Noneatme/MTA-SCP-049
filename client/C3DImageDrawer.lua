-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: ImageDrawer.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

ImageDrawer = {};
ImageDrawer.__index = ImageDrawer;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function ImageDrawer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// renderImage: void	//////
-- ///////////////////////////////

function ImageDrawer:RenderImages()
	for index, image in pairs(self.images) do
		local x, y, z = getElementPosition(localPlayer)
		local x2, y2, z2 = image[4], image[5], image[6]
		local x3, y3, z3 = image[1], image[2], image[3]
		local used = true;
		
		x2, y2, z2 = (x3+x2)/2, (y3+y2)/2, ((z3+z2)/2)+50;
		
		if(image[7] and image[8] and image[9]) then
			x2, y2, z2 = image[7], image[8], image[9]
			used = false
		end
		
		distance = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2-50);
		if(used == false) then
			distance = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2);
		end
		
		local a = 255/distance*(image[10] or 10)

		if(a > 485) then
			a = 485;
		elseif(a <= 260) then
			a = 0
		end

		dxDrawMaterialLine3D(image[1], image[2], image[3], image[4], image[5], image[6], self.imageTex[index], (image[11] or 0.9), tocolor(a, a, a, a), x2, y2, z2);
	end
end

-- ///////////////////////////////
-- ///// drawImage	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function ImageDrawer:DrawImage(path, sx, sy, sz, ex, ey, ez, fx, fy, fz, ...)
	self.images[self.lastIndex] = {sx, sy, sz, ex, ey, ez, fx, fy, fz, ...};
	self.imageTex[self.lastIndex] = dxCreateTexture(path);
	
	self.lastIndex = self.lastIndex+1;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function ImageDrawer:Constructor(...)
	self.images = {};
	self.imageTex = {};
	
	self.lastIndex = 1;
	
	
	self.renderFunc = function() self:RenderImages() end;
	
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	logger:OutputInfo("[CALLING] ImageDrawer: Constructor");
end

-- EVENT HANDLER --
