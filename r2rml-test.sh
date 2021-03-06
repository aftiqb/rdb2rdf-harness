TESTDIR=`find rdb2rdf-tests -name "$1-*" | sed "s/^.*\/\(D.*\)/\1/"`
if [ "$TESTDIR" == "" ]
then
    echo "No test case '$1' found!"
    exit 1
fi
echo \#\#\# ./r2rml-test.sh $1 \#\#\#
for TESTCASE in `sparql --query query-r2rml-testcases.sparql --data rdb2rdf-tests/$TESTDIR/manifest.ttl --results CSV | tail +2`
do
    IDENTIFIER=`echo $TESTCASE | cut -d , -f 1 | sed -E "s/\"(.*)\"/\1/"`
    MAPPING=`echo $TESTCASE | cut -d , -f 2 | sed -E "s/\"(.*)\"/\1/"`
    RESULT=`echo $TESTCASE | cut -d , -f 3 | sed -E "s/\"(.*)\"/\1/"`
    echo === $1 $IDENTIFIER ===
    EXPECTED=output/r2rml-$1-$IDENTIFIER-expected.nt
    ACTUAL=output/r2rml-$1-$IDENTIFIER-result.nt
    rdfcopy rdb2rdf-tests/$TESTDIR/$RESULT TURTLE N-TRIPLE | sort > $EXPECTED
    ./run-r2rml.sh rdb2rdf-tests/$TESTDIR/create.sql rdb2rdf-tests/$TESTDIR/$MAPPING $ACTUAL
    if [ "$?" == "0" ]; then
        rdfcompare $ACTUAL $EXPECTED N-TRIPLE N-TRIPLE > /dev/null
        if [ "$?" == "0" ]; then
            echo PASS!
        else
            echo "FAIL! diff follows."
            sort $ACTUAL > $ACTUAL-sorted
            mv $ACTUAL-sorted $ACTUAL
            diff $EXPECTED $ACTUAL
        fi
    fi
done
