function p = multivariategaussian(X, mu, Sigma)
%MULTIVARIATEGAUSSIAN Computes the probability density function of the
%multivariate gaussian distribution.
%    p = MULTIVARIATEGAUSSIAN(X, mu, Sigma) Computes the probability
%    density function of the examples X under the multivariate gaussian
%    distribution with parameters mu and Sigma.
%

k = length(mu);

if (size(Sigma, 2) == 1) || (size(Sigma, 1) == 1)                             %To transform sigma into multivariate...
    Sigma = diag(Sigma);                                                      %friendly format
end
quor = zeros(size(X, 1), 1);                                              %manipulation to get over lack of memory issues
C = (X - mu') * pinv(Sigma);
B = (X - mu')';
for i = 1 : length(quor)
  quor(i) = C(i, :) *  B(:, i);
end
%quor = diag((X - mu') * pinv(Sigma) * (X' - mu));                              %Use this instead of lines 14 to 19
p = ((det(2 * pi * Sigma))^(-1/2)) * exp((-1/2) * quor);             %vector of probabilities

end
