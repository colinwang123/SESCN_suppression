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


function plot_final_results(noise, signal, error_data, nt, nx, dt, lw1, caxis_range)
% Plot final full-wavefield comparison

figure;
set(gcf,'Position',[200 160 2150 550]);

fs = 23.5;

subplot('Position',[0.055,0.25,0.2467,0.7125]);
imagesc(noise);
colormap(seismic(2));
caxis(caxis_range);
xlabel({'Trace Number','(a)'},'FontName','Arial','FontSize',fs)
ylabel('Time (s)','FontName','Arial','FontSize',fs)
set(gcf,'Units','centimeters'); %
set(gca, 'box', 'off',...
         'linewidth',lw1,...
         'TickDir','out',...
         'xlim', [0 nx],...
         'ylim', [0 nt] ,...
         'xtick',0:200:nx, ...
         'ytick',0:520:nt);
%
set(gca,'yTickLabel',num2str(get(gca,'yTick')'*dt,'%.2f'));
set(gca,'FontName','Arial','FontSize',fs);

XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(1);
hold on;
plot([XL(1) (XL(2)+ceil(lw1))],YT*ones(size([XL(1) (XL(2)+ceil(lw1))])),'k','linewidth',lw1);
hold on;
plot(XR*ones(size([(YL(1)-ceil(lw1)) YL(2)])),[(YL(1)-ceil(lw1)) YL(2)],'k','linewidth',lw1);




subplot('Position',[0.375,0.25,0.2467,0.7125]);
imagesc(signal);
colormap(seismic(2));
caxis(caxis_range);
xlabel({'Trace Number','(b)'},'FontName','Arial','FontSize',fs)
ylabel('Time (s)','FontName','Arial','FontSize',fs)
set(gcf,'Units','centimeters'); 
set(gca, 'box', 'off',...
         'linewidth',lw1,...
         'TickDir','out',...
         'xlim', [0 nx],...
         'ylim', [0 nt] ,...
         'xtick',0:200:nx, ...
         'ytick',0:520:nt);
%
set(gca,'yTickLabel',num2str(get(gca,'yTick')'*dt,'%.2f'));
set(gca,'FontName','Arial','FontSize',fs);

XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(1);
hold on;
plot([XL(1) (XL(2)+ceil(lw1))],YT*ones(size([XL(1) (XL(2)+ceil(lw1))])),'k','linewidth',lw1);
hold on;
plot(XR*ones(size([(YL(1)-ceil(lw1)) YL(2)])),[(YL(1)-ceil(lw1)) YL(2)],'k','linewidth',lw1);




subplot('Position',[0.695,0.25,0.2467,0.7125]);
imagesc(error_data);
colormap(seismic(2));
caxis(caxis_range);
xlabel({'Trace Number','(c)'},'FontName','Arial','FontSize',fs)
ylabel('Time (s)','FontName','Arial','FontSize',fs)
set(gcf,'Units','centimeters'); 
set(gca, 'box', 'off',...
         'linewidth',lw1,...
         'TickDir','out',...
         'xlim', [0 nx],...
         'ylim', [0 nt] ,...
         'xtick',0:200:nx, ...
         'ytick',0:520:nt);
%
set(gca,'yTickLabel',num2str(get(gca,'yTick')'*dt,'%.2f'));
set(gca,'FontName','Arial','FontSize',fs);

XL = get(gca,'xlim'); XR = XL(2);
YL = get(gca,'ylim'); YT = YL(1);
hold on;
plot([XL(1) (XL(2)+ceil(lw1))],YT*ones(size([XL(1) (XL(2)+ceil(lw1))])),'k','linewidth',lw1);
hold on;
plot(XR*ones(size([(YL(1)-ceil(lw1)) YL(2)])),[(YL(1)-ceil(lw1)) YL(2)],'k','linewidth',lw1);

% set colorbar
colorbar('eastoutside');
hBar = colorbar;
set(hBar,'tickdir','out','LineWidth',lw1,'FontSize',fs);
Position_Bar = get(hBar, 'Position');
Position_Bar = Position_Bar + [0.045  0  0  0];
set(hBar, 'Position',Position_Bar);
set(hBar,'yTickLabel',num2str(get(hBar,'yTick')','%.1f'));


end