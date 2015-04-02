[M,T] = readOff('288.off');
[N,U] = readOff('297.off');

% Find Eigenfunctions and Eigenvalues of Laplace operator
numEigens = 6;
[LM,AM] = FEMLaplacian(M,T);
[LN,AN] = FEMLaplacian(N,U);
[eigfM,eigvM] = eigs(LM,AM,numEigens,'sm');
[eigfN,eigvN] = eigs(LN,AN,numEigens,'sm');

% Find feature points on each mesh using HKS
P = FindFeaturePoints(M,T,eigfM,eigvM,38);
Q = FindFeaturePoints(N,U,eigfN,eigvN,40);

% timesteps = pow2(0:7);
timesteps = randsample(1999,10);
timesteps = (timesteps' / 1000) + 0.001;

% Choose a random feature point
% p = unidrnd(size(P,1));
p = 10;

% Find smallest distance from feature points in N
% E = zeros(size(Q));
% Y = zeros(size(M,1),size(Q,1));
% for i = 1:size(Q,1)
%     [E(i),Y(:,i)] = HKMDistance(P(p),eigfM,eigvM,Q(i),eigfN,eigvN,timesteps);
%     display(i);
% end
% 
% drawIntrinsicMap(M,T,N,U,P,Q,p,E,Y);