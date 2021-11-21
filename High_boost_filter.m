clc        % clear all text from the Command Window
clear      % clear the Current Working Space
close all  % clear all MATLAB opened files and figures
%% *Dataset*

% Download the Mammography dataset for
% Diagnosis of Breast Cancer from the below link
% https://www.kaggle.com/kmader/mias-mammography
%% *Procedure to run the code*

% Run the code
% Enter the parameter values appearing in the command window.
% Hint is given below :

% STEP-1
% <<<<<<<<Enter the size of Gaussian Low Pass Filter>>>>>>>
% Size of the filter should be specified as a positive integer or 2-element vector
% of positive integers. Use a vector to specify the number of rows and
% columns in h. If you specify a scalar, then h is a square matrix.
% eg.- [3,3], [6,6], 256, 512 etc.

% STEP-2
% <<<<<<<<<<Enter the value of Sigma(Standard Deviation)>>>>>>>>
% The default value of Sigma is 0.5
% It should be specified as a positive number
% eg. - 1,2,5,7......etc  

% STEP-3
% <<<<<<<<<Enter the value of Amplification Factor(A)>>>>>>>>
% It should be a positive number
% eg. - 2,5,7,9,10, 12,15.... etc

% STEP-4
% Download the Input_Image folder to select the image
% After entering the values of filter_size,sigma and scaling factor,
% A open file selection dialog box will appear
% Select the images from the Input_Image folder 
%% *Code*

% Input Parameters 
h_size = input('Enter the Size of filter : ');
Sigma = input('Enter the value of Sigma : ');
A = input('Enter the value A : ');
High_Boost_Filt(h_size,Sigma,A);
%%
function High_Boost_Filt(h_size,Sigma,A)

% High_Boost_Filt performs High Frequency Boost Filtering(HFBF) on 
% X-ray mammography images for diagnosis of breast cancers

% HFBF_Image =  High_Boost_Filt(A) performs the high frequency boost
% filtering on the input image with the ampification factor(A). The
% input images can take in jpg,png,tif and png format. The default
% value of sigma in gaussian low pass filter is 0.5.

% HFBF_Image = High_Boost_Filt(A,h_size,Sigma) performs the high
% frequency boost filtering on the input image with the ampification
% factor(A). The input images can take in jpg,png,tif and png format.
% The gaussian low pass filter can have two parameter i.e. h_size and sigma

%==================================%

% h-size
% Size of the filter should be specified as a positive integer or 2-element
% vector of positive integers. Use a vector to specify the number of rows and
% columns in h. If you specify a scalar, then h is a square matrix.
% eg.- [3,3], [6,6], 256, 512 etc.

%==================================%

% Sigma
% Enter the value of Sigma(Standard Deviation)
% The default value of Sigma is 0.5
% It should be specified as a positive number
% eg. - 1,2,5,7......etc  

%===================================%

% In high boost filtering the input image f(m,n) is multiplied by an amplification
% factor A before subtracting the low pass image are discuss as follows :
% High boost filter = A × f(m,n) - low pass filter
% Adding and subtracting 1 with the amplication factor 
% High boost filter = (A−1) × f(m,n) + f(m,n) - low pass filter
% But f(m,n) - low pass filter = high pass filter 
% High boost filter = (A−1) × f(m,n) + high pass filter

%==================================%

% Examples (Grayscale Images or Color Images)
% h_size = input('Enter the Size of filter : ');
% Sigma = input('Enter the value of Sigma : ');
% A = input('Enter the value A : ');
% High_Boost_Filt(h_size,Sigma,A);
% and also h_size = 10, sigma = 10 and A = 10 gives the best results

%==================================%

% We can also draw circular average filter for smoothening or 
% blurring the image 
% Radius = input('Enter the radius : ');
% Average_Filter = fspecial('disk',Radius);
% Average_Filter_Image = imfilter(Original_Image,Average_Filter,'replicate'); 
% figure(),imshow(Average_Filter_Image);
% title('Blurred Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A = Amplification Factor
% GLPF = Gaussain Low Pass Filter
% GLPF_Image = Gaussian Low Pass Filtered Image
% HFBF_Image = High Frequency Boost Filtered Image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select the PGM Image from the Input_Image folder
[file,path] = uigetfile('*.tif;*.pgm;*.jpg;*.png','Select an Image');

% Read the Original Input-Image
Original_Image = imread([path,file]);
figure(),imshow(Original_Image),
title('Original Image')

% Create a gaussian filter (blurring_image)
GLPF = fspecial('gaussian',h_size,Sigma);

% Apply a gaussian low pass filter on the Input_Image
GLPF_Image = imfilter(Original_Image,GLPF);
figure(),imshow(GLPF_Image);
title('Gaussian Low Pass Filtered Image');

% Apply High Pass Filter on Input_Image 
High_pass_filter = Original_Image - GLPF_Image;

% Unsharpened Image is when A = 1
Unsharpened_Image = (1*Original_Image) + High_pass_filter;
figure(),imshow(Unsharpened_Image);
title('Unsharpened Image');

% We can implement the above formula of high boost filtering in 3 ways 
% First one is in function and rest are commented   

% Multiply (A>1) in masked image for high boost filtering
HFBF_Image = (A-1)*Original_Image + Original_Image - GLPF_Image;
figure(),imshow(HFBF_Image);
title('High Frequency Boosted Image');

% Multiply (A>1) in masked image for high boost filtering
% HFBF_image = A*Original_Image - Gaussian_Filtered_Image ;
% figure(),imshow(HFBF_image);
% title('High Frequency Boosted Image');

% Multiply (A>1) in masked image for high boost filtering
% HFBF_image = (A-1)*Original_Image + Original_Image - Gaussian_Filtered_Image;
% figure(),imshow(HFBF_image);
% title('High Frequency Boosted Image');

figure(),imshowpair(Original_Image,HFBF_Image,'montage')
title("Original Image                                                                                 High Boost Image")

end

%%CONCLUSION%%
% Microcalcifications are small calcium deposits that look
% like white specks on a mammogram. Microcalcifications are
% usually not a result of cancer.But if they appear in certain
% patterns and are clustered together, they may be a
% sign of precancerous cells or early breast cancer.
% In the output image, we can clearly see the spots of microcalcifications
% in the breast. We can clearly identify the sharpen edges that we have
% achieved using high frequency boost filtering.