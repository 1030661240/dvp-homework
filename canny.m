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
img2_y=img2_ycrcb(:,:,1);

%subplot(2,2,1);
%imshow(img1_y);
%title('ͼ���yͨ��');
% %%
% %sobel����
% Gx=[1.0 2.0 1.0;0.0 0.0 0.0;-1.0 -2.0 -1.0];
% Gy=[-1.0 0.0 1.0;-2.0 0.0 2.0;-1.0 0.0 1.0];
% 
% gradx=conv2(Gx,img1_y,'full'); 
% gradx=abs(gradx); %����ͼ���sobel��ֱ�ݶ� 
% subplot(2,2,2); 
% imshow(gradx,[]); 
% title('ͼ���sobel��ֱ�ݶ�');
%  
% grady=conv2(Gy,img1_y,'full'); 
% grady=abs(grady); %����ͼ���sobelˮƽ�ݶ� 
% subplot(2,2,3); 
% imshow(grady,[]); 
% title('ͼ���sobelˮƽ�ݶ�'); 
%  
% grad=gradx+grady;  %�õ�ͼ���sobel�ݶ� 
% subplot(2,2,4); 
% imshow(grad,[]); 
% title('ͼ���sobel�ݶ�');
% 
% %%
% %prewitt�˲���
% Gx=[1.0 1.0 1.0;0.0 0.0 0.0;-1.0 -1.0 -1.0];
% Gy=[-1.0 0.0 1.0;-1.0 0.0 1.0;-1.0 0.0 1.0];
% 
% gradx=conv2(Gx,img1_y,'full'); 
% gradx=abs(gradx); %����ͼ���prewwit��ֱ�ݶ� 
% figure(2);
% subplot(2,2,2); 
% imshow(gradx,[]); 
% title('ͼ���prewwit��ֱ�ݶ�');
%  
% grady=conv2(Gy,img1_y,'full'); 
% grady=abs(grady); %����ͼ���prewwitˮƽ�ݶ� 
% subplot(2,2,3); 
% imshow(grady,[]); 
% title('ͼ���prewwitˮƽ�ݶ�'); 
%  
% grad=gradx+grady;  %�õ�ͼ���prewwit�ݶ� 
% subplot(2,2,4); 
% imshow(grad,[]); 
% title('ͼ���prewwit�ݶ�');

%%
%%sobel
figure(1)
subplot(2,2,1)
imshow(img1_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_y,'sobel',0.04);  %%������ֵ
subplot(2,2,2)
imshow(BW1);
title('sobel��Ե����Ľ��');

subplot(2,2,3)
imshow(img2_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_y,'sobel',0.04);  %%������ֵ
subplot(2,2,4)
imshow(BW2);
title('sobel��Ե����Ľ��');
%%
%prewwit
figure(2)
subplot(2,2,1)
imshow(img1_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_y,'prewitt',0.04);  %%������ֵ
subplot(2,2,2)
imshow(BW1);
title('prewwit��Ե����Ľ��');

subplot(2,2,3)
imshow(img2_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_y,'sobel',0.04);  %%������ֵ
subplot(2,2,4)
imshow(BW2);
title('sobel��Ե����Ľ��');
%%
%log�˲���
figure(3)
subplot(2,3,1)
imshow(img1);
title('ԭʼͼ��');
BW1 = edge(img1_y,'log',0.004);%%������ֵ
subplot(2,3,2)
imshow(BW1);
title('log��Ե����Ľ��');
BW2 = edge(img1_y,'log',0.004,2.20);%%������ֵ
subplot(2,3,3)
imshow(BW2);
title('Log���ӣ�simna = 2.20�������Ľ��');

subplot(2,3,4)
imshow(img2);
title('ԭʼͼ��');
BW3 = edge(img2_y,'log',0.004);%%������ֵ
subplot(2,3,5)
imshow(BW3);
title('log��Ե����Ľ��');
BW4 = edge(img2_y,'log',0.004,2.20);%%������ֵ
subplot(2,3,6)
imshow(BW4);
title('Log���ӣ�simna = 2.20�������Ľ��');

%%
%canny��Ե���
figure(4)
subplot(2,3,1);
imshow(img1);
title('ԭʼͼ��')
img1_gray=rgb2gray(img1);
subplot(2,3,2);
imshow(img1_gray);
title('�Ҷ�ͼ��');
I1=edge(img1_gray,'canny',0.03);%%������ֵ
subplot(2,3,3);
imshow(I1);
title('canny���ӷָ���'); 

subplot(2,3,4);
imshow(img2);
title('ԭʼͼ��')
img2_gray=rgb2gray(img2);
subplot(2,3,5);
imshow(img2_gray);
title('�Ҷ�ͼ��');
I2=edge(img2_gray,'canny',0.03);%%������ֵ
subplot(2,3,6);
imshow(I2);
title('canny���ӷָ���');

%%
%����ֵm,����Ϊvar�ĸ�˹�����ӵ�ͼ��f�ϣ�Ĭ��ֵ�Ǿ�ֵmΪ0������varΪ0.01��������
%img1_noise=imnoise(img1,'gaussian',m,var); %�����������ò���
img1_noise=imnoise(img1,'gaussian');
img2_noise=imnoise(img2,'gaussian');
figure(5)
subplot(1,2,1)
imshow(img1_noise)
title('��Ӹ�˹�������ͼ��һ');
subplot(1,2,2)
imshow(img2_noise)
title('��Ӹ�˹�������ͼ���');
%%
%������ͼ��תycbcr��

img1_noise_ycrcb=rgb2ycbcr(img1_noise);
img2_noise_ycrcb=rgb2ycbcr(img2_noise);

img1_noise_y=img1_noise_ycrcb(:,:,1);
img2_noise_y=img2_noise_ycrcb(:,:,1);

%%
%%sobel
figure(6)
subplot(2,2,1)
imshow(img1_noise_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_noise_y,'sobel',0.04);  %%������ֵ
subplot(2,2,2)
imshow(BW1);
title('sobel��Ե����Ľ��');

subplot(2,2,3)
imshow(img2_noise_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_noise_y,'sobel',0.04);  %%������ֵ
subplot(2,2,4)
imshow(BW2);
title('sobel��Ե����Ľ��');
%%
%prewwit
figure(7)
subplot(2,2,1)
imshow(img1_noise_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW1 = edge(img1_noise_y,'prewitt',0.04);  %%������ֵ
subplot(2,2,2)
imshow(BW1);
title('prewwit��Ե����Ľ��');

subplot(2,2,3)
imshow(img2_noise_y);
title('yͨ��ԭʼͼ��');
%%BW1 = edge(img1_y,'log',0.003);
BW2 = edge(img2_noise_y,'sobel',0.04);  %%������ֵ
subplot(2,2,4)
imshow(BW2);
title('sobel��Ե����Ľ��');
%%
%log�˲���
figure(8)
subplot(2,3,1)
imshow(img1_noise);
title('ԭʼͼ��');
BW1 = edge(img1_noise_y,'log',0.004);%%������ֵ
subplot(2,3,2)
imshow(BW1);
title('log��Ե����Ľ��');
BW2 = edge(img1_noise_y,'log',0.004,2.20);%%������ֵ
subplot(2,3,3)
imshow(BW2);
title('Log���ӣ�simna = 2.20�������Ľ��');

subplot(2,3,4)
imshow(img2);
title('ԭʼͼ��');
BW3 = edge(img2_noise_y,'log',0.004);%%������ֵ
subplot(2,3,5)
imshow(BW3);
title('log��Ե����Ľ��');
BW4 = edge(img2_noise_y,'log',0.004,2.20);%%������ֵ
subplot(2,3,6)
imshow(BW4);
title('Log���ӣ�simna = 2.20�������Ľ��');

%%
%canny��Ե���
figure(9)
subplot(2,3,1);
imshow(img1_noise);
title('ԭʼͼ��')
img1_noise_gray=rgb2gray(img1_noise);
subplot(2,3,2);
imshow(img1_noise_gray);
title('�Ҷ�ͼ��');
I1=edge(img1_noise_gray,'canny',0.03);%%������ֵ
subplot(2,3,3);
imshow(I1);
title('canny���ӷָ���'); 

subplot(2,3,4);
imshow(img2_noise);
title('ԭʼͼ��')
img2_noise_gray=rgb2gray(img2_noise);
subplot(2,3,5);
imshow(img2_noise_gray);
title('�Ҷ�ͼ��');
I2=edge(img2_noise_gray,'canny',0.03);%%������ֵ
subplot(2,3,6);
imshow(I2);
title('canny���ӷָ���');






