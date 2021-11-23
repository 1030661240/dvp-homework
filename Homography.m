%单应矩阵 选点
clear
clc;
image1=imread('1.jpg');
image2=imread('2.jpg');
figure(1);
imshow(image1);
[xx,yy]=ginput(10);
figure(2);
imshow(image2);
[xa,ya]=ginput(10);
P1=[xx(1) yy(1);
    xx(2) yy(2);
    xx(3) yy(3);
    xx(4) yy(4);
    xx(5) yy(5);
    xx(6) yy(6);
    xx(7) yy(7);
    xx(8) yy(8);
    xx(9) yy(9);
    xx(10) yy(10)];
P2=[xa(1) ya(1);
    xa(2) ya(2);
    xa(3) ya(3);
    xa(4) ya(4);
    xa(5) ya(5);
    xa(6) ya(6);
    xa(7) ya(7);
    xa(8) ya(8);
    xa(9) ya(9);
    xa(10) ya(10);
    ];
Point_H=[P1,P2];

H_Initial.img1=image1;
H_Initial.img2=image2;
H_Initial.Point=Point_H;
save H.mat H_Initial;

