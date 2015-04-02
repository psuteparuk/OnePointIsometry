function [E,Y,min_D] = HKMDistance(p,eigfM,eigvM,q,eigfN,eigvN,timesteps)
% Find the distance between Heat Kernel Map of p and q

KM = HeatKernelMap(p,eigfM,eigvM,timesteps);
KN = HeatKernelMap(q,eigfN,eigvN,timesteps);

% Augment Heat Kernel Signature
KM = [KM HeatKernelSignature(eigfM,eigvM,timesteps)];
KN = [KN HeatKernelSignature(eigfN,eigvN,timesteps)];

nvM = size(KM,1);
nvN = size(KN,1);

% first = KM .* repmat(timesteps,nvM,1);
% second = KN .* repmat(timesteps,nvN,1);
first = KM .* repmat(timesteps,nvM,2);
second = KN .* repmat(timesteps,nvN,2);

min_D = zeros(nvM,1);
Y = zeros(nvM,1);
for i=1:nvM
    first_i = first(i,:);
    [min_D(i),Y(i)] = min(pdist2(first_i,second,'chebychev'));
end
E = min_D' * min_D;

% This is out of memory
% D = pdist2(first,second,'chebychev');
% E = sum(min(D.*D,[],2));