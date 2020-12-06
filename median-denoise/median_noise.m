function [denoised_image] = median_noise(noisy_image)
mask_scale=3;
a = [1 1 1;1 1 1;1 1 1];
%a = [1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;];
[rows_m, cols_m] = size(a);

padding = (mask_scale-1)/2;%find size of padding needed

image_or = noisy_image; %read image, create empty matrices
[rows_or, cols_or, ~] = size(image_or);
image_padded = zeros(rows_or+(padding*2), cols_or+(padding*2));
image_filtered = zeros(rows_or, cols_or);

for x = padding+1:rows_or+padding %0 padding
    for y = padding+1:cols_or+padding
    image_padded(x,y) = image_or(x-padding, y-padding); 
    end
end

for x = 1 : rows_or %convolve padded image with mask
    for y = 1 : cols_or
        array_median = [];
        for m = 1 : rows_m
            for n = 1 : cols_m
                u = image_padded(m+x-1, n+y-1) * a(m, n);
                array_median = [array_median u];
            end
        end
        image_filtered(x, y) = median(array_median);
    end
end
denoised_image=uint8(image_filtered);
end


