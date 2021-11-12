clc;
clear;
close all;
%%
%������ͼ��תycbcr��
img1=imread('car1.jpg');
img2=imread('hallway.jpg');
img1_ycrcb=rgb2ycbcr(img1);
img2_ycrcb=rgb2ycbcr(img2);

img1_y=img1_ycrcb(:,:,1);
subplot(2,2,1);
imshow(img1_y);
title('ͼ���yͨ��');
%%
%sobel����
Gx=[1.0 2.0 1.0;0.0 0.0 0.0;-1.0 -2.0 -1.0];
Gy=[-1.0 0.0 1.0;-2.0 0.0 2.0;-1.0 0.0 1.0];

gradx=conv2(Gx,img1_y,'full'); 
gradx=abs(gradx); %����ͼ���sobel��ֱ�ݶ� 
subplot(2,2,2); 
imshow(gradx,[]); 
title('ͼ���sobel��ֱ�ݶ�');
 
grady=conv2(Gy,img1_y,'full'); 
grady=abs(grady); %����ͼ���sobelˮƽ�ݶ� 
subplot(2,2,3); 
imshow(grady,[]); 
title('ͼ���sobelˮƽ�ݶ�'); 
 
grad=gradx+grady;  %�õ�ͼ���sobel�ݶ� 
subplot(2,2,4); 
imshow(grad,[]); 
title('ͼ���sobel�ݶ�');


