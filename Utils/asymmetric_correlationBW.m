function [similarity,inter,denom] = asymmetric_correlationBW(A,B)
%BWJACCARD asymmetric_correlation for binary image segmentation.
%
%   SIMILARITY = asymmetric_correlationBWA,B) computes the intersection of binary images
%   A and B divided by A 
%
%   Note
%   ----
%   This function does not do any input validation to maximize speed.
%   This is a private implementation meant for internal use. 

inter = nnz(A & B);
denom = nnz(A);
similarity = inter / denom;
