function [mu Sigma] = estimateGaussian(X)
%ESTIMATEGAUSSIAN This function estimates the parameters of a
%Gaussian distribution using the data in X
%   [mu Sigma] = estimateGaussian(X),
%   The input X is the dataset with each n-dimensional data point in one row
%   The output is an n-dimensional vector mu, the mean of the data set
%   and the covariance matrix Sigma, an n x n matrix
%

% Useful variables
[mx, nx] = size(X);

mu = zeros(nx, 1);
Sigma = zeros(nx, nx);
mu = (sum(X)/mx)';
Sigma = (1 / mx) * (X - mu')' * (X - mu');

end
