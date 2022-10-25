clear
dv=1; %counter for distance transform

image = imread('separate.jpg');
bw=im2bw(image);
bw=(~bw); %in case the original image is white foreground on black background

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
                dt(x,y)=1;
            end
            if dv==1
                continue
            elseif (bw(x,y)==0) && dt(x,y)==0 && ((dt(x+1,y)==(dv-1))|(dt(x,y+1)==(dv-1))|(dt(x,y-1)==(dv-1))|(dt(x-1,y)==(dv-1)))
               dt(x,y)=dv;
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

dtpos=[1,1];
s = zeros(rows,cols);
allvals = unique(nonzeros(dt));
boundary = min(unique(nonzeros(dt)));
for x = 1:rows
    for y = 1:cols
        if dt(x,y) == boundary && ((dt(x-1,y)==0)&&(dt(x,y-1)==0))|((dt(x-1,y)==0)&&(dt(x,y+1)==0))|((dt(x+1,y)==0)&&(dt(x,y-1)==0))|((dt(x+1,y)==0)&&(dt(x,y+1)==0))
            s(x,y)=dt(x,y);
        end
        if ((dt(x,y)~=0) && (s(x,y)~=0)) 
           neighbors=[(dt(x+1,y)),(dt(x,y+1)),(dt(x,y-1)),(dt(x-1,y)),(dt(x-1,y-1)),(dt(x-1,y+1)),(dt(x+1,y+1)),(dt(x+1,y-1))];
           [val,pos] = max(neighbors);
           if pos==1
             dtpos=[x+1,y];
           end
           if pos==2
             dtpos=[x,y+1];
           end
           if pos==3
             dtpos=[x,y-1];
           end
           if pos==4
             dtpos=[x-1,y];
           end
           if pos==5
             dtpos=[x-1,y-1];
           end
           if pos==6
             dtpos=[x-1,y+1];
           end
           if pos==7
             dtpos=[x+1,y+1];
           end
           if pos==8
             dtpos=[x+1,y-1];
           end
           s(dtpos(1),dtpos(2))=val;
        end
    end
end

for x = rows:-1:1
    for y = cols:-1:1
        if dt(x,y) == boundary && ((dt(x-1,y)==0)&&(dt(x,y-1)==0))|((dt(x-1,y)==0)&&(dt(x,y+1)==0))|((dt(x+1,y)==0)&&(dt(x,y-1)==0))|((dt(x+1,y)==0)&&(dt(x,y+1)==0))
            s(x,y)=dt(x,y);
        end
        if ((dt(x,y)~=0) && (s(x,y)~=0)) 
           neighbors=[(dt(x+1,y)),(dt(x,y+1)),(dt(x,y-1)),(dt(x-1,y)),(dt(x-1,y-1)),(dt(x-1,y+1)),(dt(x+1,y+1)),(dt(x+1,y-1))];
           [val,pos] = max(neighbors);
           if pos==1
             dtpos=[x+1,y];
           end
           if pos==2
             dtpos=[x,y+1];
           end
           if pos==3
             dtpos=[x,y-1];
           end
           if pos==4
             dtpos=[x-1,y];
           end
           if pos==5
             dtpos=[x-1,y-1];
           end
           if pos==6
             dtpos=[x-1,y+1];
           end
           if pos==7
             dtpos=[x+1,y+1];
           end
           if pos==8
             dtpos=[x+1,y-1];
           end
           s(dtpos(1),dtpos(2))=val;
        end
    end
end

for x = 1:rows
    for y = 1:cols
        s(x,y)=(s(x,y)/s(x,y)); %convert to bw
    end
end
figure(1)
imshow(s, [])


%  %check and compare
% figure (1)
% subplot(3,1,1), imshow(bw, []), title('Original')
% hold on
% subplot(3,1,2), imshow(s, []), title('my algorithm')
% hold on
% subplot(3,1,3), imshow(bwskel(logical(dt)), []), title('bwskel')
% hfig = figure (1)
% print(hfig, '-dpng', '-r300', 'results3')
