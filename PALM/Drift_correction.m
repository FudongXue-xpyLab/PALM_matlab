% function Drift_correction
% clear
% clc
% I=tiffread();
% I=double(I);
% n=length(I);
% fitl=6;
% [Xd,Yd] = meshgrid(-fitl:fitl,-fitl:fitl);
% xdata=[Xd,Yd];
% V=zeros(1,2);
% for i=1:1
%     i
%     Fd=double(I(:,:,i));
%     backg=min(Fd(:));
%     peak=max(Fd(:));
%     xp=[0,0,3,backg,peak];
%     options = optimset('Display','off','MaxFunEvals',1e7,'MaxIter',1000,'TolFun',0.01,'LargeScale','off');
%     [lp,resnorm,residual,exitflag]=lsqcurvefit(@Gaussian_PALM,xp,xdata,Fd,[],[],options);
%     V(i,1)=lp(1);
%     V(i,2)=lp(2);
% end
% V(:,1)=V(:,1)-V(1,1);
% V(:,2)=V(:,2)-V(1,2);
% 
% I=single(I);
% [X Y N BG S CRLBx CRLBy CRLBn CRLBb CRLBs LogL]=mGPUgaussMLE(I,2,20,2);
% V1=[X,Y]+1;
% V1(:,1)=V1(:,1)-V1(1,1);
% V1(:,2)=V1(:,2)-V1(1,2);
% save V;

% function f=Gaussian(xp,xdata)
% [a b]=size(xdata);
% Xd=xdata(:,1:a);
% Yd=xdata(:,a+1:2*a);
% f=xp(5)*(exp(-0.5*(Xd-xp(2)).^2./(xp(3)^2)-0.5*(Yd-xp(1)).^2./(xp(3)^2))) +xp(4);

% function [y,x]=weight_centrid(ROI,w)
ROI=I;
w=13;
sumx=0;
sumy=0;
for i=1:w
    for j=1:w
        sumx=sumx+ROI(i,j)*j;
        sumy=sumy+ROI(i,j)*i;
    end
end
y=sumy/sum(ROI(:));
x=sumx/sum(ROI(:));