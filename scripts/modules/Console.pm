#!/usr/bin/perl -w
############################################################################
# Module:       Console.pm 
# Description:  Functions for text console programs 
# History:      Rob Gifford, November 2006: Creation
############################################################################
package Console;

############################################################################
# Import statements/packages (externally developed packages)
############################################################################
use strict;

############################################################################
# Import statements/packages (internally developed packages)
############################################################################

# Base classes
use FileIO;

############################################################################
# Globals
############################################################################

# Create base objects
my $fileio   = FileIO->new();
my $console_width = 70; # assumed width of the console
1;

############################################################################
# LIFECYCLE
############################################################################

#***************************************************************************
# Subroutine:  new
# Description: create new Console.pm object 
#***************************************************************************
sub new {

	my ($invocant, $parameter_ref) = @_;
	my $class = ref($invocant) || $invocant;

	# Member variables
	my $self = {

	};
	
	bless ($self, $class);
	return $self;
}

############################################################################
# Public Member Functions
############################################################################

#***************************************************************************
# Subroutine:  refresh_console
# Description: Clear the screen by sending the 'clear' command via 'system'
#***************************************************************************
sub refresh {

	my ($self) = @_;
	my $command = 'clear';
	system $command;
}

#***************************************************************************
# Subroutine:  show_about_box 
# Description: show a formatted title box for a console application
# Arguments:   the program description as a series of strings:
#              - $title, $version, $description, $author, $contact
#***************************************************************************
sub show_about_box {

	my ($self, $title, $version, $description, $author, $contact) = @_;

	my $solid_line  = "\n\t" . '#' x $console_width;
	my $border_line = "\n\t" . '#' . (' ' x ($console_width - 2)) . "#";

	# Format the text
	my $title_version   = $title . ' ' . $version; 
	
	my $f_title_version = enclose_box_text($title_version);
	my $f_description   = enclose_box_text($description);
	my $f_author        = enclose_box_text($author);
	my $f_contact       = enclose_box_text($contact);

	# Print the box
	print "\n\n";
	print $solid_line;
	print $border_line;
	print $f_title_version;
	print $f_description;
	print $f_author;
	print $f_contact;
	print $border_line;
	print $solid_line;
	print "\n\n"; 
}

############################################################################
# Getting user input via the console 
############################################################################

#***************************************************************************
# Subroutine:  ask_question
# Description: just ask a question and return the input
# Arguments:   $question: the question to ask 
# Returns:     $answer: the response of the user
#***************************************************************************
sub ask_question {

	my ($self, $question) = @_;
	
	print "$question : ";
	my $answer = <STDIN>;
	chomp $answer; 
	return $answer;
}

#***************************************************************************
# Subroutine:  ask_yes_no_question
# Description: ask a question and accept only 'y' or 'n' as an answer 
# Arguments:   $question: the question to ask 
# Returns:     $answer: the integer value entered by the user
#***************************************************************************
sub ask_yes_no_question {

	my ($self, $question) = @_;
	
	my $answer;
	do {
		print "$question " . "\(y\/n\): ";
		$answer = <STDIN>;
		chomp $answer; 
	} until ($answer eq 'n' or $answer eq 'y');

	return $answer;
}

#***************************************************************************
# Subroutine:  ask_simple_choice_question
# Description: ask a question and accept only a range of possible answers 
# Arguments:   $question: the question to ask 
#              $choice_ref: reference to an array with the possible choices
# Returns:     $answer: the integer value entered by the user
#***************************************************************************
sub ask_simple_choice_question {

	my ($self, $question, $choice_ref) = @_;

	# convert the choices array to a scalar
	my $choice_string = join('/', @$choice_ref);
	my $answer;
	my $answer_in_set = undef;
	do {
		print "$question " . "\($choice_string\): ";
		$answer = <STDIN>;
		chomp $answer; 
		foreach my $choice (@$choice_ref) {
			#print "\n\t '$choice' '$answer'";
			if ($answer eq $choice) {
				$answer_in_set = 'true';
			}
		}
		
	} until ($answer_in_set);

	return $answer;
}

#***************************************************************************
# Subroutine:  ask_float_question
# Description: ask a question and accept only float or int as a response
# Arguments:   $question: the question to ask 
# Returns:     $answer: the float value entered by the user
#***************************************************************************
sub ask_float_question {

	my ($self, $question) = @_;
	
	my $answer;
	do {
		print "$question : ";
		$answer = <STDIN>;
		chomp $answer; 
	} until ($answer =~ /^-?\d+\.?\d*$/);
	return $answer;
}

#***************************************************************************
# Subroutine:  ask_float_with_bounds_question
# Description: ask a question and accept only a float or int that falls
#              within a defined range as a response
# Arguments:   $question: the question to ask 
#              $lower_bound, $upper_bound: the specified bounds
# Returns:     $answer: the  value entered by the user
#***************************************************************************
sub ask_float_with_bounds_question {

	my ($self, $question, $lower_bound, $upper_bound) = @_;
	
	my $answer;
	do {
		print "$question \($lower_bound-$upper_bound\): ";
		$answer = <STDIN>;
		chomp $answer; 
	} until ($answer >= $lower_bound 
         and $answer <= $upper_bound
         and $answer =~ /^-?\d+\.?\d*$/
    );
	return $answer;
}

#***************************************************************************
# Subroutine:  ask_int_question
# Description: ask a question and accept only an integer as a response
# Arguments:   $question: the question to ask 
# Returns:     $answer: the integer value entered by the user
#***************************************************************************
sub ask_int_question {

	my ($self, $question) = @_;
	
	my $answer;
	do {
		print "$question : ";
		$answer = <STDIN>;
		chomp $answer; 
	} until ($answer =~ /\d/); # TODO: this isn't strict enough
	return $answer;
}

#***************************************************************************
# Subroutine:  ask_int_with_bounds_question
# Description: ask a question and accept only an integer that falls within
#              a defined range as a response
# Arguments:   $question: the question to ask 
#              $lower_bound, $upper_bound: the specified bounds
# Returns:     $answer: the integer value entered by the user
# TODO:        doesn't discriminate ints and floats
#***************************************************************************
sub ask_int_with_bounds_question {

	my ($self, $question, $lower_bound, $upper_bound) = @_;
	
	my $answer;
	do {
		print "$question \($lower_bound-$upper_bound\): ";
		$answer = <STDIN>;
		chomp $answer; 
	} until ($answer >= $lower_bound and $answer <= $upper_bound);
	return $answer;
}

############################################################################
# Private Member Functions
############################################################################

#***************************************************************************
# Subroutine:  enclose_box_text
# Description: Format text for an about box by centering it within a box 
#***************************************************************************
sub enclose_box_text {

	my ($text) = @_;

	my $f_text;
	my $left_spacing;
	my $right_spacing;
	my $text_length = length $text;
	
	if ($text_length > ($console_width - 4)) {
		die ("\n\t Title field was more than max length");
	
	}
	else {
		# calculate total white space
		my $space = ($console_width - ($text_length + 2));
		
		# use this value to centre text
		$left_spacing = $space / 2;
		my $adjust_for_uneven = $space % 2;
		$right_spacing = ($space / 2) + $adjust_for_uneven;
	}

	$f_text  = "\n\t#" . (' ' x $left_spacing);
	$f_text .= $text;
	$f_text .= (' ' x $right_spacing) . "#";

	return $f_text;
}

############################################################################
# EOF
############################################################################
