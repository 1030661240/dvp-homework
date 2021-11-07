h=(1/9)*ones(9,1);
%%生成可分离的2D滤波器冲激响应
h1=h*h.';%%h矩阵乘以h的转置矩阵
%%colormap(parula(64))
freqz2(h1,[9 9]);
axis ([-1 1 -1 1 0 1]);


