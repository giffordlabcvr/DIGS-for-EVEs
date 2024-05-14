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

## Nomenclature for Endogenous Viral Elements (EVEs)

In DIGS-for-EVEs we have applied a systematic approach to naming Endogenous Viral Elements (EVEs), following a convention developed for endogenous retroviruses. Each element is assigned a unique identifier (ID) constructed from a defined set of components, separated by hyphens: e.g. **EBLG-Carbovirus.2-Boreoeutheria**


- The **first component** identifies the type of EVE. (Please refer below for a glossary of EVE types defined thus far.)

- The **second component**, a combination of two distinct subcomponents separated by a period, defines:
  - (i) The name of the EVE group.
  - (ii) A numeric ID that uniquely identifies the insertion. Orthologous copies in different species share the same number.

- The **third component** of the ID specifies the set of host species in which the ortholog occurs.

This systematic naming approach facilitates clear identification and comparison of EVEs across different species and contexts.


## Contributing

We welcome contributions from the community! If you're interested in contributing to DIGS-for-EVEs, please review our [Contribution Guidelines](./md/CONTRIBUTING.md).

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](./md/code_of_conduct.md) 

## License

The project is licensed under the [GNU Affero General Public License v. 3.0](https://www.gnu.org/licenses/agpl-3.0.en.html)

## Contact

For questions, issues, or feedback, please open an issue on the [GitHub repository](https://github.com/giffordlabcvr/DIGS-for-EVEs/issues).

