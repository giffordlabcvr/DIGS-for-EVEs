#!/usr/bin/perl -w
############################################################################
# Script:      eve-catalog-tools.pl 
# Description: Utility tools for working with the EVE catalog
# History:     Version 1.0 Creation: Rob J Gifford 2024
############################################################################

# set up library of local modules for this program (base functions)
use lib './modules/'; 

############################################################################
# Import statements/packages (externally developed packages)
############################################################################
use strict;
use Getopt::Long;

############################################################################
# Import statements/packages (internally developed packages)
############################################################################

# Base modules
use Console;
use DevTools;
use FileIO;

############################################################################
# Globals
############################################################################

# Program version
my $program_version = '0.1 beta';

# Set up EVE catalog paths
my $catalog_path_animals_vert = '../eve/animals/vertebrates/nonretroviral/version-1.0/output/eve-catalog/eve-nonrv-vertebrata-v1.0.tsv';
my $catalog_path_animals_invert = '../eve/animals/invertebrates/nonretroviral/version-1.0/output/eve-catalog/eve-nonrv-invertebrates-v1.0.tsv';
my $catalog_path_plants = '../eve/plants/nonrv/version-1.0/output/eve-catalog/eve-nonrv-plants-v1.0.tsv';
my $catalog_path_fungi = '../eve/fungi/nonrv/version-1.0/output/eve-catalog/eve-nonrv-fungi-v1.0.tsv';
my $catalog_path_protista = '../eve/protista/nonrv/version-1.0/output/eve-catalog/eve-nonrv-protista-v1.0.tsv';

my %catalog_paths;
$catalog_paths{vertebrate} = $catalog_path_animals_vert;
$catalog_paths{invertebrate} = $catalog_path_animals_invert;
$catalog_paths{plants} = $catalog_path_plants;
$catalog_paths{fungi} = $catalog_path_fungi;
$catalog_paths{protista} = $catalog_path_protista;

############################################################################
# Instantiations
############################################################################

# Base utilites
my $fileio     = FileIO->new();
my $devtools   = DevTools->new();
my $console    = Console->new();

############################################################################
# USAGE statement
############################################################################

# Initialise usage statement to print if usage is incorrect
my ($USAGE) = "\n\t  usage: $0 -m=[1] -i=[infile]\n\n\n";

############################################################################
# Main program
############################################################################

# Run script
main();

# Exit program
exit;

############################################################################
# Subroutines
############################################################################

#***************************************************************************
# Subroutine:  main
# Description: top level handler fxn
#***************************************************************************
sub main {

	# Define variables to hold the option values
	my ($help, $version, $mode, $species, $file, $file2);
	
	# Print program information to console
	show_title();

	# Read in options using GetOpt::Long
	GetOptions(
		'help!'      => \$help,
		'version!'   => \$version,
		'mode|m=i'   => \$mode,
		'infile|i=s' => \$file,
	) or die "Error in command line arguments";

	if ($help) { # Show help page
		show_help_page();  
	}
	elsif ($version)  { 
		print "\n\t # digs-for-eves-tools.pl version $program_version\n\n";  
	}
	elsif ($mode)  {
	
	    unless ($file) {	    
	    	print "\n\t  Please supply an input file for mode '$mode' using the '-i' option\n";
	    	print "\n\t  For more details on how to run, use '-h' (help)\n";
	    	die $USAGE;
	    }
		if (($mode eq 1)) {		    
		    convert_digs_results_table_to_eve_catalog($file);
		}
		elsif (($mode eq 2) and $file) {
			profile_namespace($file);
		}

	}
	else {
		die $USAGE;
	}
	print "\n\n\t # Exit\n\n\n";
}

############################################################################
# Compile isolate database
############################################################################

#***************************************************************************
# Subroutine:  convert_digs_results_table_to_eve_catalog
# Description: reads in the raw results table from a DIGS-based EVE screen
#              and converts to an organised EVE catalog.
# 
# This fxn will:
# 1. Identify and uniquely label duplicates (distinct loci that are likely
#    derived from the same germline incorporation event). Duplicate EVE IDs can occur 
#    for (i) multi-copy EVE lineages in which orthology relationships are poorly
#    resolved or (ii) due to fragmentation across contigs.
# 2. Apply standard IDs to individual sequences (i.e. suffix corresponds to host species)
# 3. Export a FASTA file containing all individual hits, labelled as in (2) 
#***************************************************************************
sub convert_digs_results_table_to_eve_catalog {

	my ($file) = @_;


    # Read in the digs result file data
	my @data_file;
	$fileio->read_file($file, \@data_file);
	my $num_lines = scalar @data_file;
	unless ($num_lines) {
		print "\n\t # No data read from file '$datafile'\n\n";
		next;		
	}

	# Set up column headers
	my $header_row = shift @data_file;
	chomp $header_row;
	my @header_row = split("\t", $header_row);
	my %column_headers;
	my $i=0;
	foreach my $value (@header_row) {	
		$i++;
		$column_headers{$i} = $value;
	}

	# Iterate through DIGS table result rows
	foreach my $line (@data_file) {
	
	
	
	}

}

#***************************************************************************
# Subroutine:  profile_namespace
# Description: 
#***************************************************************************
sub profile_namespace {

	my ($file) = @_;

	unless ($file) {
	
		$file = select_eve_catalog();
	
	
	}

}

#***************************************************************************
# Subroutine:  select_eve_catalog
# Description: 
#***************************************************************************
sub get_eve_catalog_version {

	



}



############################################################################
# BASE
############################################################################

#***************************************************************************
# Subroutine:  get_row_values_by_column_header
# Description: 
#***************************************************************************
sub get_row_values_by_column_header {

	my ($line, $column_header_ref, $result_ref) = @_;

	my @line = split("\t", $line);
	my $j=0;
	foreach my $value (@line) {

		$j++;
		my $column_name = $column_header_ref->{$j};
		$result_ref->{"$column_name"} = $value;

	}
}

############################################################################
# Command line title blurb 
############################################################################

#***************************************************************************
# Subroutine:  show_title
# Description: does what it says 
#***************************************************************************
sub show_title {

	#$console->refresh();
	my $title       = 'EVE Catalog Maintenance Tool';
	my $version     = '1.0';
	my $description = 'Utility tools for working with the EVE catalog';
	my $author      = 'Robert J. Gifford';
	my $contact		= '<robjgiff@gmail.com>';
	$console->show_about_box($title, $version, $description, $author, $contact);
}

#***************************************************************************
# Subroutine:  show_help_page
# Description: show help page information
#***************************************************************************
sub show_help_page {

	my ($HELP) = "\n\t usage: $0 -m[options] -i[infile] -s=[influenzavirus species]";

	$HELP  .= "\n\n\t # EVE Catalog Maintenance Tool\n";
	$HELP  .= "\n\t  -m=1  :   profile the EVE namespace based on current catalog";
	$HELP  .= "\n\t  -m=2  :   apply names to novel EVEs, referencing current catalog ";

	print $HELP;
}

#***************************************************************************
# Subroutine:  by number
# Description: by number - for use with perl 'sort'  (cryptic but works) 
#***************************************************************************
sub by_number { $a <=> $b }	

############################################################################
# EOF
############################################################################