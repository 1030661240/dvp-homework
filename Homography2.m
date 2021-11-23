%@author:����&�ܼ�ԯ
%@update time:2021/11/23
function main
%% ������
clear;clc;
load H;
%��ʼ��ͼ��
H_Initial.img1=imread('1.jpg');
H_Initial.img2=imread('2.jpg');
P1=H_Initial.Point(:,1:2);P2=H_Initial.Point(:,3:4);
T1 = zeros(3,3);
T2 = zeros(3,3);
P1_a=zeros(length(P1(:, 1)),3);P2_a=zeros(length(P2(:, 1)),3);
P1_n=zeros(length(P1(:, 1)),3);P2_n=zeros(length(P2(:, 1)),3);
P1_t=zeros(3,length(P1(:, 1)));P2_t=zeros(3,length(P2(:, 1)));
for i = 1:length(P1(:, 1))
    P1_a(i,1:2)=P1(i,:);
    P1_a(i,3)=1;
end
for i = 1:length(P2(:, 1))
    P2_a(i,1:2)=P2(i,:);
    P2_a(i,3)=1;
end

%% �����Ӻ������㵥Ӧ�Ծ���
H = CalcH(P1, P2);
H_n = Norm(P1_a,P2_a);%DLT��һ�����ٷ���һ�����

% ���Ե�Ӧ�Ծ���
figure(1);
imshow(H_Initial.img1);hold on;plot(P1(:,1),P1(:,2),'g.');
title('��Ӧ�Ե�ѡ��');
[P11x, P11y] = ginput(1);
P11 = [P11x, P11y];hold on;plot(P11(1),P11(2),'rh','MarkerSize', 12);
title('��Ӧ�Ե�ѡ��');

% ����1�еĵ���2�ж�Ӧ�ĵ�Ӧ�Ե�

P22 = WarpH(P11,H_n);
figure(2)
imshow(H_Initial.img2);hold on;plot(P2(:,1),P2(:,2),'g.');
title('��Ӧ�Ե������');
hold on;
plot(P22(1), P22(2), 'rh', 'MarkerSize', 12);
title('��Ӧ�Ե������');

new_panorama=1;
%Trans =  maketform('projective',H');
Trans = projective2d(H_n');Trans2 = projective2d(eye(3));
%[I2,X,Y]=imtransform(H_Initial.img1,Trans);
%I2=imwarp(H_Initial.img1,Trans);
%[img_resized_1,img_resized_2]=size2same(I2,H_Initial.img2);
[output_img,new_panorama]=mosaic(H_Initial.img1,H_Initial.img2,new_panorama,Trans,Trans2);

figure(3);
imshow(output_img,[]);
%imshow([img_resized_1,img_resized_2],[]);
title('�ɵ�Ӧ�Ծ������ͶӰ�任����ƴ�ӵĽ��');
end
%% ��һ��
function H = Norm(P1_a,P2_a)
x = P1_a(:, 1);
y = P1_a(:, 2);
X = P2_a(:, 1);
Y = P2_a(:, 2);

xm=mean(x');
ym=mean(y');
Xm=mean(X');
Ym=mean(Y');
xvar=std(x');
yvar=std(y');
Xvar=std(X');
Yvar=std(Y');
varmax1=max(xvar,yvar);
varmax2=max(Xvar,Yvar);
T1 = [1/varmax1,0,-xm/varmax1;
    0,1/varmax1,-ym/varmax1;
    0,0,1];
T2 = [1/varmax2,0,-Xm/varmax2;
    0,1/varmax2,-Ym/varmax2;
    0,0,1];
for i = 1:length(P1_a(:, 1))
    P1_t(:,i)=(P1_a(i,:))';
    P2_t(:,i)=(P2_a(i,:))';
    P1_n(i,:)=(T1*P1_t(:,i))';
    P2_n(i,:)=(T2*P2_t(:,i))';
end
H1=[P1_n(:,1:2),P2_n(:,1:2)];
H2 = CalcH(H1(:,1:2), H1(:,3:4));
H = (T2\H2)*T1;
end
%%  ����SVD���㵥Ӧ�Ծ���
function H = CalcH(P1, P2)
x = P1(:, 1);
y = P1(:, 2);
X = P2(:, 1);
Y = P2(:, 2);
A = zeros(length(x(:))*2,9);
for i = 1:length(x(:))
    a = [-x(i),-y(i),-1];
    b = [0 0 0];
    c = [X(i);Y(i)];
    d = -c*a;
    A((i-1)*2+1:(i-1)*2+2,1:9) = [[a b;b a] d];
end
[U S V] = svd(A);
h = V(:,9);
H = reshape(h,3,3)';
end
%% �ָ�����
function P2 = WarpH(P1, H);
x = P1(:, 1);
y = P1(:, 2);
p1 = [x'; y'; ones(1, length(x))];
q1 = H*p1;
q1 = q1./[q1(3, :); q1(3,:); q1(3, :)];
P2 = q1';
end
%% ������ͼ��ƴ����һ��
function [output_img,new_panorama]=mosaic(input1,input2,new_panorama,tforms,tforms2)
input1_gray=rgb2gray(input1);         %����ͼ��ת�Ҷ�
input2_gray=rgb2gray(input2);

imageSize(1,:) = size(input1_gray);       %��ȡͼ���С
imageSize(2,:) = size(input2_gray);

[xlim(1,:), ylim(1,:)] = outputLimits(tforms, ...      %����߽�
[1 imageSize(1,2)], [1 imageSize(1,1)]);         

[xlim(2,:), ylim(2,:)] = outputLimits(tforms2, ...
[1 imageSize(2,2)], [1 imageSize(2,1)]); 


maxImageSize = max(imageSize); 
% �ҵ��±߽������Сֵ
xMin = min([1; xlim(:)]); 
xMax = max([maxImageSize(2); xlim(:)]); 
yMin = min([1; ylim(:)]); 
yMax = max([maxImageSize(1); ylim(:)]); 
% ȫ��ͼ�ĳ��Ϳ� 
width = round(xMax - xMin); 
height = round(yMax - yMin); 
I=input1;
% ��ʼ���յ�ȫ��ͼ 
panorama = zeros([height width 3], 'like', I);
%panorama=zeros([600*10,800*10,3]);

%��ƴͼ1��ƴͼ2�ϳ�
blender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');
xLimits = [xMin xMax]; 
yLimits = [yMin yMax]; 
panoramaView = imref2d([height width], xLimits, yLimits);    
I = input2;
% ��ƴͼ2����ȫ��ͼ 
warpedImage = imwarp(I, tforms2, 'OutputView', panoramaView); 
% Generate a binary mask. 
mask = imwarp(true(size(I,1),size(I,2)),tforms2,'OutputView',...    
panoramaView); % Overlay the warpedImage onto the panorama. 
panorama = step(blender, panorama, warpedImage, mask); 


I = input1;
% ��ƴͼ1����ȫ��ͼ 
warpedImage = imwarp(I, tforms, 'OutputView', panoramaView); 
% Generate a binary mask. 
mask = imwarp(true(size(I,1),size(I,2)),tforms,'OutputView',...   
panoramaView); 
panorama = step(blender, panorama, warpedImage, mask);


output_img=panorama;
end