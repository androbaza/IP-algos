clear
close all

image_or = im2double(imread('cameraman.tif'));

[magnitude, direction]=sobelf(image_or, 0); %call for sobel function
[rows_or,cols_or, z]=size(image_or);
distance = round(sqrt(rows_or^2 + cols_or^2)); %max possible distance from the origin in hough space
H = zeros(361, distance*2); %181 element from -pi to pi 

for j = 1 : rows_or
    for k = 1 : cols_or
        if ~isnan(direction(j,k))
            theta = direction(j,k)*(180/pi)+180; %moved +pi towards infinity to not to exceed boundaries
            rho = j*cosd(theta)+k*sind(theta);
            rho = abs(round(rho)); %
            if rho==0
                rho=rho+1;
            end
            H(round(theta),rho) = H(round(theta),rho)+1;
        end
    end
end

c=[0 10];
figure
imagesc(H,c)  
