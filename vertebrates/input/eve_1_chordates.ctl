Begin SCREENDB;
	db_name=rg_eve_1_chordates;
	mysql_server=localhost;
ENDBLOCK;

BEGIN SCREENSETS;

    # Uncomment a probe set and a reference set to use
    
	# Main probe sets
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/final_fasta/probes/DNAss-chordates.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/final_fasta/probes/DNArt-chordates.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/final_fasta/probes/RNAds-chordates.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/final_fasta/probes/RNAss+ve-chordates.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/final_fasta/probes/RNAss-ve-chordates.DIGS.faa;
	
	# Additional ad hoc probe sets
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Parvoviridae.DIGS_edit.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Filoviridae.DIGS_edit.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Papillomaviridae.edit.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Circoviridae.DIGS_edit.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Hepadnaviridae.DIGS_edit.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Bornaviridae.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Adenoviridae-short.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Paramyxoviridae.DIGS-edit.faa
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Chuviridae.DIGS.faa;
	#query_aa_fasta=/home2/rg128p/DIGS/projects/eve/digs_fasta/Flaviviridae.DIGS.faa;
	
	#reference_aa_fasta=/home2/rg128p/DIGS/projects/eve/NCBI_viruses.faa;
	#reference_aa_fasta=/home2/rg128p/DIGS/projects/eve/NCBI_viruses_plus_eves.faa;
    
    # Parameters for this screen	
	output_path=./tmp/;
	bitscore_min_tblastn=60;
	seq_length_minimum=40;
	defragment_range=1000;
	blast_threads=8;

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

