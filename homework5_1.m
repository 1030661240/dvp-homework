clear,clc
image=zeros(240,352,3,10);
avg_ref=zeros(240,352,3);
med_ref=zeros(240,352,3);
for i=11:20   %从第11帧开始处理
    image(:,:,:,i-10) = double(imread(['D:/0files/ucas/frames_of_stefan/',int2str(i),'.jpg']));
    avg_ref=avg_ref+image(:,:,:,i-10);
end
avg_ref=avg_ref/10;    %计算10帧移动平均,可以计算更多帧的平均或中值以达到更好的效果
for i=1:240
    for j=1:352
        for c=1:3
            med_ref(i,j,c)=median(image(i,j,c,:));   %计算10帧的中值
        end
    end
end
subplot(2,3,1);imshow(avg_ref/256,[]);title('前10帧移动平均');
subplot(2,3,2);imshow(med_ref/256,[]);title('前10帧中值');

move_avg=zeros(240,352,3);
move_med=zeros(240,352,3);
for i=11:101
    Im=imread(['D:/0files/ucas/frames_of_stefan/',int2str(i), '.jpg']); 
    subplot(2,3,3);imshow(Im);title('原视频');

    Imwork = double(Im);
    move_avg=sum(abs(Imwork-avg_ref),3);
    move_avg=move_avg>100;      %设定运动均值的阈值为100，可以修改阈值
    move_avg=double(move_avg);
    subplot(2,3,4);imshow(move_avg,[]);title('均值滤波模型帧检测运动')
    
    move_med=sum(abs(Imwork-med_ref),3);
    move_med=move_med>100;    %设定中值滤波模型检测运动的阈值为100
    move_med=double(move_med);
    subplot(2,3,5);imshow(move_med,[]);title('中值滤波模型帧检测运动')
    hold on
    %Slow motion!
    pause(0.02)
end