function [HKS] = HeatKernelSignature(eigf,eigv,timesteps)
% Find Heat Kernel Signature of each point

toexp = (-diag(eigv)*timesteps)/log(10);
D = floor(toexp);
F = 10.^(toexp-D);
etlambda = D .* (10.^F);
producteigf = eigf .* eigf;
HKS = producteigf * etlambda;