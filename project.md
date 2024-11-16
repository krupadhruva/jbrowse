# BioE131 final project description: Fall 2024

Emergent viral pathogens remain a global threat to human health (Bhadoria et al, 2021). In the past two decades, the world has experienced three coronavirus (SARS-CoV-1, MERS, and SARS-CoV-2), one influenza (H1N1 Swine Flu), one filovirus (Ebola) and one flavivirus pandemic (Zika). (There have also, of course, been numerous viral epidemics, which are also serious events.) The mechanisms which explain the severity of pandemic-level infections are poorly understood, making it impossible to predict with precision which viral family will be the next to reach pandemic status, although past epidemiological history and human encroachment on viral habitats do narrow the shortlist somewhat (Neumann et al, 2023; Marie et al, 2023).

When \- not if \- the next major viral disease hits, there will (as in 2019-2020) be an early scramble to identify the causal viral pathogen and understand its biology and its evolution. This understanding will form a critical part of the immediate biomedical response. It will be useful for bioinformatics resources to be available ahead of this event, ready for use by researchers.

Viruses evolve too quickly to build a giant genome alignment of all viral families. However, within each viral family, it is entirely possible to build genome alignments, prepare genome annotations, and perform other preparatory analyses that may be helpful to future viral genomics researchers. Since, as in the COVID-19 pandemic, there are likely to be many small groups around the world working on different subproblems, each of which may seek to customize the analysis they perform (for example, to focus on regional variants of the virus, or to highlight particular applications such as vaccine development or protein structure), it will be helpful if each such group can install their own copy of the database and customize it as they see fit. This may form a useful complement to centralized resources such as the NIH’s Bacterial and Virus Bioinformatics Research Center (https://www.bv-brc.org/).

Your goal in this project is to build such a database, or more precisely a “database installer” (a software package that a research group can run to install their own local copy of the database), for one viral family. Each team will pick a viral family, ideally from one of the likely candidates for the next breakthrough pandemic.

**Teams can have up to four members.** It is also permissible to have single-person teams, for those who would rather contribute as an individual. For teams with \>1 member, specific contributions of individual team members must be clearly documented (one sentence per team member).

A list of suggested candidate families is included below; you may also wish to review Table 1 in Neumann et al (2023), or to the databases described in Ritsch et al (2023), among other sources. **It is OK if more than one team picks the same family.** However, it is also OK if you coordinate (e.g. on Ed) to avoid too many teams choosing the same family, or to try and focus on different aspects (though we will not specifically penalize multiple teams covering the same family, and will not regard such teams as being in any kind of zero-sum direct competition). In fact, we have no objection to you coordinating between teams to share tools, tips, or techniques. Anything that raises the bar for the entire class is good, and will (in fact) be specifically incentivized.

For the family that you choose, you will then create a GitHub repository that, when a user downloads and installs it (according to instructions which you will provide to users), will set up a local copy of the JBrowse2 genome browser (Diesh et al, 2023). Quick-start guides for installing JBrowse2 are given in the [documentation](https://jbrowse.org/jb2/docs/)

[Links to an external site.](https://jbrowse.org/jb2/docs/)

, with an even simpler step-by-step recipe in Diesh et al (2024). Some screenshots of its more advanced capabilities are shown in the [gallery](https://jbrowse.org/jb2/gallery/)

[Links to an external site.](https://jbrowse.org/jb2/gallery/)

. **The final lab for the class will be a JBrowse2-based lab,** so you should already have some experience setting it up, and you can focus on customization, data curation, and data integration for the project.

Ideally, the package itself should contain no data, but the code should instead download all data from stable URLs which are part of the configuration of your package (for example, from GenBank). However, you may find it necessary to include some data yourself, for example if there are any bioinformatics analyses that you have performed on the data that you wish to include. If you end up including some data, that is OK, but you should very clearly document what data is a result of your own analysis and what data comes from external trusted sources. After all, you do not want to muddy the provenance of the data as part of this process.

JBrowse2 is a very flexible software package with lots of installation options, so the above description leaves open a lot of possibilities for how you set up your viral database so as to be most useful to future pandemic researchers. There are lots of different kinds of data you might include. Will you try to include all viral genomes in the family (this might be overwhelming), or select a few genomes of interest (in which case, how will you select those genomes?) Will you focus on viruses that already infect humans or will you include animal hosts? Will you try to include synteny (alignments/evolutionary relationships) between the genomes that you select? What kind of genome annotation tracks will you include? Annotations of the main gene structures are probably essential, but maybe you can also include three-dimensional protein structure views? Mutations, perhaps with a focus on those involved in drug resistance or pathogenicity? Terminal repeats? RNA regulatory elements that are important for the viral lifecycle? Secondary structures in the genome, perhaps identified by computational analysis or by wet-lab experiment, whose function may be known or unknown? Maybe there are orthogonal types of data that you can include (phylogenetic trees, DNA or protein sequence alignments, protein 3D structures, host interactions, geographic or other metadata)? How well can you integrate all this information \- for example, by providing consistent information across many different viruses or strains in your family of choice, by providing links or indices between different aspects of the data, or by providing alternate or summary views (such as tables or maps)? Will you attempt to integrate other tools (e.g. RNA structure predictors, text indexing, or AI systems?) It will be impossible to include all these things in the time you have, so you will definitely need to make some choices.

Some of the data you choose to include may require that you perform some bioinformatics analysis, which may involve techniques that you learned in lectures or in lab. Other types of data (or bioinformatics analysis) may involve techniques that we have not covered, but which you may read about in the literature. We do not require that you only use techniques taught in BioE131/231 \- this exercise is open-ended. However we will require that you provide a justification of your choices.

Once the database is installed, in general we will expect it to run as a [static site](https://en.wikipedia.org/wiki/Static_web_page)

[Links to an external site.](https://en.wikipedia.org/wiki/Static_web_page)

, i.e. a set of webpages that do not require any server computation resources beyond a webserver that serves up HTML, JavaScript, CSS, image, and data files to client web browsers. (This is how JBrowse2 works.) However, your installation may involve running bioinformatics tools (in which case it should also download and install those tools), and/or you may pre-generate some data files and include them in your server.

## Grading

Your submission should include the following:

* A written report of at most two pages, supplied as a PDF file, that describes your thematic focus (including which viral genome family you elected to focus on and any other principles that guided your choice of content). Note: PDF means PDF. This file format should not be Microsoft Word, RTF, plain text, HTML, image file, or any other format but PDF  
* A link to a GitHub repository with documentation (e.g. a README) that describes how to set up and run your database  
* A working example of the database, installed in a web-visible location, to which you will also provide a link. One way to manage this is with [GitHub Pages](https://pages.github.com/)  
* [Links to an external site.](https://pages.github.com/)  
* . Alternatively, if you have a computer connected to the Internet with a static IP address, you can use that

 

We will be grading on the following criteria:

* A clearly-stated, unifying thematic focus that justifies your choice of content  
* Portable, well-documented software that other researchers will be able to run and understand  
* High quality data and/or analysis; appropriate use of bioinformatics tools or concepts  
* Comprehensive data (whatever your focus, you include a good sampling of available data in that area)  
* Strong data integration (e.g. consistent nomenclature and visual options, clear navigation links)  
* Good use of JBrowse2’s configuration and customization options, providing a high-quality visualization  
* Good presentation of your database (e.g. a front page, tools for navigation/indexing/search, etc.)  
* Clarity of textual presentation, including organization of ideas and a plain but precise writing style  
* Clear documentation of individual team members’ contributions (one short sentence per team member)  
* Any documented, nontrivial efforts that improved the quality of submissions for the rest of the class (e.g. provision of common tools or services, or advice/expertise that you made available)  
* Compliance with all other rubric given in this project description

### Research followup

Judging by class projects of previous years, we anticipate that some of the projects this year will be of very high quality. This year, we hope to offer a path by which the best contributors can (at their option) perform follow-up work in Spring 2025 to publish a peer-reviewed scientific paper on this work. Professor Holmes’ research group develops the JBrowse2 genome browser, and is interested in publishing tools allowing biologists to use JBrowse2 for viral genome analysis. Any contributors who are selected for this option will also be able to use this work for research credit (e.g. via BioE-196 or BioE-H194).

## Key dates

Teams (including team name, list of members, and virus family) to be [submitted here](https://bcourses.berkeley.edu/courses/1538361/assignments/8792079) by 5pm **Monday November 11**.

Final project submission is due by 5pm on **Monday December 9** (first day of RRR week).

This leaves four clear weeks between finalizing your team and submitting your final report (of course, you are free to finalize a team earlier if you get your act together in time.)

## Suggested content

### Suggested candidates for your virus family of choice

* Influenza virus   
* Lentivirus  
* Flavivirus  
* Filovirus   
* Coronavirus   
* Poxvirus  
* Picornavirus  
* Herpesvirus  
* Parvovirus

### Suggestions for the kinds of data you might seek to include

* Genomes of all/interesting species  
* Synteny maps between species (using JBrowse2’s [synteny features, Links to an external site.](https://jbrowse.org/jb2/docs/user_guides/linear_synteny_view/); see [documentation, Links to an external site.](https://jbrowse.org/jb2/docs/config_guides/synteny_track/))  
* Consistent gene structure annotations  
* Consistent repeat structure annotations (LTR/TIR/etc)  
* Regulatory element annotations, pre- and post-transcriptional  
* Protein structures, alignments  
* Variants of interest  
* Phenotypes: pathogenicity, drug resistance  
* Demographic/geographic metadata

## References

* Bhadoria P, Gupta G, Agarwal A. [Viral Pandemics in the Past Two Decades: An Overview](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8483091/)  
* [Links to an external site.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8483091/)  
* . J Family Med Prim Care. 2021 Aug;10(8):2745-2750. doi: 10.4103/jfmpc.jfmpc\_2071\_20. Epub 2021 Aug 27\. PMID: 34660399; PMCID: PMC8483091.  
* Diesh C, Buels R, Stevens G, Bridge C, Cain S, Stein L, Holmes I. [Setting Up the JBrowse 2 Genome Browser](https://currentprotocols.onlinelibrary.wiley.com/doi/full/10.1002/cpz1.1120)  
* [Links to an external site.](https://currentprotocols.onlinelibrary.wiley.com/doi/full/10.1002/cpz1.1120)  
* . Curr Protoc. 2024 Aug;4(8):e1120. doi: 10.1002/cpz1.1120. PMID: 39126338; PMCID: PMC11412189.  
* Diesh, C., Stevens, G.J., Xie, P. et al. [JBrowse 2: a modular genome browser with views of synteny and structural variation](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-023-02914-z)  
* [Links to an external site.](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-023-02914-z)  
* . Genome Biol 24, 74 (2023). https://doi.org/10.1186/s13059-023-02914-z  
* Marie V, Gordon ML. [The (Re-)Emergence and Spread of Viral Zoonotic Disease: A Perfect Storm of Human Ingenuity and Stupidity](https://pubmed.ncbi.nlm.nih.gov/37631981/)  
* [Links to an external site.](https://pubmed.ncbi.nlm.nih.gov/37631981/)  
* . Viruses. 2023 Jul 27;15(8):1638. doi: 10.3390/v15081638. PMID: 37631981; PMCID: PMC10458268.  
* Neumann G, Kawaoka Y. [Which Virus Will Cause the Next Pandemic?](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9864092/)  
* [Links to an external site.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9864092/)  
*  Viruses. 2023 Jan 10;15(1):199. doi: 10.3390/v15010199. PMID: 36680238; PMCID: PMC9864092.  
* Ritsch M, Cassman NA, Saghaei S, Marz M. [Navigating the Landscape: A Comprehensive Review of Current Virus Databases](https://pubmed.ncbi.nlm.nih.gov/37766241/)  
* [Links to an external site.](https://pubmed.ncbi.nlm.nih.gov/37766241/)  
* . Viruses. 2023 Aug 29;15(9):1834. doi: 10.3390/v15091834. PMID: 37766241; PMCID: PMC10537806.

