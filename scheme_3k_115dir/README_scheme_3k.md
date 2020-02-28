
This scheme is meant to be for a ~24 minute scan, 1.5mm isotropic
* max bval = 3000
* 5 b0, 30 b1000, 80 b3000


either 4x  ~6minute scans:
- 57dir scan LR
- 58dir scan LR
- 57dir scan RL
- 58dir scan RL

 or 2x ~12minute scans:
- 115dir scan LR
- 115dir scan RL


# Grad Directions generated with:

On graham:
`module load mrtrix matlab`

```
git clone https://github.com/khanlab/grad_tables

cd grad_tables

gen_scheme 1 1000 30 3000 80
head -n 55  dw_scheme.txt  > dw_scheme_6_30_80_b3000_half1.txt
tail -n 55  dw_scheme.txt  > dw_scheme_6_30_80_b3000_half2.txt
cat dw_scheme.txt > dw_scheme_full.txt

#in matlab: 
convertMrtrixTableToSiemens('dw_scheme_6_30_80_b3000_half1.txt',2,'scheme_3k_30_80_half1.dvs')
convertMrtrixTableToSiemens('dw_scheme_6_30_80_b3000_half2.txt',3,'scheme_3k_30_80_half2.dvs')
convertMrtrixTableToSiemens('dw_scheme_6_30_80_b3000_full.txt',3,'scheme_3k_30_80_full.dvs')

#concatenate all dvs files as well
cat scheme_3k_30_80_full.dvs > schemes_3k_30_80_combined_split.dvs
cat scheme_3k_30_80_half1.dvs >> schemes_3k_30_80_combined_split.dvs
cat scheme_3k_30_80_half2.dvs >> schemes_3k_30_80_combined_split.dvs
```
