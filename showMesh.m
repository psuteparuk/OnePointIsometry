function h = showMesh(X,T,main)

% h = figure;
% patch('vertices',X,'Faces',T,'CData',X(:,2),'FaceColor','interp','edgecolor','none');
if (main)
    patch('vertices',X,'Faces',T,'CData',X(:,2),'FaceColor','yellow','edgecolor','none');
else
    patch('vertices',X,'Faces',T,'CData',X(:,2),'FaceColor',[0.8 0.8 0.8],'edgecolor','none');
end
axis equal;
axis off;
light('Position',[1 0 -1],'Style','infinite');
lighting phong;
cameratoolbar;
