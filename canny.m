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
img2_y=img2_ycrcb(:,:,1);

%subplot(2,2,1);
%imshow(img1_y);
%title('图像的y通道');
% %%
% %sobel算子
% Gx=[1.0 2.0 1.0;0.0 0.0 0.0;-1.0 -2.0 -1.0];
% Gy=[-1.0 0.0 1.0;-2.0 0.0 2.0;-1.0 0.0 1.0];
% 
% gradx=conv2(Gx,img1_y,'full'); 
% gradx=abs(gradx); %计算图像的sobel垂直梯度 
% subplot(2,2,2); 
% imshow(gradx,[]); 
% title('图像的sobel垂直梯度');
%  
% grady=conv2(Gy,img1_y,'full'); 
% grady=abs(grady); %计算图像的sobel水平梯度 
% subplot(2,2,3); 
% imshow(grady,[]); 
% title('图像的sobel水平梯度'); 
%  
% grad=gradx+grady;  %得到图像的sobel梯度 
% subplot(2,2,4); 
% imshow(grad,[]); 
% title('图像的sobel梯度');
% 
% %%
% %prewitt滤波器
% Gx=[1.0 1.0 1.0;0.0 0.0 0.0;-1.0 -1.0 -1.0];
% Gy=[-1.0 0.0 1.0;-1.0 0.0 1.0;-1.0 0.0 1.0];
% 
% gradx=conv2(Gx,img1_y,'full'); 
% gradx=abs(gradx); %计算图像的prewwit垂直梯度 
% figure(2);
% subplot(2,2,2); 
% imshow(gradx,[]); 
% title('图像的prewwit垂直梯度');
%  
% grady=conv2(Gy,img1_y,'full'); 
% grady=abs(grady); %计算图像的prewwit水平梯度 
% subplot(2,2,3); 
% imshow(grady,[]); 
% title('图像的prewwit水平梯度'); 
%  
% grad=gradx+grady;  %得到图像的prewwit梯度 
% subplot(2,2,4); 
% imshow(grad,[]); 
% title('图像的prewwit梯度');

%%
%%sobel
figure(1)
subplot(2,2,1)
imshow(img1_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_y,'sobel',0.04);  %%调节阈值
subplot(2,2,2)
imshow(BW1);
title('sobel边缘检测后的结果');

subplot(2,2,3)
imshow(img2_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_y,'sobel',0.04);  %%调节阈值
subplot(2,2,4)
imshow(BW2);
title('sobel边缘检测后的结果');
%%
%prewwit
figure(2)
subplot(2,2,1)
imshow(img1_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_y,'prewitt',0.04);  %%调节阈值
subplot(2,2,2)
imshow(BW1);
title('prewwit边缘检测后的结果');

subplot(2,2,3)
imshow(img2_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_y,'sobel',0.04);  %%调节阈值
subplot(2,2,4)
imshow(BW2);
title('sobel边缘检测后的结果');
%%
%log滤波器
figure(3)
subplot(2,3,1)
imshow(img1);
title('原始图像');
BW1 = edge(img1_y,'log',0.004);%%调节阈值
subplot(2,3,2)
imshow(BW1);
title('log边缘检测后的结果');
BW2 = edge(img1_y,'log',0.004,2.20);%%调节阈值
subplot(2,3,3)
imshow(BW2);
title('Log算子（simna = 2.20）处理后的结果');

subplot(2,3,4)
imshow(img2);
title('原始图像');
BW3 = edge(img2_y,'log',0.004);%%调节阈值
subplot(2,3,5)
imshow(BW3);
title('log边缘检测后的结果');
BW4 = edge(img2_y,'log',0.004,2.20);%%调节阈值
subplot(2,3,6)
imshow(BW4);
title('Log算子（simna = 2.20）处理后的结果');

%%
%canny边缘检测
figure(4)
subplot(2,3,1);
imshow(img1);
title('原始图像')
img1_gray=rgb2gray(img1);
subplot(2,3,2);
imshow(img1_gray);
title('灰度图像');
I1=edge(img1_gray,'canny',0.03);%%调节阈值
subplot(2,3,3);
imshow(I1);
title('canny算子分割结果'); 

subplot(2,3,4);
imshow(img2);
title('原始图像')
img2_gray=rgb2gray(img2);
subplot(2,3,5);
imshow(img2_gray);
title('灰度图像');
I2=edge(img2_gray,'canny',0.03);%%调节阈值
subplot(2,3,6);
imshow(I2);
title('canny算子分割结果');

%%
%将均值m,方差为var的高斯噪声加到图像f上，默认值是均值m为0，方差var为0.01的噪声。
%img1_noise=imnoise(img1,'gaussian',m,var); %建议自行设置参数
img1_noise=imnoise(img1,'gaussian');
img2_noise=imnoise(img2,'gaussian');
figure(5)
subplot(1,2,1)
imshow(img1_noise)
title('添加高斯噪声后的图像一');
subplot(1,2,2)
imshow(img2_noise)
title('添加高斯噪声后的图像二');
%%
%对两幅图像转ycbcr域

img1_noise_ycrcb=rgb2ycbcr(img1_noise);
img2_noise_ycrcb=rgb2ycbcr(img2_noise);

img1_noise_y=img1_noise_ycrcb(:,:,1);
img2_noise_y=img2_noise_ycrcb(:,:,1);

%%
%%sobel
figure(6)
subplot(2,2,1)
imshow(img1_noise_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_noise_y,'sobel',0.04);  %%调节阈值
subplot(2,2,2)
imshow(BW1);
title('sobel边缘检测后的结果');

subplot(2,2,3)
imshow(img2_noise_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_noise_y,'sobel',0.04);  %%调节阈值
subplot(2,2,4)
imshow(BW2);
title('sobel边缘检测后的结果');
%%
%prewwit
figure(7)
subplot(2,2,1)
imshow(img1_noise_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_noise_y,'prewitt',0.04);  %%调节阈值
subplot(2,2,2)
imshow(BW1);
title('prewwit边缘检测后的结果');

subplot(2,2,3)
imshow(img2_noise_y);
title('y通道原始图像');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_noise_y,'sobel',0.04);  %%调节阈值
subplot(2,2,4)
imshow(BW2);
title('sobel边缘检测后的结果');
%%
%log滤波器
figure(8)
subplot(2,3,1)
imshow(img1_noise);
title('原始图像');
BW1 = edge(img1_noise_y,'log',0.004);%%调节阈值
subplot(2,3,2)
imshow(BW1);
title('log边缘检测后的结果');
BW2 = edge(img1_noise_y,'log',0.004,2.20);%%调节阈值
subplot(2,3,3)
imshow(BW2);
title('Log算子（simna = 2.20）处理后的结果');

subplot(2,3,4)
imshow(img2);
title('原始图像');
BW3 = edge(img2_noise_y,'log',0.004);%%调节阈值
subplot(2,3,5)
imshow(BW3);
title('log边缘检测后的结果');
BW4 = edge(img2_noise_y,'log',0.004,2.20);%%调节阈值
subplot(2,3,6)
imshow(BW4);
title('Log算子（simna = 2.20）处理后的结果');

%%
%canny边缘检测
figure(9)
subplot(2,3,1);
imshow(img1_noise);
title('原始图像')
img1_noise_gray=rgb2gray(img1_noise);
subplot(2,3,2);
imshow(img1_noise_gray);
title('灰度图像');
I1=edge(img1_noise_gray,'canny',0.03);%%调节阈值
subplot(2,3,3);
imshow(I1);
title('canny算子分割结果'); 

subplot(2,3,4);
imshow(img2_noise);
title('原始图像')
img2_noise_gray=rgb2gray(img2_noise);
subplot(2,3,5);
imshow(img2_noise_gray);
title('灰度图像');
I2=edge(img2_noise_gray,'canny',0.03);%%调节阈值
subplot(2,3,6);
imshow(I2);
title('canny算子分割结果');






