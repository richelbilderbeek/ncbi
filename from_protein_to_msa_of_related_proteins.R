# Use a protein from http://www.rcsb.org/search?request=%7B%22query%22%3A%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22and%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22terminal%22%2C%22service%22%3A%22text%22%2C%22parameters%22%3A%7B%22attribute%22%3A%22rcsb_membrane_lineage.id%22%2C%22operator%22%3A%22exact_match%22%2C%22value%22%3A%22TRANSMEMBRANE%20PROTEINS%3A%20ALPHA-HELICAL%22%7D%2C%22node_id%22%3A0%7D%2C%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22and%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22or%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22terminal%22%2C%22service%22%3A%22text%22%2C%22parameters%22%3A%7B%22attribute%22%3A%22rcsb_entity_source_organism.ncbi_scientific_name%22%2C%22operator%22%3A%22exact_match%22%2C%22value%22%3A%22Homo%20sapiens%22%7D%2C%22node_id%22%3A1%7D%5D%7D%2C%7B%22type%22%3A%22group%22%2C%22logical_operator%22%3A%22or%22%2C%22nodes%22%3A%5B%7B%22type%22%3A%22terminal%22%2C%22service%22%3A%22text%22%2C%22parameters%22%3A%7B%22attribute%22%3A%22rcsb_entry_info.resolution_combined%22%2C%22operator%22%3A%22range%22%2C%22value%22%3A%5B1.5%2C2%5D%7D%2C%22node_id%22%3A2%7D%5D%7D%5D%2C%22label%22%3A%22refinements%22%7D%5D%7D%2C%22return_type%22%3A%22polymer_entity%22%2C%22request_options%22%3A%7B%22pager%22%3A%7B%22start%22%3A0%2C%22rows%22%3A100%7D%2C%22scoring_strategy%22%3A%22combined%22%2C%22sort%22%3A%5B%7B%22sort_by%22%3A%22score%22%2C%22direction%22%3A%22desc%22%7D%5D%7D%2C%22request_info%22%3A%7B%22src%22%3A%22ui%22%2C%22query_id%22%3A%22b839a50d08d3420513588d67252eea67%22%7D%7D
protein <- "4ZW9"

# Find protein sequence
message("protein: ", protein)

hits <- rentrez::entrez_search(
  db = "protein",
  term = protein,
  rettype = "fasta"
)
message("hits$ids: ", paste0(hits$ids, collapse = " "))

fasta_raw <- rentrez::entrez_fetch(
  id = hits$ids[1],
  db = "protein",
  rettype = "fasta"
)
message("fasta_raw: ", fasta_raw)
fasta_text <- stringr::str_split(fasta_raw, pattern = "\n")[[1]]
seq <- paste0(fasta_text[-1], collapse = "")

t_secs <- 10

## Get similar sequence
sim_seq <- bio3d::blast.pdb(
  seq,
  database = "pdb",
  chain.single = TRUE
)

sequence_ids <- sim_seq$hit.tbl$subjectids

fasta_related <- rentrez::entrez_fetch(
  id = sequence_ids,
  db = "protein",
  rettype = "fasta"
)
filename <- "related_protein_sequences.fasta"
writeLines(text = fasta_related, con = filename)

#library(Biostrings)
sequences <- Biostrings::readAAStringSet(filename)
#library(msa)
msa <- msa::msa(
  inputSeqs = sequences,
  method = "ClustalOmega"
)

#library(bios2mds)
msa_as_bios2mds_align <- msaConvert(msa, "bios2mds::align")

bios2mds::export.fasta(msa_as_bios2mds_align, outfile = "msa.msa")
readLines("msa.msa")


library(bio3d)
