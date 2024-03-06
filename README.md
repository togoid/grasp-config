# grasp-config

Install [rdf-config](https://github.com/dbcls/rdf-config) and run the following command to generate config files for grasp under the `togoid-grasp` directory.

```
% rdf-config --config rdf-config/* --grasp togoid-grasp
```

Some .graphql files generated by the above command need manual modification. Manually modified .graphql files are stored in the `modified/` directory.  
After updating config files in `rdf-config` and generating the updated .graphql files, the files in the `modified/` directory must be copied to the `togoid-grasp/` directory.

Install [Grasp](https://github.com/dbcls/grasp) and point the above directory to launch the Grasp server.

```
RESOURCES_DIR=./togoid-grasp npm run watch
```

Example query:

```
query {
  Ncbigene(id: ["1", "2"]) {
    label
    id
  }
  Uniprot(id: ["Q99999"]) {
    label
    id
    iri
  }
  Taxonomy(iri: ["http://identifiers.org/taxonomy/9646"]) {
    label
    id
  }
}
```
