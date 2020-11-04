# How to, starting from a protein name,
# get to a multiple sequence alignment of related proteins

# Use a protein from http://www.rcsb.org/search?request=%7B%22query%22%3A%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22and%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22terminal%22%2C%22service%22%3A%22text%22%2C%22parameters%22%3A%7B%22attribute%22%3A%22rcsb_membrane_lineage.id%22%2C%22operator%22%3A%22exact_match%22%2C%22value%22%3A%22TRANSMEMBRANE%20PROTEINS%3A%20ALPHA-HELICAL%22%7D%2C%22node_id%22%3A0%7D%2C%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22and%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22or%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22terminal%22%2C%22service%22%3A%22text%22%2C%22parameters%22%3A%7B%22attribute%22%3A%22rcsb_entity_source_organism.ncbi_scientific_name%22%2C%22operator%22%3A%22exact_match%22%2C%22value%22%3A%22Homo%20sapiens%22%7D%2C%22node_id%22%3A1%7D%5D%7D%2C%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22or%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22terminal%22%2C%22service%22%3A%22text%22%2C%22parameters%22%3A%7B%22attribute%22%3A%22rcsb_entry_info.resolution_combined%22%2C%22operator%22%3A%22range%22%2C%22value%22%3A%5B1.5%2C2%5D%7D%2C%22node_id%22%3A2%7D%5D%7D%5D%2C%22label%22%3A%22refinements%22%7D%5D%7D%2C%22return_type%22%3A%22polymer_entity%22%2C%22request_options%22%3A%7B%22pager%22%3A%7B%22start%22%3A0%2C%22rows%22%3A100%7D%2C%22scoring_strategy%22%3A%22combined%22%2C%22sort%22%3A%5B%7B%22sort_by%22%3A%22score%22%2C%22direction%22%3A%22desc%22%7D%5D%7D%2C%22request_info%22%3A%7B%22src%22%3A%22ui%22%2C%22query_id%22%3A%22b839a50d08d3420513588d67252eea67%22%7D%7D
protein <- "4ZW9"

# Find protein IDs
message("protein: ", protein)
protein_ids <- search_protein_ids(protein)
message("protein_ids: ", paste0(protein_ids, collapse = " "))

sequence <- fetch_sequence_from_protein_id(protein_ids[1])
message("names(sequence): ", names(sequence))
message("sequence: ", sequence)

# Get the ID of similar sequences, may take some minutes!
blastp_result <- bio3d::blast.pdb(sequence)
similar_subject_ids <- blastp_result$hit.tbl$subjectids

fasta_text <- fetch_sequences_from_subject_ids(subject_ids = similar_subject_ids)

aligned_fasta_text <- create_msa(fasta_text)


# Get the AA sequences from the IDs of similar sequences
fasta_filename <- tempfile()
writeLines(text = fasta_text, con = fasta_filename)
sequences <- Biostrings::readAAStringSet(fasta_filename)

# Multiple sequence alignment
# Fails: 'object 'msaClustalOmega' of mode 'function' was not found'
msa <- msa::msa(
  inputSeqs = sequences,
  method = "ClustalOmega"
)

library(msa)
msa <- msa::msa(
  inputSeqs = sequences,
  method = "ClustalOmega"
)

msa_as_bios2mds_align <- msa::msaConvert(msa, "bios2mds::align")
bios2mds::export.fasta(msa_as_bios2mds_align, outfile = "~/msa_from_r.aln")
