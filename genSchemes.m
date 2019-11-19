% generate updated tables for siemens scanners


%95 dir - multi shell
if ~exist('scheme_95.dvs')
system('gen_scheme 1 1000 30 2000 60');
system('mv dw_scheme.txt dw_scheme_95.txt');
convertMrtrixTableToSiemens('dw_scheme_95.txt',5,'scheme_95.dvs');
end

%68 dir - single shell
if ~exist('scheme_68.dvs')
system('gen_scheme 1 1000 63');
system('mv dw_scheme.txt dw_scheme_68.txt');
convertMrtrixTableToSiemens('dw_scheme_68.txt',5,'scheme_68.dvs');
end
