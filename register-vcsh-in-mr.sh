#!/usr/bin/env bash
template='[$HOME/.config/vcsh/repo.d/$NAME.git]\ncheckout = vcsh clone ${URL} ${NAME}
'
cd
for r in $(vcsh list); do 
	export NAME="$r"
	export URL=$(vcsh "$r" remote -v | grep fetch | cut  -f2  | cut -d ' ' -f1)
	echo -e ${template} | envsubst '$NAME $URL'
done
