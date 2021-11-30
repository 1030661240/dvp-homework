clear,clc
image=zeros(240,352,3,10);
avg_ref=zeros(240,352,3);
med_ref=zeros(240,352,3);
for i=11:20   %�ӵ�11֡��ʼ����
    image(:,:,:,i-10) = double(imread(['D:/0files/ucas/frames_of_stefan/',int2str(i),'.jpg']));
    avg_ref=avg_ref+image(:,:,:,i-10);
end
avg_ref=avg_ref/10;    %����10֡�ƶ�ƽ��,���Լ������֡��ƽ������ֵ�Դﵽ���õ�Ч��
for i=1:240
    for j=1:352
        for c=1:3
            med_ref(i,j,c)=median(image(i,j,c,:));   %����10֡����ֵ
        end
    end
end
subplot(2,3,1);imshow(avg_ref/256,[]);title('ǰ10֡�ƶ�ƽ��');
subplot(2,3,2);imshow(med_ref/256,[]);title('ǰ10֡��ֵ');

move_avg=zeros(240,352,3);
move_med=zeros(240,352,3);
for i=11:101
    Im=imread(['D:/0files/ucas/frames_of_stefan/',int2str(i), '.jpg']); 
    subplot(2,3,3);imshow(Im);title('ԭ��Ƶ');

    Imwork = double(Im);
    move_avg=sum(abs(Imwork-avg_ref),3);
    move_avg=move_avg>100;      %�趨�˶���ֵ����ֵΪ100�������޸���ֵ
    move_avg=double(move_avg);
    subplot(2,3,4);imshow(move_avg,[]);title('��ֵ�˲�ģ��֡����˶�')
    
    move_med=sum(abs(Imwork-med_ref),3);
    move_med=move_med>100;    %�趨��ֵ�˲�ģ�ͼ���˶�����ֵΪ100
    move_med=double(move_med);
    subplot(2,3,5);imshow(move_med,[]);title('��ֵ�˲�ģ��֡����˶�')
    hold on
    %Slow motion!
    pause(0.02)
end