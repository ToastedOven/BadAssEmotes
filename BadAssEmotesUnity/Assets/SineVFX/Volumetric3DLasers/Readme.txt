3D Volumetric Lasers
Version 1.3 (19.04.2020)


IMPORTANT NOTES:

- URP is now partially supported, check the URP.txt file
- If you don't want to use Tessellation, just replace the material shader with the same without "Tess" in its name. Or, just use prefabs for Mobile platforms
- Turn on "HDR" on your Camera, Shaders requires it
- This VFX Asset looks much better in "Linear Rendering", but there is also optimized Prefabs for "Gamma Rendering" Mode
- Image Effects are necessary in order to make a great looking game, as well as our asset. Be sure you using "Tone Mapping" and "Bloom"
- We also recommend using Deferred Rendering for better performance


HOW TO USE:

First of all, check for Demo Scene in Scenes folder. Also, there is a Prefabs folder with complete effects and parts of them.
Just Drag and Drop prefabs from "CompleteEffectPrefabs" folder into your scene. We made all Shaders very tweakable, so you can create your own unique effects.


SHADERS CONTROL:

Vertex Offset Power - basically this is a diameter of cylinder mesh used for 3D lasers, tweak it only if you using your own mesh
Final Color - Simple color tint
Final Power - Final brightness of the image, you need to lower this value if you using "Gamma Rendering" Mode

Shape Size - Overall thickness of a laser
Shape Start/End Round - Making laser look rounded and smooth
Shape Add Start/End Position - How far away from Start or End Point laser will round
Shape Cone Form - Making laser look like a sharp cone

Opacity Cutoff - Texture for dissolve effect
Opacity Remap 1 and 2 - Remapping values of previous texture

Noise - Noise texture for better visual effect
Noise Scroll Speed - Scrolling speed of a noise texture
Noise Offset Power - Control how much noise texture affects offset
Noise Add - Add value to a noise texture, making it smoother


CONSTRUCTING YOUR OWN LASER:

If you want to create your own laser from scratch, you need to grab one of the complete effects and then delete all child gameobjects
from "LaserLayers" and "StartPointEffect", "EndPointEffect" except point lights. Then delete all visual particles from "SmartWaveParticles" gameobject
and leave "ControlParticles" and "DistortionSphereParticles".

Laser Layers: Simply Drag and Drop prefabs from "Prefabs/LaserLayers" folder into this gameobject.

StartPointEffect: Drag and Drop prefabs from "Prefabs/StartPointEffect", then go to "StartPointEffect" gameobject and link all the child game objects into
corresponding variables. Also, add a point light to it.

EndPointEffect: Drag and Drop prefabs from "Prefabs/EndPointEffect", then go to "EndPointEffect" gameobject and link all the child game objects into
corresponding variables. Also, add a point light to it and link one of the lasers to "Get End Point Position From" variable. 

SmartWaveParticles: Drag and Drop Visual particles prefabs from "Prefabs/SmartWaveParticles", then go to "SmartWaveParticles" gameobject and link all the child game objects into
corresponding variables. Also, add a point light to it.




Support email "sinevfx@gmail.com"