# Shader List
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
## Pixelize
Customizable texture pixelation effect. Doesn't blend pixels! Displays only the first pixel in the "block" of pixels, therefore it may look sharply.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|horizontal_blocks|-|Texture width|None (0)|Number of displayed pixel by horizontal|+|
|int|vertical_blocks|-|Texture height|None (0)|Number of displayed pixel by vertical|+|
#### Image
![pixelize](https://user-images.githubusercontent.com/76843479/110298780-2e0ede80-801f-11eb-9fa4-c093567c3198.png)

____
## LCD
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
## Black & White
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
## Chromatic Aberration
Shifts green and blue channels on selected count of pixels.
#### Parameters
|Type|Variable|Min|Max|Default|Description|Required|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)|Width of texture in pixels|+|
|float|intensity|-∞|∞|0|Offset channels by a specified number of pixels|+|
#### Image
![chromatic aberration](https://user-images.githubusercontent.com/76843479/110298902-4aab1680-801f-11eb-9ece-699576f88e7c.png)
____
## Vignette
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
## Noise
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
## Box Blur
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
## Gaussian Blur
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
