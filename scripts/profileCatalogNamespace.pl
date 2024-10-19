#!/usr/bin/perl
use strict;
use warnings;
use Text::CSV;
use Getopt::Long;

# Default file path
my $default_input_file = "path/to/your/eve_catalog.csv";
my $input_file = $default_input_file;

# Get command-line options
GetOptions(
    "f=s" => \$input_file,  # -f option to specify input file path
);

# Check if the specified file exists
unless (-e $input_file) {
    die "Error: Input file '$input_file' does not exist.\n";
}

# Now you can use $input_file in your script
print "Using input file: $input_file\n";

# Create output directory if it doesn't exist
mkdir $output_dir unless -d $output_dir;

# Initialize CSV parser
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

# Open the input file
open my $fh, "<", $input_file or die "Could not open '$input_file': $!";

# Read the header
my $header = $csv->getline($fh);

# Indexes of relevant columns
my %columns = (
    assigned_name => 0,
    eve_type => 1,
    eve_taxonomy => 2,
    eve_numeric_id => 3,
    eve_distribution => 4,
    virus_genome_type => 5,
    virus_family => 6,
    virus_genus => 7,
    organism => 8,
    tax_class => 9,
    superorder => 10,
    tax_order => 11,
    family => 12,
    genus => 13,
    target_version => 14,
    scaffold => 15,
    extract_start => 16,
    extract_end => 17,
    orientation => 18,
    bitscore => 19,
    identity => 20,
    sequence_length => 21,
);

# Hash to store EVE information by category
my %eve_info;

# Process each row in the input file
while (my $row = $csv->getline($fh)) {
    my $category = "$row->[$columns{eve_type}]-$row->[$columns{eve_taxonomy}]";
    my $id = $row->[$columns{eve_numeric_id}];
    
    push @{$eve_info{$category}}, {
        id => $id,
        host => $row->[$columns{eve_distribution}],
        status => 'active',
    };
}

close $fh;

# Write output files for each category
foreach my $category (keys %eve_info) {
    my $output_file = "$output_dir/$category.csv";
    open my $out, ">", $output_file or die "Could not open '$output_file': $!";
    
    print $out "ID,Host,Status\n";
    foreach my $eve (@{$eve_info{$category}}) {
        print $out "$eve->{id},$eve->{host},$eve->{status}\n";
    }
    
    close $out;
}

print "Namespace profiles have been generated.\n";
