% Clean matfiles; remove unnecessary fields

load('d:\sabinerijnsbur\Matlab\Moorings\SBE1526.mat')
mat = SBE1526;

fields      = {'cond2','press2','start','stop'};
[SBE1526]   = rmfield(mat2,fields);



