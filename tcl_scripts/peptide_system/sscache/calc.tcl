mol delete all
source ss_traj.tcl
set a 4
mol new ../../K2L6_solvated_0M.psf
animate read dcd ../${a}/npt1.dcd
animate read dcd ../${a}/npt2.dcd
animate read dcd ../${a}/npt3.dcd
start_sscache
