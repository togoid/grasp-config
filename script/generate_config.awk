### 

function snake2camel(s,
                     n, b, camel) {
    n = split(s, b, "_")
    camel = ""
    for(i=1; i<=n; i++)
        camel = camel toupper(substr(b[i], 1, 1)) substr(b[i], 2)
    return camel
}

BEGIN {
    FS = "\t"
    if (!dest) {
        print "usage: awk -f generate_config.awk -v dest=path/to/output_dir source_turtle" > "/dev/stderr"
        exit 1
    }
    prefix_yaml = dest "/prefix.yaml"
    model_yaml = dest "/model.yaml"
    endpoint_yaml = dest "/endpoint.yaml"
}

/^@prefix/ {
    gsub(/^@prefix /, "", $0)
    gsub(/ \.$/, "", $0)
    print > prefix_yaml
}

$2=="dcterms:identifier" {
    split($1, b, ":")
    ds = snake2camel(b[1])
    gsub(/ \.$/, "", $3)
    print "- " ds " " $1 ":" > model_yaml
    print "  - dcterms:identifier:" > model_yaml
    print "    - id: " $3 > model_yaml
}

$2=="rdfs:label" {
    gsub(/ \.$/, "", $3)
    print "  - rdfs:label:" > model_yaml
    print "    - label: " $3 > model_yaml
    nextfile
}

END {
    print "endpoint: http://ep.dbcls.jp/togoid/sparql" > endpoint_yaml
}
