function [colorShades] = createShades(nMice,color)
colorShades = [];
scales = linspace(0.25,0.75,nMice);
for m = 1:nMice
    colorShades = [colorShades; shade(color,scales(m)) ];
end
end
