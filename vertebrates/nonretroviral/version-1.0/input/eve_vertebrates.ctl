Begin SCREENDB;

	db_name=rg_eve_vertebrates;
	mysql_server=localhost;
	
ENDBLOCK;

BEGIN SCREENSETS;

    # Uncomment lines to select a probe set and reference sequence library for use
    
	# Probe sets
	#query_aa_fasta=probes/DNAss-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/DNArt-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/RNAds-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/RNAss+ve-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/RNAss-ve-vertebrates.DIGS.faa;
    
    # Reference sequence libraries
	#reference_aa_fasta=/home2/rg128p/DIGS/projects/eve/ncbi_virus+te+nonviral.faa;
	#reference_aa_fasta=/home2/rg128p/DIGS/projects/eve/ncbi_virus+te+nonviral+eves.faa;

	output_path=./tmp/;
	    
    # Parameters for this screen	
	bitscore_min_tblastn=60;
	seq_length_minimum=40;
	defragment_range=1000;

ENDBLOCK;

BEGIN TARGETS;

	Agnatha/
	Actinopterygii/
	Sarcopterygii/
	Chondrichthyes/
	Amphibia/
	Squamata/
	Crocodilia/
	Aves/
	Mammalia/
	
ENDBLOCK;

