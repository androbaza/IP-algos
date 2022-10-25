clear
close all
tic
noisy = VideoReader('noise.mp4');
denoised = VideoWriter('denoised'); 
open(denoised);  
        while hasFrame(noisy)
            vidFrame = readFrame(noisy);
            grayFrame = rgb2gray(vidFrame);
            denoisedFrame = median_noise(grayFrame);
            writeVideo(denoised,denoisedFrame);
        end
close(denoised);  
toc      