#!/usr/bin/env bash
# vim:ts=4:sw=4:sts:noet

dir=$(dirname "$0")
cd "$dir"
mkdir -p bin
cd bin

find ../build -name '*cli*' | \
while read path; do
	name=$(basename "$path")
	name=${name%.js}
	name=${name#cli-}
	name=${name%-cli}
	echo "$name -> ${path#./}"
	cat > "$name" <<-END
		#!/usr/bin/env bash
		dir=\$(dirname "\$0")
		node "\$dir/${path#./}" "\$@"
	END
	chmod +x "$name"
done

