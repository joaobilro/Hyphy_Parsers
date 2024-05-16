# Hyphy_Parsers
 A collection of parsers for performing Hyphy analyses on several genes at a time, and neatly organizing the output files.
 
 In order for the scripts to work, arrange the alignments for each of the desired genes in a folder structure, such as exemplified below.

 Assuming these as example files:

 Alignments: 
	 <atp6_aligned.fasta, bmp_aligned.fasta, cftr_aligned.fasta>
 Tree: 
	 <consensus.nwk>

 The correct structure should be:

 /Main Directory/

	 /Gene_ATP6/
		 <atp6_aligned.fasta>
		
	 /Gene_BMP/
		 <bmp_aligned.fasta>
		
	 /Gene_CFTR/
		 <cftr_aligned.fasta>
	
	 <consensus.nwk>


 Currently, these scripts will only work with a single tree, that for convenience should be present in the same directory as the gene folders.

 The scripts can and *should* be altered in order to include the correct tree (no default, alter the hyphy command) and the alignments (the latter defaulted as .fasta).
 
 The arguments for each script contain the default parameters, but these can and *should* be altered to fit the specific needs for each analysis.

 The scripts are fairly easy to use, and have two modes: Manual and Automatic.

 The manual mode works in a way that the desired test will only run in the specified gene/folder. (Press ENTER after specifying the gene)

 The automatic mode on the other hand, will run the desired test for the specified gene/folder and will iterate through the following folders, until the last one present in the directory. (Type AUTO after specifying the gene)

 Any errors relating to the tests themselves are, in principle, not directly caused by these scripts; the issue should lie in the input files.
