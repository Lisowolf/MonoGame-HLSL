# How to use this shaders in your project
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
