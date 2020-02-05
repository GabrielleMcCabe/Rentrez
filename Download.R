library(rentrez)

# A vector of unique IDs for records in the nuccore database.
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# Receive the sequences corresponding to the unique IDs in ncbi_ids from the nuccore database in fasta format. 
Bburg <- entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

print(Bburg)

# Create a new object that contains 3 elements, one for each sequence.
Sequences <- strsplit(Bburg, "\n\n")
print(Sequences)

# Convert the list to a dataframe.
Sequences<-unlist(Sequences)

# Separate the sequences from the headers.
header <- gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq <- gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences <- data.frame(Name=header,Sequence=seq)
print(Sequences)

# Remove the newline characters.
Sequences$Sequence <- gsub("\n", "", Sequences[1:3, "Sequence"])

# Output Sequences to Sequences.csv
write.csv(Sequences, "Sequences.csv")














