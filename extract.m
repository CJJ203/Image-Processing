function extract(filename)

im = imread(filename);      %��ȡͼ��
ri = im(:,:,1);
gi = im(:,:,2);
bi = im(:,:,3);
a = rgb2gray(im);           %����ɫͼ��ת���ɻҶ�ͼ��
bw = edge(a,'canny');       %��Ե���

      
se = strel('rectangle',[3,3]);   %����һ����СΪһ�����صĽṹԪ��
bw = imclose(bw,se);        %������,��ʹ�����߸��⻬
bw = imfill(bw,'holes');    %���ͼ���еĿ׶�
bw = medfilt2(bw);          %��ֵ�˲�
bw = bwareaopen(bw,100);    %����ͼ��С��200������

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
S = round(sqrt(m^2 + n^2));   %S ����ȡ�������ֵ
ma = 180;
md = S;
r = zeros(md,ma);

for i=1:m
    for j=1:n
        if bw(i,j)==1
            for k=1:ma
                ru=round(abs(i*cos(k*3.14/180) + j*sin(k*3.14/180)));
                r(ru+1,k)=r(ru+1,k)+1;  %������¼������ֵ�ͽǶ�
            end
        end
    end
end

[m,n] = size(r);

for i=1:m
    for j=1:n
        if r(i,j)>r(1,1)
            r(1,1) = r(i,j);
            c = j;             %�õ����ֵ�Ľ��� �ĽǶ�ֵ
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