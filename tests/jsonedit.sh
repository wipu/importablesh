import jsonedit
import runtest
import init-testarea

init-testarea
FILE=$TESTAREA/file.json

test-start "text field"

echo '{"a":"av","b":"bv"}' > "$FILE"

json-setfield "$FILE" '["b"]' '"bv2"'

diff "$FILE" <(cat <<EOF
{
    "a": "av",
    "b": "bv2"
}
EOF
	      )

test-start "int field"

echo '{"i":1,"b":"bv"}' > "$FILE"

json-setfield "$FILE" '["i"]' '2'

diff "$FILE" <(cat <<EOF
{
    "b": "bv",
    "i": 2
}
EOF
	      )

test-start "child object field"

echo '{"a":"av","o":{"of":"ofv"}}' > "$FILE"

json-setfield "$FILE" '["o"]["of"]' '"ofv2"'

diff "$FILE" <(cat <<EOF
{
    "a": "av",
    "o": {
        "of": "ofv2"
    }
}
EOF
	      )

