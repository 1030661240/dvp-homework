clc;
clear;
close all;
%%
%对两幅图像转ycbcr域
img1=imread('football.jpg');
img2=imread('hallway.jpg');
img1_noise=imnoise(img1,'gaussian');
img2_noise=imnoise(img2,'gaussian');
img1_ycrcb=rgb2ycbcr(img1_noise);
img2_ycrcb=rgb2ycbcr(img2_noise);

img1_y=img1_ycrcb(:,:,1);
img2_y=img2_ycrcb(:,:,1);

%%sobel
figure(1)
subplot(2,3,1)
imshow(img1_y);
title('y通道原始图像');

BW1 = edge(img1_y,'sobel');  %%调节阈值0.04
subplot(2,3,2)
imshow(BW1);
title('sobel边缘检测后的结果');

BW2 = edge(img1_y,'prewitt');  %%调节阈值0.03
subplot(2,3,3)
imshow(BW2);
title('prewwit边缘检测后的结果');

BW3 = edge(img1_y,'log');%%调节阈值0.005
subplot(2,3,4)
imshow(BW3);
title('log边缘检测后的结果');

BW4=edge(img1_y,'canny',0.25);%%调节阈值0.03
subplot(2,3,5);
imshow(BW4);
title('canny算子分割结果');

%%对第二张图的边缘检测
%%sobel
figure(2)
subplot(2,3,1)
imshow(img2_y);
title('y通道原始图像');

BW5 = edge(img2_y,'sobel');  %%调节阈值0.04
subplot(2,3,2)
imshow(BW5);
title('sobel边缘检测后的结果');

BW6 = edge(img2_y,'prewitt');  %%调节阈值0.03
subplot(2,3,3)
imshow(BW6);
title('prewwit边缘检测后的结果');

BW7 = edge(img2_y,'log');%%调节阈值0.005
subplot(2,3,4)
imshow(BW7);
title('log边缘检测后的结果');

BW8=edge(img2_y,'canny',0.2);%%调节阈值0.03
subplot(2,3,5);
imshow(BW8);
title('canny算子分割结果');