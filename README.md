# grasp-config

Install [rdf-config](https://github.com/dbcls/rdf-config) and run the following command to generate config files for grasp under the `togoid-grasp` directory.

```
% rdf-config --config rdf-config/* --grasp togoid-grasp
```

Install [Grasp](https://github.com/dbcls/grasp) and point the above directory to launch the Grasp server.

```
RESOURCES_DIR=./togoid-grasp npm run watch
```

Example query:

```
query {
  ChebiChEBI(iri: "http://purl.obolibrary.org/obo/CHEBI_17232") {
    label
    inchi
    mass
    smiles
  }
  RheaRhea(iri: "http://rdf.rhea-db.org/13973") {
    label
  }
  ClinvarClinVar(iri: "http://ncbi.nlm.nih.gov/clinvar/variation/18390") {
    label
  }
}
```

Notes:
* Currently, `type` in GraphQL is prefixed with capitalized config directory name (e.g., even UniProt is represented as the subject class in rdf-config/uniprot/model.yaml, UniprotUniProt will be used for `type`)
