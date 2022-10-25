function [magnitude, direction] = sobelf(image, threshold)
mask_scale=3;
a = [1 0 -1;2 0 -2;1 0 -1];

b = [1 2 1;0 0 0;-1 -2 -1];

[rows_m, cols_m] = size(a);

padding = (mask_scale-1)/2;%find size of padding needed

image_or = im2double(image); %read image, create empty matrices
[rows_or, cols_or, ~] = size(image_or);
image_padded = zeros(rows_or+(padding*2), cols_or+(padding*2));

image_filtered = zeros(rows_or, cols_or);
image_filtered_x = zeros(rows_or, cols_or);
image_filtered_y = zeros(rows_or, cols_or);
direction = zeros(rows_or, cols_or);

for x = padding+1:rows_or+padding %0 padding
    for y = padding+1:cols_or+padding
    image_padded(x,y) = image_or(x-padding, y-padding); 
    end
end


for x = 1 : rows_or %convolve padded image with mask
    for y = 1 : cols_or
        for m = 1 : rows_m
            for n = 1 : cols_m
                image_filtered_x(x, y) = image_filtered_x(x, y) + (image_padded(m+x-1, n+y-1) * a(m, n));
                image_filtered_y(x, y) = image_filtered_y(x, y) + (image_padded(m+x-1, n+y-1) * b(m, n));
            end
        end
    
    image_filtered(x,y)=sqrt((image_filtered_x(x, y))^2+ (image_filtered_y(x, y))^2); %calculate magnitude
    direction(x,y) = atan2(image_filtered_y(x,y),  image_filtered_x(x,y)); %calculate direction
    end
end
magnitude = image_filtered-(image_filtered*(threshold*0.01)); %tresholding
distance = round(sqrt(rows_or^2 + cols_or^2));
imshow(magnitude)
title('Gradient magnitude');
figure
imshow(direction)
title('Gradient direction');