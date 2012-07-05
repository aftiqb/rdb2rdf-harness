TESTDIR=`find rdb2rdf-tests -name "$1-*" | sed "s/^.*\/\(D.*\)/\1/"`
if [ "$TESTDIR" == "" ]
then
    echo "No test case '$1' found!"
    exit 1
fi
EXPECTED=output/dm-$1-expected.nt
ACTUAL=rdb2rdf-tests/$TESTDIR/directGraph-d2rq.ttl
rdfcopy rdb2rdf-tests/$TESTDIR/directGraph.ttl TURTLE N-TRIPLE | sort > $EXPECTED
./run-dm.sh rdb2rdf-tests/$TESTDIR/create.sql $ACTUAL
