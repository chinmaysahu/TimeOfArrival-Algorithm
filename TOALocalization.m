function xhat = TOALocalization(y,t,c)
% Function to estimate target using TOA measurements
% Quantities:
%   q: Number of dimensions
%   m: Number of anchors
% Inputs:
%   y: anchor locations; mxq matrix
%   t: time measurements
%   c: Signal Propagation speed
% Output:
%   xhat: target location; 1xq vector

[m,~] = size(y); % counting number of anchors

H=[y(2:end,:)-y(1,:)]; % H matrix

r_2 = sum(y.^2,2);

b=0.5*(r_2(2:end)-r_2(1)-c^2*(t(2:end).^2-t(1)^2)); % b matrix

xhat=pinv(H)*b; % compute localization estimate or  target estimation

end