#!/usr/bin/perl -w
############################################################################
# Module:      FluTool.pm
# Description: Command line interface to a data manipulation tool
# History:     November 2014: Created by Robert Gifford 
############################################################################
package FluTool;

############################################################################
# Import statements/packages (externally developed packages)
############################################################################
use strict;

############################################################################
# Import statements/packages (internally developed packages)
############################################################################

# Base classes
use Base::BioIO;
use Base::FileIO;
use Base::SeqIO;
use Base::DevTools;
use Base::Console;
use Base::Sequence; 
use Interface::BLAST; 

############################################################################
# Globals
############################################################################

# Base class instantiations
my $fileio       = FileIO->new();
my $seqio        = SeqIO->new();
my $bioio        = BioIO->new();
my $devtools     = DevTools->new();
my $console      = Console->new();
my $blast_obj    = BLAST->new();
my $output_dir   = './output';
1;

############################################################################
# LIFECYCLE
############################################################################

#***************************************************************************
# Subroutine:  new
# Description: Parameters
#***************************************************************************
sub new {

	my ($invocant, $parameter_ref) = @_;
	my $class = ref($invocant) || $invocant;

	# Set member variables
	my $self = {
		
		# Member variables
		process_id           => $parameter_ref->{process_id},
		
		# Paths
		rsl_path             => $parameter_ref->{rsl_path},
		output_path          => $parameter_ref->{output_path},
		tmp_path             => $parameter_ref->{tmp_path},
		isolate_path         => $parameter_ref->{isolate_path},

	};
	
	bless ($self, $class);
	return $self;
}


############################################################################
# TOP LEVEL HANDLERS
############################################################################

#***************************************************************************
# Subroutine:  run_flu_epi_tool_task
# Description: hand off to utility functions
#***************************************************************************
sub run_flu_epi_tool_task {

	my ($self, $infile, $mode) = @_;

	$self->show_title();

	my $result;
	if    ($mode eq 1) {  # Batch BLAST against reference sequence library 
		$result = $self->batch_blast_against_rsl($infile);
	}
	else { die; }
	
	return $result;

}

#***************************************************************************
# Subroutine:  batch_blast_against_rsl
# Description: Batch BLAST against reference sequence library to find most
#              similar sequences to those in an input FASTA file
#***************************************************************************
sub batch_blast_against_rsl {

	my ($self, $infile) = @_;

	my $lib_path = $self->{rsl_path};
	my $tmp_path = $self->{tmp_path};
	my $output_path = $self->{output_path};
	unless ($lib_path and $tmp_path and $output_path) { die; }

    # Index isolate data by accession number
	my %isolate_by_accession;
	my %segment_by_accession;

	$self->index_isolate_data(\%isolate_by_accession, \%segment_by_accession);
	#$devtools->print_hash(\%isolate_by_accession); die;
	#$devtools->print_hash(\%segment_by_accession); die;

	# Read FASTA input
	my @input_fasta;
	$seqio->read_fasta($infile, \@input_fasta);
	#$devtools->print_array(\@input_fasta); die;

	# BLAST each sequence in the input file against the RSL	
	my %not_found;
	foreach my $seq_ref (@input_fasta) {

		# Get required data about the query sequence
		my $seq_id   = $seq_ref->{sequence_id};
		my $header   = $seq_ref->{header};
		my $sequence = $seq_ref->{sequence};

		# Make a FASTA query file
		my $fasta      = ">$seq_id\n$sequence";
		my $query_file = $tmp_path . '/TEMPORARY.fna';
		$fileio->write_text_to_file($query_file, $fasta);
		my $result_file = $tmp_path . "/$seq_id.blast_result.tsv";

		# Execute the call to BLAST and parse the results
		$blast_obj->blast('/Users/rob/blast/bin/blastn', $lib_path, $query_file, $result_file);
		my @results;
		$blast_obj->parse_tab_format_results($result_file, \@results);
		#$devtools->print_array(\@results); die;
		
		# Clean up 
		system "rm $result_file";
        
        my $i = '0';
        my @closest_blast_matches;
        do {
            
            # code block
            my $hit_ref = $results[$i];
            #$devtools->print_hash($hit_ref); die;
            my $accession = $hit_ref->{'scaffold'};
            #print "\n\t Match $accession";
            my $segment = $segment_by_accession{$accession};
            $i++;

            if ($segment) {
            
				my $isolate_ref = $isolate_by_accession{$accession};
				#$devtools->print_hash($isolate_ref); die;
				my $hn_subtype  = $isolate_ref->{hn_subtype};
				my $iso_year    = $isolate_ref->{iso_year};
				my $iso_country = $isolate_ref->{iso_country};
				my $strain_id   = $isolate_ref->{strain_id};          
				print "\n\t Match $i: $accession (segment $segment): isolate ($strain_id), country ($iso_country), year ($iso_year), subtype ($hn_subtype)";
            	my $line = "$header\t$seq_id\t$accession\t$segment\t$strain_id\t$iso_country\t$iso_year\t$hn_subtype\n";
            	push (@closest_blast_matches, $line);
            	
            	# Copy the sequence to the a dedicated source directory
            	my $source_file_path = '/Users/rob/Sources/flu/iav-ncbi-curated-segment-' . $segment . '/' . $accession . '.xml';
            	my $destination_path = 'output/iav_refseq_selection_segment' . $segment;
		        my $command = "cp $source_file_path $destination_path";
		        print "\n\t command: $command\n\n"; 
		        system "$command";
            	
            }
            else {
            
 				print "\n\t Match $i: $accession NOT FOUND!";
 				$not_found{$accession} = 1;
           
            }
            
        } until($i eq 500);
        
        #die;
        # Write the top 500 results file for this input sequence
        #my $file_name = 'output/tabular/' . $seq_id . '-top500_matches.tsv';
        #$fileio->write_file($file_name, \@closest_blast_matches); 

	}

    # Write file of accessions not found in tabular data
	my @missing_accessions = keys %not_found;
	my $missing_accessions_file = 'output/tabular/missing_accessions.tsv';
    $fileio->write_file($missing_accessions_file, \@missing_accessions); 


}

#***************************************************************************
# Subroutine:  index_isolate_data
# Description: generate two hashes that link:
#              (i)  accession to isolate
#              (ii) accession to segment
#***************************************************************************
sub index_isolate_data {

	my ($self, $iso_index_ref, $segment_index_ref) = @_;

	my $iso_path = $self->{isolate_path};

	my @isolate_data;
	$fileio->read_file($iso_path, \@isolate_data);
	#$devtools->print_array(\@isolate_data); die;
	
	# Set up isolate file column headers
	my %isolate_headers;
	my $isolate_header_row = shift @isolate_data;
	chomp $isolate_header_row;
	my @isolate_header_row = split("\t", $isolate_header_row);	
	my $j=0;
	foreach my $value (@isolate_header_row) {
		$j++;
		$isolate_headers{$j} = $value;
	}

	foreach my $isolate_row (@isolate_data) {
	
		my %isolate_row;
		get_row_values_by_column_header($isolate_row, \%isolate_headers, \%isolate_row);
		#$devtools->print_hash(\%isolate_row); die;

		# Get relevant row values
		my $strain_id = $isolate_row{strain_id};
		my $segment1_accession = $isolate_row{segment1_accession};
		my $segment2_accession = $isolate_row{segment2_accession};
		my $segment3_accession = $isolate_row{segment3_accession};
		my $segment4_accession = $isolate_row{segment4_accession};
		my $segment5_accession = $isolate_row{segment5_accession};
		my $segment6_accession = $isolate_row{segment6_accession};
		my $segment7_accession = $isolate_row{segment7_accession};
		my $segment8_accession = $isolate_row{segment8_accession};

        $segment_index_ref->{$segment1_accession} = '1';
        $segment_index_ref->{$segment2_accession} = '2';
        $segment_index_ref->{$segment3_accession} = '3';
        $segment_index_ref->{$segment4_accession} = '4';
        $segment_index_ref->{$segment5_accession} = '5';
        $segment_index_ref->{$segment6_accession} = '6';
        $segment_index_ref->{$segment7_accession} = '7';
        $segment_index_ref->{$segment8_accession} = '8';

        $iso_index_ref->{$segment1_accession} = \%isolate_row;
        $iso_index_ref->{$segment2_accession} = \%isolate_row;;
        $iso_index_ref->{$segment3_accession} = \%isolate_row;;
        $iso_index_ref->{$segment4_accession} = \%isolate_row;;
        $iso_index_ref->{$segment5_accession} = \%isolate_row;;
        $iso_index_ref->{$segment6_accession} = \%isolate_row;;
        $iso_index_ref->{$segment7_accession} = \%isolate_row;;
        $iso_index_ref->{$segment8_accession} = \%isolate_row;;

	}	

}

#***************************************************************************
# Subroutine:  get_row_values_by_column_header
# Description: get a hash with field names linked to values for a table row
#***************************************************************************
sub get_row_values_by_column_header {

	my ($line, $column_header_ref, $result_ref) = @_;

	chomp $line;
	my @line = split("\t", $line);
	my $j=0;
	foreach my $value (@line) {

		$j++;
		my $column_name = $column_header_ref->{$j};
		
		if ($column_name) {
			$result_ref->{"$column_name"} = $value;
		}
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

	$console->refresh();
	my $title       = 'Flu genomics pipeline tool';
	my $version     = '2.0';
	my $description = 'A PERL tool supporting genetic epidemiology for influenza';
	my $author      = 'Robert J. Gifford';
	my $contact		= '<robjgiff@gmail.com>';
	$console->show_about_box($title, $version, $description, $author, $contact);
}

#***************************************************************************
# Subroutine:  show_help_page
# Description: show help page information
#***************************************************************************
sub show_help_page {

	my ($HELP) = "\n\t usage: $0 -m[options] -s[options] -i[infile]\n";

	$HELP  .= "\n\t  -m=1   :   Batch BLAST against reference sequence library";
	$HELP  .= "\n\t  -m=2   :   Extract reference sequence library subset for phylogenetic analysis";
	
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
