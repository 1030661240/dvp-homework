clc;
clear;
close all;
%%
%������ͼ��תycbcr��
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
title('yͨ��ԭʼͼ��');

BW1 = edge(img1_y,'sobel');  %%������ֵ0.04
subplot(2,3,2)
imshow(BW1);
title('sobel��Ե����Ľ��');

BW2 = edge(img1_y,'prewitt');  %%������ֵ0.03
subplot(2,3,3)
imshow(BW2);
title('prewwit��Ե����Ľ��');

BW3 = edge(img1_y,'log');%%������ֵ0.005
subplot(2,3,4)
imshow(BW3);
title('log��Ե����Ľ��');

BW4=edge(img1_y,'canny',0.25);%%������ֵ0.03
subplot(2,3,5);
imshow(BW4);
title('canny���ӷָ���');

%%�Եڶ���ͼ�ı�Ե���
%%sobel
figure(2)
subplot(2,3,1)
imshow(img2_y);
title('yͨ��ԭʼͼ��');

BW5 = edge(img2_y,'sobel');  %%������ֵ0.04
subplot(2,3,2)
imshow(BW5);
title('sobel��Ե����Ľ��');

BW6 = edge(img2_y,'prewitt');  %%������ֵ0.03
subplot(2,3,3)
imshow(BW6);
title('prewwit��Ե����Ľ��');

BW7 = edge(img2_y,'log');%%������ֵ0.005
subplot(2,3,4)
imshow(BW7);
title('log��Ե����Ľ��');

BW8=edge(img2_y,'canny',0.2);%%������ֵ0.03
subplot(2,3,5);
imshow(BW8);
title('canny���ӷָ���');