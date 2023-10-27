%Plot fourier peaks

s = 50; %50

load("penrosedata.mat")
penrose = fdata(:,s:end);

load("rotsymdata.mat")
rotsym = fdata(:,s:end);

load("randsymdata.mat")
randsym = fdata(:,s:end);

orange = orange(:,s:end);

% plot(orange,max(abs(randsym), [], 1),"g")
% hold on
plot(orange,max(abs(rotsym), [], 1),"r")
hold on
plot(orange,max(abs(penrose), [], 1),"b")
hold on

xlabel("Frequency, Ω")
legend("Random with fivefold symmetry", "Regular", "Penrose")

% data = max(imag(penrose));
% idx = islocalmax(data, 'MinProminence',1000);
% scatter(orange(idx),data(idx))
% omax = orange(idx);

% [thetas, fourier, XIJ, XX, YY] = Fourier(1);

% load("penrosedata.mat")
% penrose = fdata(:,s:end);
% for i = 1:5000
%     plot(thetas, real(fdata(:,i)))
%     hold on
%     plot(thetas, imag(fdata(:,i)))
%     hold off
%     drawnow
% end
