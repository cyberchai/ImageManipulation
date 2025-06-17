%% Image Manipulation in Computational Linear Algebra
% Chaira Harder

%% Pre Processing: 

ImJPG = imread('thai.jpg'); % load the image we will manipulate in this project

[m,n,l] = size(ImJPG); % this gives us the dimensions of the image array

minImJPG = min(min(ImJPG)); % this is the minimum range of colour in the image

maxImJPG = max(max(ImJPG)); % this is the maximum range of colour in the image

%imshow(ImJPG) % display image in separate window


%% Manipulating the Image

% img_R = ImJPG(:,:,1);
% img_G = ImJPG(:,1,:);
% img_B = ImJPG(1,:,:);

img_R = ImJPG(:,:,1); % red channel
img_G = ImJPG(:,:,2); % green channel
img_B = ImJPG(:,:,3); % blue channel

size(img_R)
size(img_G)
size(img_B)


% MATRICES

% 3x3 matrix of 1/3
GrayMatrix(1:3, 1:3) = 1/3;

SepiaMatrix = [0.393 0.769 0.189; 0.349 0.686 0.168; 0.272 0.534 0.131];

FilterMatrix = zeros(3,3);
FilterMatrix(1,1) = 1;

IStepMatrix = fliplr(eye(3,3));



% Convert image to grayscale with GrayMatrix:

for i=1:m
    for j=1:n
        PixelColor = reshape(double(ImJPG(i,j,:)),3,1);
        ImJPG_Gray(i,j,:)=uint8(GrayMatrix*PixelColor);
    end
end

% imshow(ImJPG_Gray)
figure, imshow(ImJPG_Gray), title('Grayscale');


% Convert image with SepiaMatrix:

for i=1:m
    for j=1:n
        PixelColor = reshape(double(ImJPG(i,j,:)),3,1);
        ImJPG_Sepia(i,j,:)=uint8(SepiaMatrix*PixelColor);
    end
end

% imshow(ImJPG_Sepia)
figure, imshow(ImJPG_Sepia), title('Sepia');


% Convert image with FilterMatrix:

for i=1:m
    for j=1:n
        PixelColor = reshape(double(ImJPG(i,j,:)),3,1);
        ImJPG_Filter(i,j,:)=uint8(FilterMatrix*PixelColor);
    end
end

% imshow(ImJPG_Filter)
figure, imshow(ImJPG_Filter), title('Red');


% Convert image with IStepMatrix:

for i=1:m
    for j=1:n
        PixelColor = reshape(double(ImJPG(i,j,:)),3,1);
        ImJPG_IStep(i,j,:)=uint8(IStepMatrix*PixelColor);
    end
end

imshow(ImJPG_IStep)
figure, imshow(ImJPG_IStep), title('Color Swapped');
% woah this one is so pretty


%% Hue Rotation Effects

% hueOne(1,1:3) = 0.213;
% hueOne(2,1:3) = 0.715;
% hueOne(3,1:3) = 0.072;
% check to see if this works

theta = pi/4;
% other angles to try:
% theta = pi/2;
% theta = pi/3;

RotationMatrix = [0.213 0.715 0.072; 0.213 0.715 0.072; 0.213 0.715 0.072] + cos(theta) * [0.787 -0.715 -0.072; -0.213 0.285 -0.072; -0.213 -0.715 0.928] + sin(theta) * [0.213 -0.715 0.928; 0.143 0.140 -0.283; -0.787 0.715 0.072];

ImJPG_Hue = uint8(zeros(m, n, l));
for i=1:m
    for j=1:n
        PixelColor = reshape(double(ImJPG(i,j,:)),3,1);
        ImJPG_Hue(i,j,:) = uint8(RotationMatrix * PixelColor);
    end
end

figure, imshow(ImJPG_Hue), title('Hue Rotated');

% blk = zeros(size(ImJPG, 1), size(ImJPG, 2), 0) -- this is wrong also I
% don't get it -- ignore


%% Part 8:

% ImJPG(100:m-100, 100:n-70) flip(ImJPG)
% rot90(ImJPG)
% 255-ImJPG
% ImJPG -50
% uint8(1.25*ImJPG) %change the number to see what happens

figure, imshow(ImJPG(100:m-100, 100:n-70)), title('Dark BW ImJPG(100:m-100, 100:n-70)');
figure, imshow(flip(ImJPG)), title('Flipped');
figure, imshow(rot90(ImJPG)), title('Rotated');
figure, imshow(255 - ImJPG), title('255');
figure, imshow(ImJPG - 50), title('-55 Darker');
figure, imshow(uint8(1.25 * double(ImJPG))), title('Brightness increased');

%% Part 9

% Andy Warhol 4 squared
FourSq = [ImJPG, flip(ImJPG); uint8(1.25 * double(ImJPG)), 255 - ImJPG];
figure, imshow(FourSq), title('Warhol');


%% Free

% I am trying to make a circle/circular blur effect (inside of circle clear in central image, then blurred all around).

% INNER CIRCULAR BLUR
% [X, Y] = meshgrid(1:n, 1:m);
% centerX = n / 2; % n and m are img dimentions
% centerY = m / 2;
% radius = min(n, m) / 4; % this is the clear circle radius

% mask = sqrt((X - centerX).^2 + (Y - centerY).^2) < radius;
% BlurredImage = imgaussfilt(ImJPG, 10);
% figure, imshow(ImJPG), title('Circular Blur Effect');

% Ignore above, I am having trouble with the circular blur so I'm going to try a full blur:
function out = blur(img, wid)
    im = double(img);
    [row, col, channels] = size(img);
    out = zeros(row, col, channels);
    for ch = 1:channels
        for ii = 1:row
            for jj = 1:col
               % these are the submatrix indices
               % got help: https://www.mathworks.com/matlabcentral/answers/472573-write-a-function-called-blur-that-blurs-the-input-image
                r1 =  max(1, ii-wid);
                r2 = min(row, ii+wid);
                c1 = max(1, jj-wid);
                c2 = min(col, jj+wid);
                m = im(r1:r2, c1:c2, ch);
                out(ii,jj,ch) = mean(m(:));
            end
        end
    end
    out = uint8(out); %need to convert back to uint8
end

BlurredImage = blur(ImJPG, 5);
figure, imshow(BlurredImage), title('Blur');



%% Resources Used
% Circle Blur help/inspo
% https://www.mathworks.com/matlabcentral/answers/576121-overlay-gradual-circular-blur-fade-over-image
% https://www.youtube.com/watch?v=qYKoHXNQTfk
% https://www.mathworks.com/matlabcentral/answers/472573-write-a-function-called-blur-that-blurs-the-input-image
% fliplr
% https://www.mathworks.com/matlabcentral/answers/298731-how-do-i-fix-my-code-to-produce-ones-along-the-reverse-diagonal
% Initially debugged with Chioma.