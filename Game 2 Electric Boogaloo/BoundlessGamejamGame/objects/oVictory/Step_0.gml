/// @description Insert description here
// You can write your code in this editor

image_alpha += 0.02;

image_alpha = clamp(image_alpha, 0, 1);

y = lerp(y, room_height/2, 0.05);