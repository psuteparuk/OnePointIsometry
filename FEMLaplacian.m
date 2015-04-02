function [cotLaplacian massMatrix] = FEMLaplacian(X,T)
% Takes the vertices and triangles of a mesh and returns two n x n matrices
% for a mesh with n vertices:
%  1.  The cotangent Laplacian L (+ or - sign is ok -- just be sure to use
%      it properly in subsequent problems)
%  2.  The "consistent" mass matrix A.
% No credit will be given if L and A are not stored as sparse matrices.

nv = size(X,1);
nf = size(T,1);

% Find edge lengths -- each number is replaced 2x but this structure is 
% easier to use
L1 = rowNorms(X(T(:,2),:)-X(T(:,3),:));
L2 = rowNorms(X(T(:,1),:)-X(T(:,3),:));
L3 = rowNorms(X(T(:,1),:)-X(T(:,2),:));

% Use laws of cosines to get opposite angle
cos1 = (L2.^2 + L3.^2 - L1.^2) ./ (2.*L2.*L3);
cos2 = (L1.^2 + L3.^2 - L2.^2) ./ (2.*L1.*L3);
cos3 = (L1.^2 + L2.^2 - L3.^2) ./ (2.*L1.*L2);
oppositeCosine = [cos1,cos2,cos3];
oppositeAngle = acos(oppositeCosine);

% The cotangent Laplacian
I = [T(:,1);T(:,2);T(:,3)];
J = [T(:,2);T(:,3);T(:,1)];
S = 0.5*cot([oppositeAngle(:,3);oppositeAngle(:,1);oppositeAngle(:,2)]);
In = [I;J;I;J];
Jn = [J;I;I;J];
Sn = [-S;-S;S;S];
cotLaplacian = sparse(In,Jn,Sn,nv,nv);

% Compute face areas
N = cross(X(T(:,1),:)-X(T(:,2),:),X(T(:,1),:)-X(T(:,3),:));
faceAreas = rowNorms(N);

% Compute the consistent mass matrix
r = [];
c = [];
v = [];
for i = 1:3 % Iterate over the three edges of each triangle
    j = mod(i,3)+1;
    
    % Inner product of any two hat function is area/12 on a given face
    t1 = T(:,i);
    t2 = T(:,j);
    r = [r;t1;t2];
    c = [c;t2;t1];
    v = [v;faceAreas/12;faceAreas/12];
    
    % Self product is area/6
    r = [r;t1];
    c = [c;t1];
    v = [v;faceAreas/6];
end

massMatrix = sparse(r,c,v);

function nn = rowNorms(V)
nn = sqrt(sum(V.^2,2));