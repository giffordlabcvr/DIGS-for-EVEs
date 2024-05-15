Begin SCREENDB;

	db_name=rg_eve_1_vertebrates;
	mysql_server=localhost;
	
ENDBLOCK;

BEGIN SCREENSETS;

    # Uncomment a probe set and a reference set to use
    
	# Main probe sets
	#query_aa_fasta=probes/DNAss-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/DNArt-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/RNAds-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/RNAss+ve-vertebrates.DIGS.faa;
	#query_aa_fasta=probes/RNAss-ve-vertebrates.DIGS.faa;
		
	#reference_aa_fasta=/home2/rg128p/DIGS/projects/eve/ncbi_virus+te+nonviral.faa;
	#reference_aa_fasta=/home2/rg128p/DIGS/projects/eve/ncbi_virus+te+nonviral+eves.faa;
    
    # Parameters for this screen	
	output_path=./tmp/;
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

