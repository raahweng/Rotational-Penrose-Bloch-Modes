%Written by Richard Wiltshaw; modified by Ross Ah-Weng


% clear all;
%% Build lattice
X = 1.0;
Y = 1.0;

%% Specify objects in fundamental cell
 X1J = X*[0];
 Y1J = Y*[0];
 Omega1J = 4*pi*[1];%,1];
 M1J = [10];%,1];
 
 P = size(X1J,1);
 
%% Specify frequency range of interest
midIn = 0.5;  

Om_range = linspace(midIn-0.5, midIn+0.5, 100);

%% Specify resolution of scattering computation
resolution = 100;  %100
 
XIJ = unique(PenroseTiling(5), "rows");
%PenroseTiling(5)
%RotSym(11)
%RandSym(76)

%Decagonal Annulus
% a1 = 4.01;
% a2 = 1.99;
% xdec = [];
% ydec = [];
% for i = 1:10
%     xdec = [xdec sin(-i*pi/5 + pi/10)];
%     ydec = [ydec cos(-i*pi/5 + pi/10)];
% end
% 
% in = inpolygon(XIJ(:,1),XIJ(:,2),[a1*xdec NaN a2*flip(xdec)],[a1*ydec NaN a2*flip(ydec)]);
% XIJ = XIJ(in,:);

% for i = 1:size(XIJ(:,1))
%     if norm(XIJ(i,:))) > 10) | norm(XIJ(i,:)) < 8)
%         XIJ(i,:) = [];
%     end
% end
% XIJ(norm([XIJ(:,1), XIJ(:,2)]) > 10 | norm([XIJ(:,1), XIJ(:,2)]) < 8) = [];

%Boundary Annulus
% k = boundary(XIJ, 0.96);
% XIJ = unique(XIJ(k,:), "rows");


%Mass at source causes singularity in Hankel function
XIJ(XIJ(:,1)==0 & XIJ(:,2)==0,:) = [];



OmegaIJ = ones(size(XIJ(:,1))) * Omega1J;    
MIJ = ones(size(XIJ(:,1))) * M1J;

Xinc = 10*[sin(-pi/10),cos(-pi/10)]'; %Position of monopole source term
Istar = 1; %Strength of monopole source term

figure; %plot crystal
hold on;
%plot(cent(1,:), cent(2,:), 'bo')
plot(XIJ(:,1), XIJ(:,2), 'gx')

plot(Xinc(1), Xinc(2), 'rs')
%plot(SuperCellCent1(1), SuperCellCent1(2), 'gs')
axX = xlim;
axY = ylim;
xlim(axX+2.5*[-1,1])
ylim(axY+2.5*[-1,1])
axis equal
axXlim = xlim;
axYlim = ylim; %Gets xlim and ylim for boundary of the scatterering simulation
hold off


x = linspace(axXlim(1), axXlim(2), resolution);
y = linspace(axYlim(1), axYlim(2), resolution);
[xx, yy] = meshgrid(x, y);

w_incs = cell(length(Om_range));
w_scatts = cell(length(Om_range));
xxs = cell(length(Om_range));
yys = cell(length(Om_range));



% Perform scattering simulation
parfor index = 1:length(Om_range)
    index
    [w_inc, w_scatt] = scatteringSolnSpringMassOnaPlate(Istar,Xinc,Om_range(index),xx,yy,XIJ,OmegaIJ,MIJ);
    w_incs{index} = w_inc; 
    w_scatts{index} = w_scatt;   
    xxs{index} = xx; 
    yys{index} = yy;
    
end

% Save data file
save('result.mat', 'w_incs', 'w_scatts', 'xxs', 'yys', 'Om_range','XIJ','OmegaIJ','MIJ');
toc

% Plotting
W_incs = {};
W_scatts = {};
X = {};
Y = {};
for n = 1:size(w_incs,1) 
    W_incs{n} = w_incs{n,1};
    W_scatts{n} = w_scatts{n,1};
    X{n} = xxs{n,1};
    Y{n} = yys{n,1};
end    

%Plotting
Omega = Om_range;


figure;%(0 + idx); hold on
hold on
idx = 1;
U = W_incs{idx} + W_scatts{idx};

surf(X{idx}, Y{idx}, abs(U)-10);
colorbar
viscircles([XIJ(:,1),XIJ(:,2)],0.1*ones(size(XIJ(:,1))),'EnhanceVisibility',true,'LineWidth',2.0,'Color','w');
title(['\Omega =', num2str(Om_range(idx)) ,' (Hz) Figure = ', num2str(idx)])
shading interp
colormap jet;
axis tight
axis equal

axis off
colorbar off


