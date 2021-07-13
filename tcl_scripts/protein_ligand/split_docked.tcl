mol new 5IFU-tri_5IFU.pdb
set a [atomselect top "not resname LIG"]
$a writepdb protein.pdb
set b [atomselect top "resname LIG"]
$b writepdb ligand.pdb
exit
