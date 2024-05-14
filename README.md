# DIGS-for-EVEs

Welcome to the DIGS-for-EVEs repository! This repository contains a catalog of endogenous viral element (EVE) sequences recovered via database-integrated genome screening (DIGS). 

Whole genome sequence (WGS) assemblies screened in this project were obtained from the National Center for Biotechnology Information's [genome](https://www.ncbi.nlm.nih.gov/genome/) resource. DIGS was performed using the DIGS tool, an open software framework available [here](https://giffordlabcvr.github.io/DIGS-tool/). 

Our aim is to provide researchers with comprehensive resources for studying EVEs. 

## Contents

1. **Input Files**:
    - Probe sequences used for DIGS (polypetide FASTA)
    - Reference sequence library used for DIGS (polypetide FASTA)
    - Details of the WGS assemblies screened in this project (the assemblies themselves are not included due to their large file sizes)
    - Control files used with the [DIGS tool](https://giffordlabcvr.github.io/DIGS-tool/)

2. **Output Data**: 
    - Exported tables from the screening databases

## Standardised Nomenclature for EVE loci

In DIGS-for-EVEs we have applied a systematic approach to naming Endogenous Viral Elements (EVEs), following a convention [developed for endogenous retroviruses](https://doi.org/10.1186/s12977-018-0442-1). Each element is assigned a unique identifier (ID) constructed from a defined set of components, separated by hyphens: e.g. **EBLG-Carbovirus.2-Boreoeutheria**


- The **first component** identifies the type of EVE. (Please refer below for a glossary of EVE types defined thus far.)

- The **second component**, a combination of two distinct subcomponents separated by a period, defines:
  - (i) The name of the EVE group.
  - (ii) A numeric ID that uniquely identifies the insertion. Orthologous copies in different species share the same number.

- The **third component** of the ID specifies the set of host species in which the ortholog occurs.

This systematic naming approach facilitates clear identification and comparison of EVEs across different species and contexts.

### Glossary of EVE Types:

#### DNA viruses & Retroviruses

- **ECV**: Endogenous Circovirus-like Element
- **EPV**: Endogenous Parvovirus-like Element
- **ERV**: Endogenous Retrovirus
- **EHBV**: Endogenous Hepatitis B Virus
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

3. Bamford, C.G.G., et al. (2022). Comparative analysis of genome-encoded viral sequences reveals the evolutionary history of flavivirids (family Flaviviridae). *Virus Evol*, 8(2): p. veac085.

4. Lytras, S., G. Arriagada, and R.J. Gifford. (2021). Ancient evolution of hepadnaviral paleoviruses and their impact on host genomes. *Virus Evol*, 7(1): p. veab012.

5. Dennis, T.P.W., et al. (2019). The evolution, distribution and diversity of endogenous circoviral elements in vertebrate genomes. *Virus Res*, 262: p. 15-23.

6. Pénzes, J.J., et al. (2018). Endogenous amdoparvovirus-related elements reveal insights into the biology and evolution of vertebrate parvoviruses. *Virus Evol*, 4(2): p. vey026.

7. Souza, W.M., et al. (2017). Chapparvoviruses occur in at least three vertebrate classes and have a broad biogeographic distribution. *J Gen Virol*, 98(2): p. 225-229.


## Contributing

We welcome contributions from the community! If you're interested in contributing to DIGS-for-EVEs, please review our [Contribution Guidelines](./md/CONTRIBUTING.md).

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](./md/code_of_conduct.md) 

## License

The project is licensed under the [GNU Affero General Public License v. 3.0](https://www.gnu.org/licenses/agpl-3.0.en.html)

## Contact

For questions, issues, or feedback, please open an issue on the [GitHub repository](https://github.com/giffordlabcvr/DIGS-for-EVEs/issues).
