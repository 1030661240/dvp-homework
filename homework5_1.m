clear,clc
Image = zeros(240,320,3,10);
avg_ref=zeros(240,320,3);
med_ref=zeros(240,320,3);
for i = 1:10
    Image(:,:,:,i) = double(imread(['DATA/',int2str(i),'.jpg']));
    avg_ref=avg_ref+Image(:,:,:,i);
end
avg_ref=avg_ref/10;
for i=1:240
    for j=1:320
        for c=1:3
            med_ref(i,j,c)=median(Image(i,j,c,:));
        end
    end
end
%double范围问题？
subplot(231);imshow(avg_ref/256,[]);title('移动平均');%原图%
subplot(232);imshow(med_ref/256,[]);title('中值');
extractball_avg=zeros(240,320,3);
extractball_med=zeros(240,320,3);
% figure
for i = 1 : 60
  % load image
  Im = (imread(['DATA/',int2str(i), '.jpg'])); 
       subplot(233)
 imshow(Im)
  subplot(234)
  Imwork = double(Im);
  extractball_avg=sum(abs(Imwork-avg_ref),3);
  extractball_avg=extractball_avg>100;
  extractball_avg=double(extractball_avg);
  imshow(extractball_avg,[])
  subplot(235)
  extractball_med=sum(abs(Imwork-med_ref),3);
   extractball_med=extractball_med>100;
   extractball_med=double(extractball_med);
    imshow(extractball_med,[])
    hold on
 %Slow motion!
    pause(0.02)
end