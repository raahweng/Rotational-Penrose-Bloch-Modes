%Written by Richard Wiltshaw


%%%{
clear all
close all
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');
%load('FoldyInfoQuasiHexagonal.mat')
load('result.mat') %Load data file

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
Omega = Om_range;

%{ 
load('Foldy_ResultQuasi1.mat') 

for nn = 1:size(w_incs,1) 
    W_incs{n+nn} = w_incs{nn,1};
    W_scatts{n+nn} = w_scatts{nn,1};
    X{n+nn} = xxs{nn,1};
    Y{n+nn} = yys{nn,1};
end 

Omega = [Omega,om_range];

load('Foldy_ResultQuasi2.mat')

for nnn = 1:size(w_incs,1) 
    W_incs{n+nn+nnn} = w_incs{nnn,1};
    W_scatts{n+nn+nnn} = w_scatts{nnn,1};
    X{n+nn+nnn} = xxs{nnn,1};
    Y{n+nn+nnn} = yys{nnn,1};
end 


Omega = [Omega,om_range];


load('Foldy_ResultQuasi3.mat')

for n4 = 1:size(w_incs,1) 
    W_incs{n+nn+nnn+n4} = w_incs{n4,1};
    W_scatts{n+nn+nnn+n4} = w_scatts{n4,1};
    X{n+nn+nnn+n4} = xxs{n4,1};
    Y{n+nn+nnn+n4} = yys{n4,1};
end 


Omega = [Omega,om_range];

load('Foldy_ResultQuasi4.mat')

for n5 = 1:size(w_incs,1) 
    W_incs{n+nn+nnn+n4+n5} = w_incs{n5,1};
    W_scatts{n+nn+nnn+n4+n5} = w_scatts{n5,1};
    X{n+nn+nnn+n4+n5} = xxs{n5,1};
    Y{n+nn+nnn+n4+n5} = yys{n5,1};
end 


Omega = [Omega,om_range];

%}
%{

load('Foldy_ResultV.mat')

for n6 = 1:size(w_incs,1) 
    W_incs{n+nn+nnn+n4+n5+n6} = w_incs{n6,1};
    W_scatts{n+nn+nnn+n4+n5+n6} = w_scatts{n6,1};
    X{n+nn+nnn+n4+n5+n6} = xxs{n6,1};
    Y{n+nn+nnn+n4+n5+n6} = yys{n6,1};
end 


Omega = [Omega,om_range];
%}



%%{
vidObj = VideoWriter('Foldy_Result_More_notTorrentTorrentVid', 'MPEG-4'); %create video
vidObj.FrameRate = 4;
open(vidObj);
%%}

%%}
for idx = 1:length(Omega)
%for idx = 113
    figure;%plot figure for each frame of video
    hold on
    U = W_incs{idx} + W_scatts{idx};
    %U2 = W_incs{idx+1} + W_scatts{idx+1};
    surf(X{idx}, Y{idx}, abs(U)-10);
    colorbar
    viscircles([XIJ(:,1),XIJ(:,2)],0.1*ones(size(XIJ(:,1))),'EnhanceVisibility',true,'LineWidth',0.5,'Color','w');
    title(['$\Omega$ =', num2str(Omega(idx)) ,' Figure = ', num2str(idx)])
    shading interp
    %colormap jet;
    axis tight
    axis equal
    
    axis off
    colorbar off
    
    
    %c_scale = [min(abs(U_scatts{idx}(:))) max(abs(U_scatts{idx}(:)))]
    %caxis([-0.008 0.008]);
    %caxis([-0.5 0.30]);
    
    %%{     
    drawnow
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);   
    close all
    %%}
end

close(vidObj);
