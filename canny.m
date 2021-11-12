clc;
clear;
close all;
%%
%对两幅图像转ycbcr域
img1=imread('car1.jpg');
img2=imread('hallway.jpg');
img1_ycrcb=rgb2ycbcr(img1);
img2_ycrcb=rgb2ycbcr(img2);

img1_y=img1_ycrcb(:,:,1);
subplot(2,2,1);
imshow(img1_y);
title('图像的y通道');
%%
%sobel算子
Gx=[1.0 2.0 1.0;0.0 0.0 0.0;-1.0 -2.0 -1.0];
Gy=[-1.0 0.0 1.0;-2.0 0.0 2.0;-1.0 0.0 1.0];

gradx=conv2(Gx,img1_y,'full'); 
gradx=abs(gradx); %计算图像的sobel垂直梯度 
subplot(2,2,2); 
imshow(gradx,[]); 
title('图像的sobel垂直梯度');
 
grady=conv2(Gy,img1_y,'full'); 
grady=abs(grady); %计算图像的sobel水平梯度 
subplot(2,2,3); 
imshow(grady,[]); 
title('图像的sobel水平梯度'); 
 
grad=gradx+grady;  %得到图像的sobel梯度 
subplot(2,2,4); 
imshow(grad,[]); 
title('图像的sobel梯度');


