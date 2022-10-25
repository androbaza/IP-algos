Sobelf is a function that is defined as follows:

function [magnitude, direction] = sobelf(image, threshold)

It could be called using script call_sobel.m to see the result for standard input cameraman.tif. The input for the function are as follows:

sobelf(image, threshold), where image is in form of 2D matrix and threshold is in range from 0 to 100, representing percents for thresholding, where 0 is no thresholding and 100 is maximum thresholding (resultant image will be black). 

The output of sobelf are two matrices of dimensions of input image, where magnitude represents edge magnitude for every pixel, and direction represents direction of edge gradient in radians.

