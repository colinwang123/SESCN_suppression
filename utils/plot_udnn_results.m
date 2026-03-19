%% ========================================================================
% subcode for suppression of seismic external source coherent noise
%
% Author: Kunxi Wang
% Affiliation: China University of Petroleum (Beijing)
% Date: 2026-03-18
%
% Reference:
%  Unsupervised learning for the suppression of seismic external source
%  coherent noise, Geophysics, by Kunxi Wang, Ying Rao, Tianyue Hu, and Chunming Wang
% ========================================================================


function plot_udnn_results(noise, signal, nt, dt, lw1, caxis_range)
% Plot UDNN results in local window

figure;
set(gcf,'Position',[200 100 1650 880]);

subplot('Position',[0.07,0.2,0.16,0.76]);
imagesc(noise);
colormap(seismic(2));
caxis(caxis_range);
xlabel({'Trace Number','(a)'},'FontName','Arial','FontSize',20)
ylabel('Time (s)','FontName','Arial','FontSize',20)
set(gcf,'Units','centimeters'); 
set(gca, 'box', 'off',...
         'linewidth',lw1,...
         'TickDir','out',...
         'xlim', [0 200],...
         'ylim', [0 nt] ,...
         'xtick',0:100:200, ...
         'ytick',0:520:nt);
%
set(gca,'xTickLabel',num2str(get(gca,'xTick')'+200,'%d'));
set(gca,'yTickLabel',num2str(get(gca,'yTick')'*dt,'%.2f'));
set(gca,'FontName','Arial','FontSize',20);

XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(1);
hold on;
plot([XL(1) (XL(2)+ceil(lw1))],YT*ones(size([XL(1) (XL(2)+ceil(lw1))])),'k','linewidth',lw1);
hold on;
plot(XR*ones(size([(YL(1)-ceil(lw1)) YL(2)])),[(YL(1)-ceil(lw1)) YL(2)],'k','linewidth',lw1);





subplot('Position',[0.34,0.2,0.16,0.76]);
imagesc(signal);
colormap(seismic(2));
caxis(caxis_range);
xlabel({'Trace Number','(b)'},'FontName','Arial','FontSize',20)
ylabel('Time (s)','FontName','Arial','FontSize',20)
set(gcf,'Units','centimeters');
set(gca, 'box', 'off',...
         'linewidth',lw1,...
         'TickDir','out',...
         'xlim', [0 200],...
         'ylim', [0 nt] ,...
         'xtick',0:100:200, ...
         'ytick',0:520:nt);
%
set(gca,'xTickLabel',num2str(get(gca,'xTick')'+200,'%d'));
set(gca,'yTickLabel',num2str(get(gca,'yTick')'*dt,'%.2f'));
set(gca,'FontName','Arial','FontSize',20);

XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(1);
hold on;
plot([XL(1) (XL(2)+ceil(lw1))],YT*ones(size([XL(1) (XL(2)+ceil(lw1))])),'k','linewidth',lw1);
hold on;
plot(XR*ones(size([(YL(1)-ceil(lw1)) YL(2)])),[(YL(1)-ceil(lw1)) YL(2)],'k','linewidth',lw1);

% set colorbar
colorbar('eastoutside');
hBar = colorbar;
set(hBar,'tickdir','out','LineWidth',lw1,'FontSize',20);
Position_Bar = get(hBar, 'Position');
Position_Bar = Position_Bar + [0.055  0  0  0];
set(hBar, 'Position',Position_Bar);
set(hBar,'yTickLabel',num2str(get(hBar,'yTick')','%.1f'));

end