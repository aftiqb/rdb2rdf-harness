#!/bin/bash
for TESTCASE in `find rdb2rdf-tests -name create.sql | sed "s/^.*\/\(D...\).*\/create.sql/\1/"`
do
    ./dm-test_earl.sh $TESTCASE
    ./r2rml-test_earl.sh $TESTCASE
done
