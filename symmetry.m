[X,T] = readOff('1.off');

% Find Eigenfunctions and Eigenvalues of Laplace operator
numEigens = 6;
[L,A] = FEMLaplacian(X,T);
[eigf,eigv] = eigs(L,A,numEigens,'sm');

% Find feature points on each mesh using HKS
P = FindFeaturePoints(X,T,eigf,eigv,128);

% timesteps = pow2(0:7);
timesteps = randsample(1999,10);
timesteps = (timesteps' / 1000) + 0.001;

% Choose a random feature point
% p = unidrnd(size(P,1));
p = 2;

% Find smallest distance from feature points in N
E = zeros(size(P));
Y = zeros(size(X,1),size(P,1));
D = zeros(size(X,1),size(P,1));
for i = 1:size(P,1)
    [E(i),Y(:,i),D(:,i)] = HKMDistance(P(p),eigf,eigv,P(i),eigf,eigv,timesteps);
    display(i);
end

numLines = 10;
[~,ind] = sort(E);
showMesh(X,T,0); hold on
[sortD,sortInd] = sort(D(:,ind(2)));
samp = sortInd(1:numLines);
for i = 1:numLines
    line([X(samp(i),1);X(Y(i,ind(2)),1)],[X(samp(i),2);X(Y(i,ind(2)),2)],[X(samp(i),3);X(Y(i,ind(2)),3)],'Color','green');
end
line([X(P(p),1);X(P(ind(2)),1)],[X(P(p),2);X(P(ind(2)),2)],[X(P(p),3);X(P(ind(2)),3)],'Color','red');