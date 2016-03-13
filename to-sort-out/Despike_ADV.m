%% Despike ADV data

id = [355 358 496];

for i = id
    
    eval(['load(''d:\sabinerijnsbur\Matlab\Mini-stable\adv',num2str(i),'.mat'')']);
    eval(['vnorth=adv',num2str(i),'.raw.vn;']);
    eval(['veast=adv',num2str(i),'.raw.ve;']);
    eval(['vup=adv',num2str(i),'.raw.vv;']);
    
    [vn, ipn] = func_despike_phasespace3d(vnorth,9,0);
    [ve, ipe] = func_despike_phasespace3d(veast,9,0);
    [vv, ipv] = func_despike_phasespace3d(vup,9,0);
    
    eval(['adv',num2str(i),'.raw.vn=vn;']);
    eval(['adv',num2str(i),'.raw.ve=ve;']);
    eval(['adv',num2str(i),'.raw.vv=vv;']);
    
end
    
   
 

