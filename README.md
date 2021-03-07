# MonoGame-HLSL
Simple and bad-quality HLSL shaders for MonoGame.

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
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|int|horizontal_blocks|-|Texture width|None (0)||
|int|vertical_blocks|-|Texture height|None (0)||
#### Image
![pixelize](https://user-images.githubusercontent.com/76843479/110251312-1f3a1480-7faa-11eb-977f-f58368a78985.PNG)
____
### LCD
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)||
|int|height|-|Texture height|None (0)||
#### Image
![lcd](https://user-images.githubusercontent.com/76843479/110251346-41cc2d80-7faa-11eb-8dcd-0b3f3403507f.PNG)
#### Known issues
- ...
____
### Black & White
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|float|intensity|0|1|0||
#### Image
![black and white](https://user-images.githubusercontent.com/76843479/110251360-4db7ef80-7faa-11eb-9486-cb4f1d53d676.PNG)
#### Known issues
- ...
____
### Chromatic Aberration
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)||
|float|intensity|-∞|∞|0||
#### Image
![chromatic aberration](https://user-images.githubusercontent.com/76843479/110251367-56102a80-7faa-11eb-9acb-4e56be6efa5b.PNG)
____
### Vignette
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|float|intensity|0|∞|0||
#### Image
![vignette](https://user-images.githubusercontent.com/76843479/110251383-632d1980-7faa-11eb-8606-53e5cdd8717e.PNG)
#### Known issues
- ...
____
### Noise
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|int|seed|-∞|∞|0||
|float|intensity|0|1|0||
#### Image
![noise](https://user-images.githubusercontent.com/76843479/110251393-6c1deb00-7faa-11eb-9fed-303d9203ff60.PNG)
#### Known issues
- ...
____
### Box Blur
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)||
|int|height|-|Texture height|None (0)||
|int|intensity|-|∞|0||
#### Image
![box_blur](https://user-images.githubusercontent.com/76843479/110251405-77711680-7faa-11eb-82e6-f6fa48c0b9bf.PNG)
#### Known issues
- ...
____
### Gaussian Blur
#### Parameters
|Type|Variable|Min|Max|Default|Description|
|:-:|:-:|:-:|:-:|:-:|:-:|
|int|width|-|Texture width|None (0)||
|int|height|-|Texture height|None (0)||
|int|intensity|-|∞|0||
|bool|sensitive|false|true|false||
#### Image
![gaussian blur](https://user-images.githubusercontent.com/76843479/110251415-80fa7e80-7faa-11eb-8e8a-864b81ce43fe.PNG)
#### Known issues
- ...
____
