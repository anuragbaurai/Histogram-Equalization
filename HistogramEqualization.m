clc; clear all; close all;

%% Reading the image
A = imread('CST.bmp');     % Here the dynamic range is [0 255] in 'unit8' format
% Converting 'unit8' values to 'double' with dynamic range [0 255]
I = double(A);
% Displaying original image and its gray scale version
figure;
imshow(I, []); title('Input Image');

[Row Column] = size(I);
N = Row*Column;

%% Input Histogram
H1 = zeros(1,256);      % Empty Histogram
%% Loop to count how many pixels have gray level r=0,1,...255 and update the count at the location 1,2,...256 of H1
for r = 0 : 255
    temp = zeros(Row, Column);
    temp(I==r) = 1;
    H1(r+1) = sum(temp(:));
end
figure;
stem([0:255], H1); title('Input Histogram');
xlabel('Gray Level'); ylabel('No. of pixels');

%% Histogram Equalization
% CDF Calculation
Sk = cumsum(H1/N);  %% Calculate cumulative sum
figure;
plot([0:255], Sk*255); title('Transfer Function'); 
xlabel('Input Gray Level'); ylabel('Output Gray Level');
xlim([0 255]); ylim([0 255]);
%% Mapiing of Values to valid gray level
S = round(Sk*255);
%% Output Image
Iout = zeros(Row, Column);
%% Loop to replace each value r in input image with the corresponding valid gray level S at location r+1
for r = 0 : 255    
    Iout(I==r) = S(r+1);    
end
figure;
imshow(Iout, []); title('Output Image');

%% Outpt Histogram
H2 = zeros(1,256);      % Empty Histogram
%% Loop to count how many pixels have gray level r=0,1,...255 and update the count at the location 1,2,...256 of H1
for r = 0 : 255
    temp = zeros(Row, Column);
    temp(Iout==r) = 1;
    H2(r+1) = sum(temp(:));
end
figure;
stem([0:255], H2); title('Output Histogram');
