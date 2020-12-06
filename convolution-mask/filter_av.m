clear
close all

prompt = 'Please type in scale:';
mask_scale = input(prompt);
if mask_scale == 3 %%cases for sizes 3, 5 and 7 are handeled
	a = [1 2 3;4 5 6;7 8 10];
elseif mask_scale == 5
	a = [1 2 3 4 5;4 5 6 7 8;7 8 10 11 12;1 2 3 4 5; 6 7 8 9 10];
elseif mask_scale == 7
	a = [1 2 3 4 5 6 7;4 5 6 7 8 8 9;7 8 10 11 12 13 14;1 2 3 4 5 6 7; 6 7 8 9 10 11 12; 1 2 3 4 5 6 7; 8 9 0 1 2 3 4];
end

a = a/sum(a, 'all'); %create averaging filter
[rows_m, cols_m] = size(a);

padding = (mask_scale-1)/2; %find size of padding needed

image_or = im2double(imread('cameraman.tif')); %read image 
[rows_or, cols_or] = size(image_or);
image_padded = zeros(rows_or+(padding*2), cols_or+(padding*2)); %create empty matrices for output
image_filtered = zeros(rows_or, cols_or);

for x = padding+1:rows_or+padding %0 padding
    for y = padding+1:cols_or+padding
    image_padded(x,y) = image_or(x-padding, y-padding); 
    end
end


for x = 1 : rows_or %convolve padded image with mask
    for y = 1 : cols_or
        for m = 1 : rows_m
            for n = 1 : cols_m
                image_filtered(x, y) = image_filtered(x, y) + (image_padded(m+x-1, n+y-1) * a(m, n));
            end
        end
    end
end
 
imshow(image_or) %compare input and output
figure
imshow(image_filtered)