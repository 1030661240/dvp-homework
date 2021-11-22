clear;clc;
load H;
%初始化图像
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
%调用子函数计算单应性矩阵
H = CalcH(P1, P2);
H_n = Norm(P1_a,P2_a);%DLT归一化后再反归一化结果

% 测试单应性矩阵

figure(1);
imshow(H_Initial.img1);hold on;plot(P1(:,1),P1(:,2),'g.');
title('单应性点选择');
[P11x, P11y] = ginput(1);
P11 = [P11x, P11y];hold on;plot(P11(1),P11(2),'rh','MarkerSize', 12);
title('单应性点选择');
% 计算1中的点在2中对应的单应性点

P22 = WarpH(P11,H_n);
figure(2)
imshow(H_Initial.img2);hold on;plot(P2(:,1),P2(:,2),'g.');
title('单应性点计算结果');
hold on;
plot(P22(1), P22(2), 'rh', 'MarkerSize', 12);
title('单应性点计算结果');

Trans =  maketform('projective',H_n');
%Trans = projective2d(H);
[I2,X,Y]=imtransform(H_Initial.img1,Trans);
%I2=imwarp(H_Initial.img1,Trans);
figure(3);
imshow(I2,[]);
title('由单应性矩阵进行投影变换结果');

%归一化
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




% 利用SVD计算单应性矩阵
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
% 恢复坐标
function P2 = WarpH(P1, H);
x = P1(:, 1);
y = P1(:, 2);
p1 = [x'; y'; ones(1, length(x))];
q1 = H*p1;
q1 = q1./[q1(3, :); q1(3,:); q1(3, :)];
P2 = q1';
end