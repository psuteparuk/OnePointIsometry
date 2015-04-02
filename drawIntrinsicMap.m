function h = drawIntrinsicMap(M,T,N,U,P,Q,p,E,Y)
% Draw the intrinsic map between M and N

if nargin > 8
    numLines = 20;
else
    numLines = 0;
end

[~,ind] = min(E);
Nt = N + repmat([-2 0 5],size(N,1),1);
showMesh(M,T,1); hold on
showMesh(Nt,U,0); hold on
samp = randsample(size(M,1),numLines);
for i = 1:numLines
    line([M(samp(i),1);Nt(Y(i,ind),1)],[M(samp(i),2);Nt(Y(i,ind),2)],[M(samp(i),3);Nt(Y(i,ind),3)],'Color','green');
end
line([M(P(p),1);Nt(Q(ind),1)],[M(P(p),2);Nt(Q(ind),2)],[M(P(p),3);Nt(Q(ind),3)],'Color','red');