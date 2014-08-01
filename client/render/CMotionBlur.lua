-- #######################################
-- ## Project: MTA:scp-088				##
-- ## Name: MotionBlur.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MotionBlur = {};
MotionBlur.__index = MotionBlur;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MotionBlur:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// RenderShader		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MotionBlur:RenderShader()
	local x2, y2, z2 = getCameraMatrix()
	
	local d = getDistanceBetweenPoints3D(self.x1, self.y1, self.z1, x2, y2, z2);
	
	local sx, sy = guiGetScreenSize()
	
	sx2, sy2 = sx/2, sy/2
	
	local dx = self.x1 - x2
	local dy = self.y1 - y2
	local dz = self.z1 - z2
	
	

	
	dxSetShaderValue( self.screenShader, "BlurAmount", d*self.multiplier );
	dxSetShaderValue( self.screenShader, "Angle", findRotation(dx, dx, dx, dz)) -- Fail code, but gives a nice effect
	
	dxSetRenderTarget();

	dxUpdateScreenSource(self.screenSrc );
	dxDrawImage( 0-self.ammount, 0, sx+self.ammount*2, sy, self.screenShader );
	
	self.x1, self.y1, self.z1 = getCameraMatrix()
	
	
	if(self.reversed == true) then
		if(self.multiplier > 0) then
			self.multiplier = self.multiplier-0.0001
		else
			self.multiplier = 0;
		end
	end
	
	if(self.ammount > 0) then
		self.ammount = self.ammount-7.5;
	else
		self.enabled = false;
	end
end

-- ///////////////////////////////
-- ///// AddEffect	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MotionBlur:AddEffect()

	local sx, sy = guiGetScreenSize()
	
	self.ammount = 500/1600*sx
end


-- ///////////////////////////////
-- ///// AddBlur	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MotionBlur:AddBlur(seconds, blurLevel)
	if not(blurLevel) then
		blurLevel = 0.02;
	end
	
	self.multiplier = blurLevel;
	
	self.reversed = false;

	
	setTimer(function()
		self.reversed = true;
	end, (seconds or 5000), 1)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MotionBlur:Constructor(...)
	self.renderFunc = function() self:RenderShader() end
	
	self.x1, self.y1, self.z1 = getCameraMatrix()
	
	local sx, sy = guiGetScreenSize()
	
	self.screenShader = dxCreateShader( "files/shaders/motion.fx" );
	self.screenSrc = dxCreateScreenSource( sx, sy );
	
	self.multiplier = 0;
	
	self.reversed = true;
	self.ammount = 0;
	
	dxSetShaderValue(self.screenShader, "ScreenTexture", self.screenSrc );
	
	addEventHandler( "onClientPreRender", getRootElement( ), self.renderFunc );
	
	logger:OutputInfo("[CALLING] MotionBlur: Constructor");
end

-- EVENT HANDLER --



function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end