function [out] = split_matfile_obsD(mat,nmr,cal_coeff,location)

out.time        = mat.time;
out.description = {['SN:' mat.SN{nmr}],[location{nmr}],'units: FTU'};
out.t           = mat.t;

if nmr == 1
    out.obs         = cal_coeff.*mat.TurbFTU_Avg_1;
    out.std         = mat.TurbFTU_std_1;
    out.cal_coeff   = cal_coeff;
    out.turbftu_max = mat.TurbFTU_max_1;
elseif nmr == 2
    out.obs         = cal_coeff.*mat.TurbFTU_Avg_2;
    out.std         = mat.TurbFTU_std_2;
    out.cal_coeff   = cal_coeff;
    out.turbftu_max = mat.TurbFTU_max_2;
else
    out.obs         = cal_coeff.*mat.TurbFTU_Avg_3;
    out.std         = mat.TurbFTU_std_3;
    out.cal_coeff   = cal_coeff;
    out.turbftu_max = mat.TurbFTU_max_3;
end

end

