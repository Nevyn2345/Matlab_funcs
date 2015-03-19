function [ z ] = gauss( loc )
%Reconstruction Image as summed gaussians
%   Takes a reconstruction variable from Bobs' code and
%   normalises it, then expands it to 90% of the output
%   image size. A pre-generated gaussian shape is then
%   summed to the output image at the position of the
%   emmitter.

tic;
% nm_pix = 90; for futer development
imsize = 10000;

mesh = 20;
[xx, yy] = meshgrid(-mesh:.1:mesh, -mesh:.1:mesh);
grid_len = length(xx);
c1=2; % sigma value for x spread
c2=2; % sigma value for y spread

maxVal = max(max(loc(:,2)), max(loc(:,4)));
normX = loc(:,2)./maxVal;
normY = loc(:,4)./maxVal;

f=exp(-(((xx)./c1).^2+((yy)./c2).^2)); 
new_locx = normX.*(imsize*0.9); %Scale x and y
new_locy = normY.*(imsize*0.9);
z = zeros(imsize); %Blank image matrix

%-----------------------------------------------------
% Create the image
for i=1:length(new_locx)
    left = int16(new_locx(i)-grid_len/2+1);
    right = int16(new_locx(i)+grid_len/2);
    top = int16(new_locy(i)-grid_len/2+1);
    bottom = int16(new_locy(i)+grid_len/2);
    z(left:right, top:bottom)=z(left:right, top:bottom)+f;
end

%-----------------------------------------------------
% Plotting the data, both as the scaled gaussian image
% and as a scatter plot
z = rot90(z);
subplot(1,2,1);
imagesc(z);
colormap256 = hot(256);
colormap(colormap256);
axis equal
subplot(1,2,2);
plot(loc(:,2),loc(:,4), 'g.', 'MarkerSize', 3);
set(gca,'Color',[0.5 0.5 0.5]);
grid on
axis equal
toc
end

