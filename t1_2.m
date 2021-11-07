%可分离
% h = (1/81)*(ones(9,1)*ones(1,9));
% % h3 = (1/9)*ones(9,1);
% % h4 = h3*h3.';
% H = fft2(h);
% H1 = fftshift(H);
% % figure(1);
% % imshow(H1);
% colormap(parula(64))
% %[H2,h1,h2]=freqz2(h,[9 9]);
% freqz2(h,[9 9]);
% axis ([-1 1 -1 1 0 1])


%圆周对称
C = zeros(63,63);
for x = -63:63
    for y = -63:63
        if ((x^2+y^2)<=81)
            C(32-x,32-y) = 1/81;
        end
    end
end
colormap(parula(128))
%[H2,h1,h2]=freqz2(h,[9 9]);
freqz2(C,[63 63]);
axis ([-1 1 -1 1 0 4])