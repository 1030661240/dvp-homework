clc,clear
%  YUV �ļ�ɨ��
in_file = 'football_704x480.yuv';
my_rows = 480;
my_cols = 704;
%�ж��ļ�������
file_fid = fopen(in_file, 'rb');
if(file_fid < 0)   
    error('File does not exist!');  
end
% ��������ļ�
outfile1 = 'my_interlaced_odd_704x480.yuv';
file_fout1 = fopen(outfile1, 'w+');
if(file_fout1 < 0)   
    error('Can not create output file!');  
end
outfile2 = 'my_interlaced_even_704x480.yuv';
file_fout2 = fopen(outfile2, 'w+');
if(file_fout2 < 0)   
    error('Can not create output file!');  
end
% ��ȡ�ļ���С
fseek(file_fid, 0, 'eof');
file_size = ftell(file_fid);
fseek(file_fid, 0, 'bof');
% ��ȡ YUV 4:2:0 �ļ���֡��.
frame_num = file_size / (my_rows * my_cols * 1.5);
% ����Y U V�����Ļ�����.
Y_data = cell(1, frame_num);
U_data = cell(1, frame_num);
V_data = cell(1, frame_num);
Y_value = zeros(my_cols, my_rows);
U_value = zeros(my_cols / 2, my_rows / 2);
V_value = zeros(my_cols / 2, my_rows / 2);

% ��֡��ȡ��YUV����.
for i = 1 : frame_num
    Y_value = fread(file_fid, [my_cols my_rows], 'uint8');
    U_value = fread(file_fid, [my_cols / 2, my_rows / 2], 'uint8');
    V_value = fread(file_fid, [my_cols / 2, my_rows / 2], 'uint8');
    Y_data{i} = Y_value';
    U_data{i} = U_value';
    V_data{i} = V_value';
end
fclose(file_fid);
% ��֡д��YUV������Ϣ
Y_even = zeros(my_rows, my_cols);
U_even = zeros(my_rows / 2, my_cols / 2);
V_even = zeros(my_rows / 2, my_cols / 2);
Y_odd = zeros(my_rows, my_cols);
U_odd = zeros(my_rows / 2, my_cols / 2);
V_odd = zeros(my_rows / 2, my_cols / 2);
for i = 1 : frame_num
    % ��֡�����桢ż�ּ�
    Y_value = Y_data{i};
    U_value = U_data{i};
    V_value = V_data{i};
 for j=1:my_rows
     if(rem(j,2))==0
         Y_even(j,:)=Y_value(j,:);
     else
         Y_odd(j,:)=Y_value(j,:);  
     end
 end
 
 for k=1:my_rows/2
     if(rem(k,2))==0
         U_even(k,:)=U_value(k,:);
         V_even(k,:)=V_value(k,:);
     else
         U_odd(k,:)=U_value(k,:);
         V_odd(k,:)=V_value(k,:);
     end
  end

%     Y_value = Y_data{i};
%     Y_odd= Y_value(1 : 2 : my_rows - 1,:);
%     Y_even = Y_value(2 : 2 : my_rows ,:);
%     
%     U_value = U_data{i};
%     U_odd = U_value(1 : 2 : my_rows/2 - 1,:);
%     U_even = U_value(2 : 2 : my_rows/2 ,:);
%     
%     V_value = V_data{i};
%     V_odd = V_value(1 : 2 : my_rows/2 - 1,:);
%     V_even = V_value(2 : 2 : my_rows/2 ,:);
    
    % д��������
    fwrite(file_fout1, Y_odd', 'uint8');
    fwrite(file_fout1, U_odd', 'uint8');
    fwrite(file_fout1, V_odd', 'uint8');

    % д��ż����
    fwrite(file_fout2, Y_even', 'uint8');
    fwrite(file_fout2, U_even', 'uint8');
    fwrite(file_fout2, V_even', 'uint8'); 
    
end
fclose(file_fout1);
fclose(file_fout2);

