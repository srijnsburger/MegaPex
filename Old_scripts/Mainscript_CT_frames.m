%% Load CT data frames

load('d:\sabinerijnsbur\Matlab\A18CTD2097_raw');
mat = A18CTD2097_raw;

[mat.t]   = day_of_year(mat.time);

%% Plot

figure;
subplot(4,1,1)
plot(mat.t,mat.press);
ylabel('pressure (db');

subplot(4,1,2)
plot(mat.t,mat.temp);
ylabel('temperature (\circ C)');

subplot(4,1,3)
plot(mat.t,mat.sal);
ylabel('Salinity (psu)');

subplot(4,1,4)
plot(mat.t,mat.turb);
ylabel('Turbidity (FTU)');

set(gca,'FontSize',8)
set(findall(gcf,'type','text'),'FontSize',8)
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',['A18CTD2097_raw.pdf']);
