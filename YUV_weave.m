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
outfile = 'my_weave_704x480.yuv';
file_fout = fopen(outfile, 'w+');
if(file_fout < 0)   
    error('Can not create output file!');  
end
% 获取文件大小
fseek(file_fid1, 0, 'eof');
file_size = ftell(file_fid1);
fseek(file_fid1, 0, 'bof');
% 获取 YUV 4:2:0 文件的帧数.
frame_num = file_size / (my_rows * my_cols * 1.5);
% 创建Y U V分量的缓冲器.
Y_data1 = cell(1, frame_num);U_data1 = cell(1, frame_num);V_data1 = cell(1, frame_num);
Y_data2 = cell(1, frame_num);U_data2 = cell(1, frame_num);V_data2 = cell(1, frame_num);
Y_value1 = zeros(my_cols, my_rows);Y_value2 = zeros(my_cols, my_rows);
U_value1 = zeros(my_cols / 2, my_rows / 2);U_value2 = zeros(my_cols / 2, my_rows / 2);
V_value1 = zeros(my_cols / 2, my_rows / 2);V_value2 = zeros(my_cols / 2, my_rows / 2);
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
Y_weave = zeros(my_rows, my_cols);
U_weave = zeros(my_rows / 2, my_cols / 2);
V_weave = zeros(my_rows / 2, my_cols / 2);
for i = 1 : frame_num
    Y_value1 = Y_data1{i};Y_value2 = Y_data2{i};
    U_value1 = U_data1{i};U_value2 = U_data2{i};
    V_value1 = V_data1{i};V_value2 = V_data2{i};
     for j=1:my_rows
         Y_weave(j,:)=Y_value1(j,:)+Y_value2(j,:);
     end
     for k=1:my_rows/2
         U_weave(k,:)=U_value1(k,:)+U_value2(k,:);
         V_weave(k,:)=V_value1(k,:)+V_value2(k,:);
     end
     % 写入weave滤波恢复的合成帧
    fwrite(file_fout, Y_weave', 'uint8');
    fwrite(file_fout, U_weave', 'uint8');
    fwrite(file_fout, V_weave', 'uint8');
end
fclose(file_fout);
