# Manifest format converter
writer: Jeffreyy Chunhui Yu

The Manifest format is used for the variant calling analysis of NGS data. It a format to tell the genome ranges user wanted, like bed format.
In the illumina **enrichment** and **DNA amplicon** analyze are need this format, but there is some difference.

## Enrichment
This **Enrichment** analysis pipeline is for WES or targeted DNA sequencing data to execute variant calling. 
On the illumina instrument, like NextSeq or MiniSeq, user can use **Local run manager (LRM)** to execute **Enrichment** module to call variant. 
On the BaseSpace, illumina NGS cloud solution, there is an app **[Enrichment](https://basespace.illumina.com/apps/6493487/Enrichment?preferredversion)** can do the analysis.

## DNA Amplicon
The **DNA Amplicon** analysis pipeline is for AmpliSeq, based on amplicon technical to get the genome range user wanted then NGS sequencing.
On the illumina instrument, user can all use **Local run manager (LRM)** to execute **DNA Amplicon** module to do analyze.
On the Basespace, There is the [DNA Amplicon](https://basespace.illumina.com/apps/8340332/DNA-Amplicon?preferredversion) app can do the analyze.

There are two script, one is for Enrichment, and the other is for DNA Amplicon. No matter on the illumina instrusment or BaseSpace, user all needs the manifest file as an input file.