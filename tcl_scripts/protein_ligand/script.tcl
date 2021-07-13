#"source script2.tcl"
##before this generate the psf files of protein and ligand using plugin by loading the pdb's writtein in step 1
resetpsf
package require psfgen
readpsf step1_pdbreader.psf
coordpdb step1_pdbreader.pdb
readpsf ligandrm.psf
coordpdb ligandrm.pdb
writepsf protein_ligand.psf
writepdb protein_ligand.pdb
resetpsf
exit
