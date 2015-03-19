function [ z ] = gauss( loc )
%Reconstruction Image as Gaussians
%   Detailed explanation goes here
tic;
nm_pix = 90;

mesh = 20;
[xx, yy] = meshgrid(-mesh:.1:mesh, -mesh:.1:mesh);
grid_len = length(xx);
c1=2;
c2=2;

f=exp(-(((xx)./c1).^2+((yy)./c2).^2)); 
new_locx = round(loc(:,2)*1e1)*2; %Scale x and y
new_locy = round(loc(:,4)*1e1)*2;
z = zeros(10000); %Blank image matrix

for i=1:length(new_locx)
    left = int16(new_locx(i)-grid_len/2+101);
    right = int16(new_locx(i)+grid_len/2+100);
    top = int16(new_locy(i)-grid_len/2 +101);
    bottom = int16(new_locy(i)+grid_len/2+100);
    z(left:right, top:bottom)=z(left:right, top:bottom)+f;
end
z = rot90(z);
subplot(1,2,1);
imagesc(z);
colormap256 = hot(256);
colormap(colormap256);
subplot(1,2,2);
plot(loc(:,2),loc(:,4), 'g.', 'MarkerSize', 3);
set(gca,'Color',[0.5 0.5 0.5]);
grid on
axis equal
toc
end

