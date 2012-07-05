## RDB2RDF Test Harness

This is a set of shell scripts for running the W3C RDB2RDF test suite against an R2RML implementation or a Direct Mapping implementation.

### Prerequisites

* Unix environment (tested only on OS X)
* Jena's `rdfcopy` and `rdfcompare` command line tools on the path
* ARQ's `sparql` command line tool on the path
* Mercurial (to download the RDB2RDF test suite)

### Preparation

Download the test suite:

    cd rdb2rdf-harness
    hg clone https://dvcs.w3.org/hg/rdb2rdf-tests

Edit `run-dm.sh` to suit the Direct Mapping implementation under test. It is invoked like this, where `database.sql` is the location of a SQL file containing the input database, and `output.nt` is the filename where your tool has to drop the output in N-Triples format:

    run-dm.sh database.sql output.nt

Edit `run-dm.sh` to suit the Direct Mapping implementation under test. It is invoked like this, where `database.sql` is the location of a SQL file containing the input database, `mapping.ttl` is the location of an R2RML mapping file, and `output.nt` is the filename where your tool has to drop the output in N-Quads format:

    run-r2rml.sh database.sql mapping.ttl output.nq

### Running individual tests

    ./dm-test.sh D001
    ./r2rml-test.sh D001

The R2RML tester will run all tests in the `D001` directory. It currently cannot run just an individual test.

### Running all tests

    ./all-dm-tests.sh
    ./all-r2rml-tests.sh

### Generating earl reports

run the following command 

    ./run-all-tests.sh


Download the test harness from [here](http://mccarthy.dia.fi.upm.es/rdb2rdf/tc/th/rdb2rdf-th_bin_0.0.8.zip) and unzip into `rdb2rdf-harness` directory 

in `rdb2rdf-th_bin_0.0.8` directory, make the following changes in `ts.ttl` file

    rdb2rdftest:workingDirectory "../rdb2rdf-tests/" .

    doap:name "D2RQ" ;
    doap:homepage <http://d2rq.org> ;
    rdb2rdftest:dbms  r2rml:HSQLDB ;
    rdb2rdftest:implementsDirectMapping true ;
    rdb2rdftest:implementsR2RML true .


Run the following command from `rdb2rdf-th_bin_0.0.8` directory to generate the earl reports for direct mapping and r2rml:

    rdb2rdf-th ts.ttl