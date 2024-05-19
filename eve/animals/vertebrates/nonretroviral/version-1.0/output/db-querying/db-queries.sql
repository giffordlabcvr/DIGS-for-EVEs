# Get all DIGS EVE results and include virus taxonomy


SELECT digs_results.assigned_name, virus_taxonomy.tax_class as 'virus_genome_type', virus_taxonomy.family as 'virus_family', virus_taxonomy.genus as 'virus_genus', 

digs_results.organism, digs_results.target_version, digs_results.scaffold, digs_results.extract_start, digs_results.extract_end, digs_results.orientation, 
digs_results.bitscore, digs_results.identity, digs_results.sequence_length, digs_results.sequence

FROM digs_results, virus_taxonomy

WHERE digs_results.assigned_name = virus_taxonomy.name

ORDER BY virus_genome_type, virus_taxonomy.family,  virus_taxonomy.genus, digs_results.scaffold, digs_results.bitscore DESC


# Get all DIGS EVE results and include virus and host taxonomy


SELECT digs_results.assigned_name, virus_taxonomy.tax_class as 'virus_genome_type', virus_taxonomy.family as 'virus_family', virus_taxonomy.genus as 'virus_genus', 
host_taxonomy.tax_class as 'host_class', host_taxonomy.superorder as 'host_superorder', host_taxonomy.tax_order as 'host_order', host_taxonomy.family as 'host_family', host_taxonomy.genus as 'host_genus',
digs_results.organism, digs_results.target_version, digs_results.scaffold, digs_results.extract_start, digs_results.extract_end, digs_results.orientation, 
digs_results.bitscore, digs_results.identity, digs_results.sequence_length, digs_results.sequence

FROM digs_results, virus_taxonomy, host_taxonomy

WHERE digs_results.assigned_name = virus_taxonomy.name
AND host_taxonomy.species = organism

ORDER BY virus_taxonomy.tax_class, virus_taxonomy.family,  virus_taxonomy.genus, digs_results.scaffold, digs_results.bitscore DESC