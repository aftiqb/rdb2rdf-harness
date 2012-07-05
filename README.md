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

Download the test suite:

    cd rdb2rdf-harness
    hg clone https://dvcs.w3.org/hg/rdb2rdf-tests
    
Copy the `rdb2rdf-tests` directory into `rdb2rdf-harness` directory

make the following changes in `all-dm-tests.sh`

    ./dm-test_earl.sh $TESTCASE

where `dm-test_earl.sh` is an updated script file which generates direct mappings into each specific test case directory

and run the following command which will generate the direct mappings for each test case separately using D2RQ

    ./all-dm-tests.sh

make the following changes in `all-r2rml-tests.sh`

    ./r2rml-test_earl.sh $TESTCASE

where `r2rml-test_earl.sh` is an updated script file which only generate r2rml mappings into each specific test case directory

and run the following command which will generates the r2rml mappings for each test case separately using D2RQ

    ./all-r2rml-tests.sh

By now, we will have directGraph-d2rq.ttl and mapped(x)-d2rq.nq in each test case directory of `rdb2rdf-tests/`

Download the test harness from [here](http://mccarthy.dia.fi.upm.es/rdb2rdf/tc/th/rdb2rdf-th_bin_0.0.8.zip), unzip it and make the following changes in `ts.ttl` file

    rdb2rdftest:workingDirectory "rdb2rdf-tests/" .

    doap:name "D2RQ" ;
    doap:homepage <http://d2rq.org> ;
    rdb2rdftest:dbms  r2rml:HSQLDB ;
    rdb2rdftest:implementsR2RML true .

Make sure that you have copied the `rdb2rdf-tests/` directory from `rdb2rdf-harness` into test harness (i.e., rdb2rdf-th_bin_0.0.8) directory.

Run the following command:
    rdb2rdf-th ts.ttl