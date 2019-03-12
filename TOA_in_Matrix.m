%% TOA with anchor nodes repesented in matrix form to estimate target
% Unknown:
%        x : unknown target location
%        t0: unknown start time of signal
% Known: Anchor locations
%        y

clc
clear
x=[0,0]; % target location
c=10; %signal propagation speed
n=0.1; %noise variance
y=[50,10;10,100;-70,0;4,-15;100,-15;38,54;21,-32;15,97;12,32;-12,-21]; % place anchors here
mCLen=100000; %monte carlo length
noise=0:0.1:1; %noise variance
squared_error=zeros(mCLen,length(noise)); %initializing squared error

for nLength=1:length(noise)
   n=noise(nLength);
for mcN=1:mCLen
    
    t = TOAGenerator(x,y,n,c); % time measurements by calling TDOA generator
    
    xhat=TOALocalization(y,t,c); % target estimation
    
    squared_error(mcN,nLength)=pdist2(xhat(1:2)',x,'euclidean');
    
end
end

err9=mean(squared_error);

plot(noise,err9,'lineWidth',2);
xlabel('Noise Variance','FontName','Times New Roman','FontSize',24,'FontWeight','bold','interpreter','latex');
ylabel('Mean Sqaure error','FontName','Times New Roman','FontSize',24,'FontWeight','bold','interpreter','latex');
set(gca,'FontName','Times New Roman','FontSize',20,'FontWeight','bold','linewidth',2,'ticklength',[0.025 0.05],'TickLabelInterpreter', 'latex');
title('Mean Square Estimation error vs Noise Variance (6 Anchors)')
% % Plot the scenario
% f1 = figure(1);
% clf
% plot(y(:,1),y(:,2),'ko','MarkerSize',8,'lineWidth',2,'MarkerFaceColor','k'); %anchors
% grid on
% hold on
% plot(x(:,1),x(:,2),'b+','MarkerSize',8,'lineWidth',2); % target locations
% 
% plot(xhat(1),xhat(2),'ro','MarkerSize',8,'lineWidth',2);
% legend('Anchor locations','True Target location','Estimated Target location',...
%     'Location','Best')
% 
% % Compute the Mean Squred Error
% Err = mean(squared_error);
% title(['Mean Square Estimation error is ',num2str(Err),'units from target'])