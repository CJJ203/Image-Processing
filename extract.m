clear;
close all;

im=imread('1.jpg');     %��ȡͼ��
a=rgb2gray(im);          %����ɫͼ��ת���ɻҶ�ͼ��
bw=edge(a,'canny');     %��Ե���

      
se = strel('rectangle',[1,1]);   %����һ��ƽ̹��Բ���ͽṹԪ�أ���뾶Ϊ2
bw = imclose(bw,se);    %������,��ʹ�����߸��⻬
bw = imfill(bw,'holes');%���ͼ���еĿ׶�
bw = medfilt2(bw);          %��ֵ�˲�
bw = bwareaopen(bw,200);    %����ͼ��С��200������
figure;imshow(bw);

res = a.*uint8(bw);
figure;imshow(res);

