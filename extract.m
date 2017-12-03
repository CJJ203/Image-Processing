clear;
close all;

im=imread('1.jpg');     %读取图像
a=rgb2gray(im);          %将彩色图像转换成灰度图像
bw=edge(a,'canny');     %边缘检测

      
se = strel('rectangle',[1,1]);   %创造一个平坦的圆盘型结构元素，其半径为2
bw = imclose(bw,se);    %闭运算,可使轮廓线更光滑
bw = imfill(bw,'holes');%填充图像中的孔洞
bw = medfilt2(bw);          %中值滤波
bw = bwareaopen(bw,200);    %消除图中小于200的物体
figure;imshow(bw);

res = a.*uint8(bw);
figure;imshow(res);

