%Displays (radial) frequency domain with correct wavenumber axes
%TODO: Fix index error - strips at origin??

M = 1000;
N = 200;
deltar = 15/200;
deltat = 2*pi/1000;

kr1 = mod(1/2 + (0:(M-1))/M,1) - 1/2;
kr = kr1*(2*pi/deltar);
kt1 = mod(1/2 + (0:(N-1))/N, 1) - 1/2;
kt = kt1*(2*pi/deltat);
[Kr,Kt] = meshgrid(kr,kt);

% for i = 1:500
%     fourier = fft2(fdata(:,200*(i-1)+1:200*i));
%     surf(Kr.',Kt.',log(abs(fourier)))
%     colormap jet
%     shading interp
%     view (0,90)
%     % axis([-10 10 -100 100])
%     drawnow
% end

fourier = Fourier(0.68455);
surf(Kr.',Kt.',log(abs(fourier)))   %log
colormap jet
shading interp
view (0,90)
xlabel("Angular wavenumber")
ylabel("Radial wavenumber")

