function extract(filename)

im = imread(filename);      %读取图像
ri = im(:,:,1);
gi = im(:,:,2);
bi = im(:,:,3);
a = rgb2gray(im);           %将彩色图像转换成灰度图像
bw = edge(a,'canny');       %边缘检测

      
se = strel('rectangle',[3,3]);   %创造一个大小为一个像素的结构元素
bw = imclose(bw,se);        %闭运算,可使轮廓线更光滑
bw = imfill(bw,'holes');    %填充图像中的孔洞
bw = medfilt2(bw);          %中值滤波
bw = bwareaopen(bw,100);    %消除图中小于200的物体

% figure;
% subplot(211);imshow(bw);
% subplot(212);imshow(im);

r = ri.*uint8(bw);
g = gi.*uint8(bw);
b = bi.*uint8(bw);
res = cat(3,r,g,b);
figure;imshow(res);

I1 = res;
I = rgb2gray(I1);

bw = edge(I,'sobel','horizontal');
[m,n] = size(bw);
S = round(sqrt(m^2 + n^2));   %S 可以取到的最大值
ma = 180;
md = S;
r = zeros(md,ma);

for i=1:m
    for j=1:n
        if bw(i,j)==1
            for k=1:ma
                ru=round(abs(i*cos(k*3.14/180) + j*sin(k*3.14/180)));
                r(ru+1,k)=r(ru+1,k)+1;  %用来记录交点数值和角度
            end
        end
    end
end

[m,n] = size(r);

for i=1:m
    for j=1:n
        if r(i,j)>r(1,1)
            r(1,1) = r(i,j);
            c = j;             %得到最大值的交点 的角度值
        end
    end
end

if c <= 90
    rot = -c;
else
    rot = 180 - c;
end

pic = imrotate(I1,rot,'bilinear');
figure;imshow(pic);
end