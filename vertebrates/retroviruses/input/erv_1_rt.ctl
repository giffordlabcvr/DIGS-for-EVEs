Begin SCREENDB;
	db_name=rg_erv_rt_all;
	mysql_server=localhost;
ENDBLOCK;

BEGIN SCREENSETS;
	query_aa_fasta=/home2/rg128p/DIGS/projects/erv/fasta/panvertebrate/RV-RT-probes.fa;
	reference_aa_fasta=/home2/rg128p/DIGS/projects/erv/fasta/panvertebrate/RV-RT-references;
	output_path=./tmp/;
	bitscore_min_tblastn=60;
	seq_length_minimum=50;
	defragment_range=1000;
	fwd_num_threads=8;
	rev_num_threads=8;
ENDBLOCK;

BEGIN TARGETS;
	Agnatha/
	Sarcopterygii/
	Chondrichthyes/
	Actinopterygii/
	Amphibia/
	Squamata/
	Crocodilia/
	Aves/
	Mammalia/
ENDBLOCK;


