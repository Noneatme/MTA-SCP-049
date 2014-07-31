Resource: Shader_flashlight_test v0.8.5
Video: http://www.youtube.com/watch?v=lA7i0OsQcUM
contact: knoblauch700@o2.pl

Update v0.8.5
-Added flashlight object streaming in/out.
-The flashlight works in interiors now.
-Rewritten some partsof hlsl and lua code.

Update v0.8

-Added main Effect streaming in/out on max distance.
-Workaround for effect flashing onStart/stream in.
-Added fake bumps variable.
-Flashlight rays visible after max distance is reached.
-Fixed not switching off the flashlight when player is streamed out.

Description:

This is the flashlight shader i've been making.
It's a fully functional version. All you need is
to start the resource and you will see the explanation
on how to use in the chatbox.

The effect is loosely based on the discoball resource.
The shader projects a light effect on nearby world, vehicle 
and ped textures.

The original flashlight model comes from
http://www.sharecg.com/v/29667/related/5/3D-Model/Flashlight-model+texture
Slightly altered and converted.

There are few downsides of the method i used:

-If there are more than 2 flashlights streamed in, the
effects might lag. It is due to the fact that a single light 
effect is applied as a separate layered effect.I haven't 
decided on how to solve this. And it might not be possible 
with shader model 2.0. 

Also it works poorly on custom maps - the objects used 
should not be rotated.

If you notice other issues please leave it in the
comment section.

Also you will be needing bone_attach resource - so
place it along with flashlight resource in resources
folder.