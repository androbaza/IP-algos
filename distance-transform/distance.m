clear
dv=1; %counter for distance transform

bw = imread('horse.jpg');

bw=im2bw(bw);
%bw=(~bw); %in case the original image is white foreground on black background

[rows, cols] = size(bw); 
dt = zeros(rows,cols); %blank matrix for distance transform image
dd=max(rows,cols); %maximum number of loops needed to perform distance transform
while dd>=dv
    for x = 1:rows
        for y = 1:cols 
            if x==1&y==1  %% 8 exceptions for cases on image borderds to avoid exceeding array
                if (bw(x,y)==0) & ((bw(x+1,y)==1)|(bw(x,y+1)==1))
                    dt(x,y)=1;
                    continue;
                end
            end
            if x==1&y~=cols
                if (bw(x,y)==0) & ((bw(x+1,y)==1)|(bw(x,y+1)==1)|(bw(x,y-1)==1))
                    dt(x,y)=1;
                    continue;
                end
            end
            if x==1&y==cols
                if (bw(x,y)==0) & ((bw(x+1,y)==1)|(bw(x,y-1)==1))
                    dt(x,y)=1;
                    continue;
                end
            end
            if y==1&x~=rows
                if (bw(x,y)==0) & ((bw(x+1,y)==1)|(bw(x,y+1)==1)|(bw(x-1,y)==1))
                    dt(x,y)=1;
                    continue;
                end
            end
            if y==1&x==rows
                if (bw(x,y)==0) & ((bw(x+1,y)==1)|(bw(x-1,y)==1))
                    dt(x,y)=1;
                    continue;
                end
            end
            if y==cols&x~=1
                if (bw(x,y)==0) & ((bw(x+1,y)==1)|(bw(x-1,y)==1)|(bw(x,y-1)==1))
                    dt(x,y)=1;
                    continue
                end
            end
            if x==rows&y~=1
                if (bw(x,y)==0) & ((bw(x,y+1)==1)|(bw(x,y-1)==1)|(bw(x-1,y)==1))
                    dt(x,y)=1;
                    continue
                end
            end
            if y==cols & x==rows
                if (bw(x,y)==0) & ((bw(x,y-1)==1)|(bw(x-1,y)==1))
                    dt(x,y)=1;
                    continue
                end
            end
            if (bw(x,y)==0) && ((bw(x+1,y)==1)|(bw(x,y+1)==1)|(bw(x,y-1)==1)|(bw(x-1,y)==1))
                dt(x,y)=1; %assigning boundary points value of 1
            end  
            if dv==1
                continue
            elseif (bw(x,y)==0) && dt(x,y)==0 && ((dt(x+1,y)==(dv-1))|(dt(x,y+1)==(dv-1))|(dt(x,y-1)==(dv-1))|(dt(x-1,y)==(dv-1)))
               dt(x,y)=dv; %assigning inner points value of dv, which iterates as we go further from boundary points
            end
        end
    end
    dv=dv+1;
end

dmax=max(dt,[],'all');
for x = 1:rows
    for y = 1:cols
        dt(x,y)=round(dt(x,y)*(255/dmax)); %normalization
    end
end

check = bwdist(bw,'chessboard'); %check and compare
figure (1)
subplot(3,1,1), imshow(bw, []), title('Original')
hold on
subplot(3,1,2), imshow(dt, []), title('my algorithm')
hold on
subplot(3,1,3), imshow(check, []), title('bwdist "сhessboard"')
hfig = figure (1)
print(hfig, '-dpng', '-r300', 'results')
