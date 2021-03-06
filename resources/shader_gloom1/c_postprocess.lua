
local scx, scy = guiGetScreenSize()

-----------------------------------------------------------------------------------
-- Le settings
-----------------------------------------------------------------------------------
Settings = {}
Settings.var = {}
Settings.var.Vignette=0.47
---------------------------------
-- PS version
---------------------------------
function vCardPSVer()
 local info=dxGetStatus()
    for k,v in pairs(info) do
		if string.find(k, "VideoCardPSVersion") then
		smVersion=tostring(v)
		end
    end
	return tonumber(smVersion)
end

local removeList = {
						"",							-- unnamed
						"basketball2","skybox_tex",	   				    -- other
						"muzzle_texture*",								-- guns
						"font*","radar*",								-- hud
						--"vehicle*", "?emap*", "?hite*",				-- vehicles
						--"*92*", "*wheel*", "*interior*",				-- vehicles
						--"*handle*", "*body*", "*decal*",				-- vehicles
						--"*8bit*", "*logos*", "*badge*",				-- vehicles
						--"*plate*", "*sign*", "*headlight*",			-- vehicles
						"vehiclegeneric256","vehicleshatter128", 		-- vehicles
						"*shad*",										-- shadows
						"coronastar","coronamoon","coronaringa",		-- coronas
						"lunar",										-- moon
						--"tx*",											-- grass effect
						"lod*",											-- lod models
						"cj_w_grad",									-- checkpoint texture
						"*cloud*",										-- clouds
						"*smoke*",										-- smoke
						"sphere_cj",									-- nitro heat haze mask
						"particle*",									-- particle skid and maybe others
						"water*", "sw_sand", "coral",					-- sea
						"boatwake*","splash_up","carsplash_*",			-- splash
						"gensplash","wjet4","bubbles","blood*",			-- splash
						--"sm_des_bush*", "*tree*", "*ivy*", "*pine*",	-- trees and shrubs
						--"veg_*", "*largefur*", "hazelbr*", "weeelm",
						--"*branch*", "cypress*", "plant*", "sm_josh_leaf",
						--"trunk3", "*bark*", "gen_log", "trunk5","veg_bush2",
						"fist","*icon",
					}
					
----------------------------------------------------------------
-- onClientResourceStart
----------------------------------------------------------------
addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.3.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		if (vCardPSVer()<2) then outputChatBox(vCardPSVer..' Shader model 2 not supported') return end
		
		-- Create things
        myScreenSource = dxCreateScreenSource( scx, scy )
		noiseTex = dxCreateTexture("noise64.tga")
		textureVignette = dxCreateTexture ( "vignette1.dds" )
		
		imageGrainShader,tecName = dxCreateShader( "grain.fx" ) -- not present in current version but still nice
		outputDebugString( "imageGrainShader is using technique " .. tostring(tecName) )
		
		creepyLightShader = dxCreateShader ( "creepy_light.fx",0,0,false,"world,vehicle,object,ped,other")
		nullShader = dxCreateShader("shader_clear.fx")
		
		
		
		-- Check everything is ok
		bAllValid = myScreenSource and noiseTex and imageGrainShader and nullShader and textureVignette and creepyLightShader

		if not bAllValid then
			outputChatBox( "Could not create some things. Please use debugscript 3" )
			else
			-- the settings
			
			dxSetShaderValue( imageGrainShader, "TEX1", noiseTex) 
			dxSetShaderValue( imageGrainShader,"fGrainFreq",500.0)		-- image grain frequency, for some reason high values cause shadow flickering
			dxSetShaderValue( imageGrainShader,"fGrainScale",0.075)						-- grain effect scale
			dxSetShaderValue( imageGrainShader,"gColorize",0.8,0.521,0.247)  -- the color of the screen.
			dxSetShaderValue( imageGrainShader,"isBlackWhite",false) -- can't colorize without it	
			
			dxSetShaderValue( creepyLightShader,"lightColor",1,1,0.9,1)
			dxSetShaderValue( creepyLightShader,"DistFade",5, 1)  -- min and max distance the effect fades / all 
			dxSetShaderValue( creepyLightShader,"lightColor",1,1,0.9,1)
			dxSetShaderValue( creepyLightShader,"texColor",0.7,0.6,0.6,1)
			dxSetShaderValue( creepyLightShader,"isLightDir",false) -- I was good for the flashlight but here it is rather pointless
			dxSetShaderValue( creepyLightShader,"lightDirAcc", 1) -- Light Dir accuracy
			dxSetShaderValue( creepyLightShader,"isFakeBump",true)  -- draw fakebumps
			dxSetShaderValue( creepyLightShader,"rc",0.0018,0.0015)  -- fake bump parameter
			dxSetShaderValue( creepyLightShader,"isDiffuse",true) -- draw GTA shadows and lights 
			dxSetShaderValue( creepyLightShader,"stBrightness",0.03) -- brightness of everything beyound the "draw distance"
			
			engineApplyShaderToWorldTexture ( nullShader,"vehiclegeneric256")
			engineApplyShaderToWorldTexture ( nullShader,"vehicleshatter128")
				
			engineApplyShaderToWorldTexture ( creepyLightShader, "*" )
			for _,removeMatch in ipairs(removeList) do
				engineRemoveShaderFromWorldTexture ( creepyLightShader, removeMatch )	
			end		

			local list = {
				["water_cool*"] = true,
			}
			for index, key in pairs(list) do
				engineApplyShaderToWorldTexture(creepyLightShader, index)
			end

		end
	end
)


function setBrightness(brightness)
	return dxSetShaderValue( creepyLightShader,"stBrightness", brightness)
end

-----------------------------------------------------------------------------------
-- onClientHUDRender
-----------------------------------------------------------------------------------
addEventHandler( "onClientPreRender", root,
    function()
		if not Settings.var then
			return
		end
        if bAllValid then
			-- Reset render target pool
			RTPool.frameStart()

			-- Update screen
			dxUpdateScreenSource( myScreenSource )

			-- Start with screen
			local current = myScreenSource
			current = applyImageGrain( current)

			-- When we're done, turn the render target back to default
			dxSetRenderTarget()

			dxDrawImage( 0, 0, scx, scy, current)
			dxDrawImage( 0, 0, scx, scy, textureVignette, 0, 0, 0, tocolor(255,255,255,Settings.var.Vignette*255) )
			
        end
    end
)


-----------------------------------------------------------------------------------
-- Apply the different stages
-----------------------------------------------------------------------------------

function applyImageGrain( Src)
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( imageGrainShader, "TEX0", Src )
	dxDrawImage( 0, 0, mx,my, imageGrainShader )
	return newRT
end

-----------------------------------------------------------------------------------
-- Pool of render targets
-----------------------------------------------------------------------------------
RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		outputDebugString( "creating new RT " .. tostring(mx) .. " x " .. tostring(mx) )
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end
