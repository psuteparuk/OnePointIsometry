function [P] = FindFeaturePoints(X,T,eigf,eigv,time)
% Find feature points on mesh using Heat Kernel Signature.
% The candidates are those with maximum HKS in the two-ring neighborhood

HKS = HeatKernelSignature(eigf,eigv,time);

redundantEdges = [[T(:,1) T(:,2)];[T(:,2) T(:,3)];[T(:,3) T(:,1)]];
E = sortrows(redundantEdges);

[~,to,~] = unique(E(:,1));
from = [1;to(1:end-1)+1];

P = [];
nv = size(X,1);
for i = 1:nv
    or_neighbor = E(from(i):to(i),2);
    if (HKS(i) > min(HKS(or_neighbor)))
        continue;
    end
    check = 1;
    for j = 1:size(or_neighbor,1)
        oror_neighbor = E(from(j):to(j),2);
        if (HKS(i) > min(HKS(oror_neighbor)))
            check = 0;
            break;
        end
    end
    if (check == 1)
        P = [P ; i];
    end
end

% Show feature points
showMesh(X,T,1);
for i = 1:size(P,1)
    [x,y,z] = sphere;
    x = x*0.03; y = y*0.03; z = z*0.03;
    patch(surf2patch(x+X(P(i),1),y+X(P(i),2),z+X(P(i),3),y+X(P(i),2)),'FaceColor','magenta','edgecolor','none');
end