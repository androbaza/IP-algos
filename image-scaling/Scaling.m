clear
prompt = 'Please type in scale:';
scale = input(prompt);
image_or = imread('cat120.jpg');
[rows_or, cols_or] = size(image_or); 
scaled_im = zeros(round(scale*rows_or), round(scale*cols_or));
[rows,cols]=size(scaled_im); 

nearest neighbor
for x = 1:rows
        for y = 1:cols 
                a = round(x/scale);
                b = round(y/scale);
            if a<1
                a=a+1;
            end
            if b<1
                b=b+1;
            end
            scaled_im(x,y) = image_or(a,b);
        end
end
figure(1)
subplot(2,1,1), imshow(image_or), title('Original')
hold on
subplot(2,1,2), imshow(scaled_im,[]), title('NN scaled')
hfig = figure (1)
print(hfig, '-dpng', '-r300', 'NN')


%bilinear v(x,y)=ax+by+cxy+d
% for x = 1:rows
%         for y = 1:cols 
%             if rem(y,scale) & rem(x,scale)==0
%                 continue
%             end
%            
%             
%             scaled_im(x,y) = a1+a2*dx+a3*dy+a4*dx*dy;
%         end
% end
% figure(1)
% subplot(2,1,1), imshow(image_or), title('Original')
% hold on
% subplot(2,1,2), imshow(scaled_im,[]), title('NN scaled')



%bicubic v(x,y)=sum