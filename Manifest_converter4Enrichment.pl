#!/usr/bin/perl -w
# Manifest_converter for illumina Enrichment
# writer: Jeffreyy C.H. Yu
# version: 0.0
# Date: 2019.08.09

use strict;
use Data::Dumper;
use Getopt::Long;

my ($help,$bed,$prefilename)=();
my $genome = "  ";
GetOptions(
	"help|h" => \$help,
	"bed=s"  => \$bed,
	"prename|p=s" => \$prefilename,
	"genome|g=s"  => \$genome,
);

# help function
if($help){
	&Help();
	exit;
}	

# chromsome sorting
my @chromosome = (
	"chr1",
   	"chr2",
   	"chr3",
   	"chr4",
   	"chr5",
   	"chr6",
   	"chr7",
   	"chr8",
   	"chr9",
   	"chr10",
   	"chr11",
   	"chr12",
   	"chr13",
   	"chr14",
   	"chr15",
   	"chr16",
   	"chr17",
   	"chr18",
   	"chr19",
   	"chr20",
   	"chr21",
   	"chr22",
   	"chrX",
   	"chrY",
   	"chrM"
);

# set bed file
if(!$bed){
	$bed = $ARGV[0];
}

# set variable
my @header = ();
my %chr_variant = ();
# load bed format file
open(IN, "<$bed") or die "file $bed: $!\n";
while(<IN>){

	# if the line is nothing then skip
	if($_ eq "\n"){
		next;
	}

	# discard the change line for everyone line
	chomp;

	# deal with the contect start with #
	if($_ =~ /^#/){
		push(@header,$_);
	}

	# deal with the genome range contect
	if($_ !~ /^#/){
		my @v = split("\t",$_);
		# bed format:
		# chr start end name
		my $chr = $v[0];
		push(@{$chr_variant{$chr}},$_);
	}
}

close IN;


# create the manifest file name
my ($manifestname) =();
if($ARGV[1]){
	if($ARGV[1]=~/\.txt$/){
		$manifestname=$ARGV[1];
	}else{
		$manifestname=$ARGV[1]."_manifest.txt";
	}
}else{
	($prefilename) = $bed=~/(.+)\.bed$/;
	$manifestname=$prefilename."_manifest.txt";
}

# transfer to manifest of enrichment and output
# create a file
open(OUT, ">$manifestname");

# print the header
print OUT join("\n",@header);
if(@header){
	print OUT ("\n");
}
print OUT ("[Header]\n");
print OUT ("Manifest Version\t1\n");
print OUT ("ReferenceGenome\t$genome\n");

#print the region title
print OUT ("\n");
print OUT ("[Regions]\n");
print OUT ("Name\tChromosome\tStart\tEnd\tUpstream Probe Length\tDownstream Probe Length\n");

# print the genome range into manifest format
foreach my $c (@chromosome){
	foreach my $v (@{ $chr_variant{$c} }){
		# bed format:
		# chr start end name
		# manifest 1 format:
		# name chr start end 
	
		my @v= split("\t",$v);
		$v[1]+=1;
		print OUT ("$v[3]\t$v[0]\t$v[1]\t$v[2]\t0\t0\n");

	}
}
close OUT;

############################################################

sub Help{
print <<EOF;

Usage: 
Manifest_converter4Enrichment.pl [-bed] file.bed

Options:
-help | -h   : show this message.
-bed         : input bed file.
-prename | -p: output manifest prefile name.
-genome | -g : the genome fasta file 

e.g.:
Manifest_converter4Enrichment.pl file.bed
Manifest_converter4Enrichment.pl [-bed] file.bed
Manifest_converter4Enrichment.pl -bed file.bed -prename cancer_panel

EOF
}
