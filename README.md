# Simple HLSL shaders for MonoGame
This is simple and bad-quality HLSL shaders for MonoGame, written based on template of shader, which is created when adding a new effect in MGCB Editor. All shaders has tested only in MonoGame 3.8! It's not known how they will work in another versions. And in another programs...

## How to use
All examples is based on the project template.
### Load
1. In Game1 (or named you main class) declare a object of the "Effect" class. Like this:
```cs
public class Game1 : Game //your main class
{
    Effect effect;
    //some code
}
```
2. In `LoadContent()` method load the needed shader:
```cs
effect = Content.Load<Effect>("Name_of_your_shader_without_file_extension");
```
### Change parameters and apply shader (one-pass)
All sprites drawing between SpriteBatch.Begin() and SpriteBatch.End() methods in `Draw(GameTime gameTime)` method. Apply the shader to **each sprites** looks like that:
```cs
_spriteBatch.Begin(SpriteSortMode.Immediate);
effect.Parameters["intensity"].SetValue(0.45f); //change the parameter
effect.CurrentTechnique.Passes[0].Apply(); //apply first pass of the shader
//drawing your sprites
_spriteBatch.End();
```
#### If you wants to apply shader to all screen...
1. In Game1 (or named you main class) add a object of the "RenderTarget2D" class. Like this:
```cs
public class Game1 : Game //your main class
{
    Effect effect;
    RenderTarget2D target;
    //some code
}
```
2. And in `Initialize()` method:
```cs
target = new RenderTarget2D(_graphics.GraphicsDevice, _graphics.PreferredBackBufferWidth, _graphics.PreferredBackBufferHeight);
```
It is understood that the object \_graphics of the "GraphicsDeviceManager" class has already been automatically created.
3. Before the `SpriteBatch.Begin()` method just set new render target. Here the shader will not apply!
```cs
_graphics.GraphicsDevice.SetRenderTarget(target);
//drawing all your sprites
```
The meaning of action is get frame as a texture and then apply shader to it. Image is will not be displayed on the screen, it will be saved in this object. Accordingly, you need draw this render target as usual texture with shader. But before that you need set render target to null:
```cs
_graphics.GraphicsDevice.SetRenderTarget(null);
//drawing render target with shader, it can be used as a texture, no difference.
```
### Second pass
Using render targets, you can apply shaders many times, everytime choosing another render target. You need to draw the result of the applied shader to another render target and draw and draw it with an applied by another shader/pass. Pass is selected where is the number (first pass is 0):
```cs
effect.CurrentTechnique.Passes[1].Apply();
```
## Shaders List
|Shader|Pass 0|Pass 1|
|:-|:-:|:-:|
|Pixelize|+||
|LCD|+||
|Black & White|+||
|Chromatic Aberration|+||
|Vignette|+||
|Noise|+||
|Box Blur|+|+|
|Gaussian Blur|+|+|
____
### Pixelize
Customizable texture pixelation effect. Doesn't blend pixels! Displays only the first pixel in the "block" of pixels, therefore it may look sharply.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|horizontal_blocks|-|Texture width|None (0)|Number of displayed pixel by horizontal|+|
|int|vertical_blocks|-|Texture height|None (0)|Number of displayed pixel by vertical|+|
#### Image
![pixelize](https://user-images.githubusercontent.com/76843479/110298780-2e0ede80-801f-11eb-9fa4-c093567c3198.png)

____
### LCD
Simple LCD-effect.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|250|Width of texture in pixels|-|
|int|height|-|Texture height|250|Height of texture in pixels|-|
#### Image
![lcd](https://user-images.githubusercontent.com/76843479/110298857-3f57eb00-801f-11eb-8fd6-c91dbb75fd61.png)
#### Known issues
- The first vertical line of pixels duplicates the color of second line.
____
### Black & White
Simple black and white effect with changing intensity.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|float|intensity|0|1|0|Intensity of the effect|+|
#### Image
![black and white](https://user-images.githubusercontent.com/76843479/110298875-44b53580-801f-11eb-97a7-0414913c9e3e.png)
#### Known issues
- At negative values, the image colors becomes too contrasting.
- At values larger than 1, colors are distorted.
____
### Chromatic Aberration
Shifts green and blue channels on selected count of pixels.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)|Width of texture in pixels|+|
|float|intensity|-∞|∞|0|Offset channels by a specified number of pixels|+|
#### Image
![chromatic aberration](https://user-images.githubusercontent.com/76843479/110298902-4aab1680-801f-11eb-9ece-699576f88e7c.png)
____
### Vignette
Adding vignette to edges of image with changing intensity (smaller value - more intensity).
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|float|intensity|0|∞|0|The higher the value, the more invisible the vignette|+|
#### Image
![vignette](https://user-images.githubusercontent.com/76843479/110298920-4f6fca80-801f-11eb-8502-0f6e3994893c.png)
#### Known issues
- At small values the center of image becomes too bright.
____
### Noise
Generates black noise on the image with changing visibility.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|seed|-∞|∞|0|Seed for new random values|-|
|float|intensity|0|1|0|Opacity of the noise|+|
#### Image
![noise](https://user-images.githubusercontent.com/76843479/110298936-54cd1500-801f-11eb-9276-816ac681567b.png)
#### Known issues
- At negative values, the noise becomes white.
- Sometimes appear flickering weird rings.
____
### Box Blur
Typical box blur.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)|Width of texture in pixels|+|
|int|height|-|Texture height|None (0)|Height of texture in pixels|+|
|int|intensity|0|∞|0|Blur by the selected number of pixels|+|
#### Image
![box blur](https://user-images.githubusercontent.com/76843479/110298954-5a2a5f80-801f-11eb-93de-ecaed23000d5.png)
#### Known issues
- At negative values displays the black screen.
____
### Gaussian Blur
Bad-quality gaussian blur with changing blur strength. But it works!
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)|Width of texture in pixels|+|
|int|height|-|Texture height|None (0)|Height of texture in pixels|+|
|int|intensity|1|∞|0|Blur by selected number of pixels|+|
|bool|sensitive|false|true|false|If true, blur is more intensive at higher values|-|
#### Image
![gaussian blur](https://user-images.githubusercontent.com/76843479/110298972-5e567d00-801f-11eb-8c64-1ba7cff7d716.png)
#### Known issues
- At negative values displays the black screen.
- At small values image becomes too bright.
____
## License
> MIT License\
> Copyright (c) 2021 Lisowolf\
See the [license](https://github.com/Lisowolf/MonoGame-HLSL/blob/main/LICENSE) file for more information.
