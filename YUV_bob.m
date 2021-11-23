clc,clear
%  YUV 文件Bob
in_file1 = 'my_interlaced_odd_704x480.yuv';
in_file2 = 'my_interlaced_even_704x480.yuv';
my_rows = 480;
my_cols = 704;

%判断文件存在性
file_fid1 = fopen(in_file1, 'rb');
if(file_fid1 < 0)   
    error('File1 does not exist!');  
end
file_fid2 = fopen(in_file2, 'rb');
if(file_fid2 < 0)   
    error('File2 does not exist!');  
end

% 创建输出文件
outfile1 = 'my_bob_odd_704x480.yuv';
file_fout1 = fopen(outfile1, 'w+');
if(file_fout1 < 0)   
    error('Can not create output file!');  
end
outfile2 = 'my_bob_even_704x480.yuv';
file_fout2 = fopen(outfile2, 'w+');
if(file_fout2 < 0)   
    error('Can not create output file!');  
end

% 获取文件大小
fseek(file_fid1, 0, 'eof');
file_size = ftell(file_fid1);
fseek(file_fid1, 0, 'bof');

% 获取 YUV 4:2:0 文件的帧数.
frame_num = file_size / (my_rows * my_cols * 1.5);

% 创建Y U V分量的缓冲器.
Y_data1 = cell(1, frame_num);
U_data1 = cell(1, frame_num);
V_data1 = cell(1, frame_num);
Y_data2 = cell(1, frame_num);
U_data2 = cell(1, frame_num);
V_data2 = cell(1, frame_num);

Y_value1 = zeros(my_cols, my_rows);
U_value1 = zeros(my_cols / 2, my_rows / 2);
V_value1 = zeros(my_cols / 2, my_rows / 2);
Y_value2 = zeros(my_cols, my_rows);
U_value2 = zeros(my_cols / 2, my_rows / 2);
V_value2 = zeros(my_cols / 2, my_rows / 2);

% 逐帧读取出YUV数据.
for i = 1 : frame_num
    Y_value1 = fread(file_fid1, [my_cols my_rows], 'uint8');
    U_value1 = fread(file_fid1, [my_cols / 2, my_rows / 2], 'uint8');
    V_value1 = fread(file_fid1, [my_cols / 2, my_rows / 2], 'uint8');
    Y_value2 = fread(file_fid2, [my_cols my_rows], 'uint8');
    U_value2 = fread(file_fid2, [my_cols / 2, my_rows / 2], 'uint8');
    V_value2 = fread(file_fid2, [my_cols / 2, my_rows / 2], 'uint8');
    
    Y_data1{i} = Y_value1';Y_data2{i} = Y_value2';
    U_data1{i} = U_value1';U_data2{i} = U_value2';
    V_data1{i} = V_value1';V_data2{i} = V_value2';
end
fclose(file_fid1);
fclose(file_fid2);

% 逐帧写入YUV分量信息
Y_odd = zeros(my_rows, my_cols);
U_odd = zeros(my_rows / 2, my_cols / 2);
V_odd = zeros(my_rows / 2, my_cols / 2);
Y_even = zeros(my_rows, my_cols);
U_even = zeros(my_rows / 2, my_cols / 2);
V_even = zeros(my_rows / 2, my_cols / 2);
for i = 1 : frame_num
    Y_value1 = Y_data1{i};Y_value2 = Y_data2{i};
    U_value1 = U_data1{i};U_value2 = U_data2{i};
    V_value1 = V_data1{i};V_value2 = V_data2{i};
 for j=1:my_rows
     if(rem(j,2))==0
         Y_odd(j,:)=Y_value1(j-1,:);
     else
         Y_odd(j,:)=Y_value1(j,:); 
     end
 end
 for j=1:my_rows
     if(rem(j,2))==0
         Y_even(j,:)=Y_value2(j,:);
     else
         Y_even(j,:)=Y_value2(j+1,:); 
     end
 end
 
 for k=1:my_rows/2
     if(rem(k,2))==0
         U_odd(k,:)=U_value1(k-1,:);V_odd(k,:)=V_value1(k-1,:);
     else
         U_odd(k,:)=U_value1(k,:);V_odd(k,:)=V_value1(k,:);
     end
 end
 for k=1:my_rows/2
     if(rem(k,2))==0
         U_even(k,:)=U_value2(k,:);V_even(k,:)=V_value2(k,:);
     else
         U_even(k,:)=U_value2(k+1,:);V_even(k,:)=V_value2(k+1,:);
     end
 end
   % 写入奇数场恢复的合成帧
    fwrite(file_fout1, Y_odd', 'uint8');
    fwrite(file_fout1, U_odd', 'uint8');
    fwrite(file_fout1, V_odd', 'uint8');
    % 写入偶数场恢复的合成帧
    fwrite(file_fout2, Y_even', 'uint8');
    fwrite(file_fout2, U_even', 'uint8');
    fwrite(file_fout2, V_even', 'uint8'); 
end
fclose(file_fout1);
fclose(file_fout2);
