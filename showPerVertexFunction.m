function h = showPerVertexFunction(X, T, f, h)

% if nargin < 4
%     camera = [];
% end

if nargin < 4
    h = figure;
end

patch('vertices',X,'Faces',T,'FaceColor','interp','CData',double(f),'edgecolor','none'); 
axis equal;
axis off;
colorbar;
cameratoolbar;

% if nargin == 4 && isfield(camera, 'up')
%     campos(camera.position);
%     camva(camera.angle);
%     camup(camera.up);
% end
