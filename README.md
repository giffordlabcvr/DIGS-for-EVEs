# DIGS-for-EVEs

Welcome to the DIGS-for-EVEs repository! This repository contains a catalog of endogenous viral element (EVE) sequences recovered via database-integrated genome screening (DIGS). 

Whole genome sequence (WGS) assemblies screened in this project were obtained from the National Center for Biotechnology Information's [genome](https://www.ncbi.nlm.nih.gov/genome/) resource.

DIGS was performed using the DIGS tool, an open software framework available [here](https://giffordlabcvr.github.io/DIGS-tool/). 

## Directory Structure

The repository is organized to systematically categorize EVE loci based on host species groups, virus subdivisions, and catalog version, as follows: 

```
DIGS-for-EVEs/
└── eve/
    └── animals/
        └── vertebrates/
            └── nonretroviral/
                └── version-1.0/
                    ├── input/
                    └── output/
```

### Subdirectories

- `eve/`  
  Contains the versioned catalog of EVE loci.

  - `animals/`  
    Subdivision based on host species group.
  
    - `vertebrates/`  
      Further subdivision of the host group.

      - `nonretroviral/`  
        Subdivision by virus group, non-retroviral viruses in this case.

        - `version-1.0/`  
          Version of the catalog.

          - `input/`  
            Contains files used as input for the genome screen used to generate the catalog.
            
          - `output/`  
            Contains the results and summary of the genome screen.
            
## Detailed Contents

### `input/` Directory

- Virus polypeptide probe sequences used for screening (FASTA format).
- Reference protein sequence library used  for classifying hits recovered by screening (FASTA format).
- Details of the WGS assemblies screened in this project (assembly files are not included due to their large file sizes).
- Control file used with the [DIGS tool](https://giffordlabcvr.github.io/DIGS-tool/) to implement this screen.

### `output/` Directory
  
- Tables exported from screening databases (includes 'digs_results' table with nucleotide sequences of EVE loci).
- Summary statistics desribing screening results.
- A catalog of endogenous viral element loci identified within this host group.


## Standardised Nomenclature for EVE loci

In DIGS-for-EVEs we have applied a systematic approach to naming of non-retroviral EVEs, following a [previously developed](https://doi.org/10.1186/s12977-018-0442-1) convention. Each element is assigned a unique identifier (ID) constructed from three components, separated by hyphens:

e.g. **EBLG-Carbovirus.2-Boreoeutheria**

- **The first component** identifies the type of EVE (EBLG). Please see below for a glossary of EVE types.

- **The second component**, a combination of two distinct subcomponents separated by a period, defines:
  - (i) The name of the taxonomic group from which the EVE derives (Carbovirus).
  - (ii) A numeric ID (2) that uniquely identifies the insertion within the EVE category and taxonomic group to which it has been assigned. Orthologous copies in different species share the same number.

- **The third component** of the ID specifies the host species or species group in which the EVE occurs (magnorder Boreoeutheria). For EVEs only known to occur in a single species, the Latin binomial species name is given. Where EVEs are shared across multiple species, we provide a taxonomic group name to capture that range of species. 

This systematic naming approach facilitates clear identification and comparison of EVEs across different species and research contexts.

**Please note the following**: 

1. EVEs were assigned to virus taxonomic groups as accurately as possible based on phylogenetic/genomic analysis. For EVEs that could not be confidently assigned to a subgroup, the lowest taxonomic rank possible for the EVE type is given (i.e. family).
2. We grouped sets of orthologous EVEs using shared numeric IDs. However, some orthologous relationships might have been missed, and some EVEs may have been incorrectly grouped as orthologs when they are actually distinct, paralogous loci. The 'digs_results' table includes information on how well each locus matched its assigned ortholog group via BLAST, providing a way to assess the confidence in these orthology designations.
3. When EVEs occur in a single species, the corresponding Latin binomial species name is provided. When EVEs occur as orthologs in multiple species, we provide the taxonomic name of the species group. If the species set corresponds to an unranked clade, we use the name of the closest named group at a lower rank and add the abbreviation 'UR' (unranked) to indicate that no named clade perfectly captures the range of species in which the EVE is found.
4. Although the naming convention used here was originally developed for ERVs, we have not yet applied it to ERV loci recovered via DIGS. Given the vast number of ERV loci present in vertebrate genomes, this will inevitably pose more significant challenges and require a longer-term effort compared to non-retroviral EVEs.


### Glossary of EVE Types:

#### DNA viruses & Retroviruses

- **ECV**: Endogenous Circovirus-like Element
- **EPV**: Endogenous Parvovirus-like Element
- **ERV**: Endogenous Retrovirus
- **eHBV**: Endogenous Hepatitis B Virus
- **ciHV**: Chromosomally-Integrated Herpesvirus

#### RNA viruses

- **EBLG**: Endogenous Borna-like Glycoprotein
- **EBLL**: Endogenous Borna-like L Protein
- **EBLN**: Endogenous Borna-like Nucleoprotein
- **EBLM**: Endogenous Borna-like Matrix protein
- **EFLH**: Endogenous Filo-like VP30
- **EFLN**: Endogenous Filo-like Nucleoprotein
- **EFLL**: Endogenous Filo-like L Protein
- **EFLP**: Endogenous Filo-like Phosphoprotein
- **ECLL**: Endogenous Chu-like L Protein
- **ECLN**: Endogenous Chu-like Nucleoprotein
- **ECLM**: Endogenous Chu-like Matrix protein
- **EPLL**: Endogenous Paramxyo-like L Protein
- **EPLN**: Endogenous Paramxyo-like Nucleoprotein
- **EPLH**: Endogenous Paramxyo-like Hemagglutinin (HA)-Neuraminidase Protein
- **EFL**: Endogenous Flavivirus-like Element

## References

Investigations of  data generated in this project have been reported in the following open access publications:

1. Blanco-Melo, D., et al. (2024). A novel approach to exploring the dark genome and its application to mapping of the vertebrate virus ‘fossil record’. *Genome Biology*, 25, Article number: 120 

2. Campbell, M.A., et al. (2022). Comparative analysis reveals the long-term coevolutionary history of parvoviruses and vertebrates. *PLoS Biol*, 20(11): p. e3001867.

3. Bamford, C.G.G., et al. (2022). Comparative analysis of genome-encoded viral sequences reveals the evolutionary history of flavivirids (family *Flaviviridae*). *Virus Evol*, 8(2): p. veac085.

4. Lytras, S., G. Arriagada, and R.J. Gifford. (2021). Ancient evolution of hepadnaviral paleoviruses and their impact on host genomes. *Virus Evol*, 7(1): p. veab012.

5. Dennis, T.P.W., et al. (2019). The evolution, distribution and diversity of endogenous circoviral elements in vertebrate genomes. *Virus Res*, 262: p. 15-23.

6. Dennis, T.P.W., et al. (2018). Insights into Circovirus host range from the genomic fossil record. J Virol, 92(16).

7. Pénzes, J.J., et al. (2018). Endogenous amdoparvovirus-related elements reveal insights into the biology and evolution of vertebrate parvoviruses. *Virus Evol*, 4(2): p. vey026.

8. Blanco-Melo, D., R.J. Gifford, and P.D. Bieniasz (2018). Reconstruction of a replication-competent ancestral murine endogenous retrovirus-L. Retrovirology, 15(1): p. 34.
   
9. Souza, W.M., et al. (2017). Chapparvoviruses occur in at least three vertebrate classes and have a broad biogeographic distribution. *J Gen Virol*, 98(2): p. 225-229.
    
10. Blanco-Melo, D., R.J. Gifford, and P.D. Bieniasz (2017) Co-option of an endogenous retrovirus envelope for host defense in hominid ancestors. Elife, 6.



## Contributing

We welcome contributions from the EVE research community! If you're interested in contributing to DIGS-for-EVEs, please review our [Contribution Guidelines](./md/CONTRIBUTING.md).

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](./md/code_of_conduct.md) 

## License

The project is licensed under the [GNU Affero General Public License v. 3.0](https://www.gnu.org/licenses/agpl-3.0.en.html)

## Contact

For questions, issues, or feedback, please open an issue on the [GitHub repository](https://github.com/giffordlabcvr/DIGS-for-EVEs/issues).

