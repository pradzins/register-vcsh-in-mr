#!/usr/bin/env bash
template='[$HOME/.config/vcsh/repo.d/$NAME.git]\ncheckout = vcsh clone ${URL} ${NAME}\n'

# todo: check envsubst availability
target_uber_dir=$HOME/.config/mr/available.d

if [[ ! -d ${target_uber_dir} ]]; then
	 echo "The direcory ${target_uber_dir} does not exist; about to create it..."
fi	 

cd
for r in $(vcsh list); do 
	export NAME="$r"
	target_file=${target_uber_dir}/${NAME}.vcsh
	if [[ -e ${target_file} ]]; then
		echo -e "The file $target_file already exists, skipping...\n"
		continue
	fi	
	export URL=$(vcsh "$r" remote -v | grep fetch | cut  -f2  | cut -d ' ' -f1)
	echo -e "Creating file $target_file\n"
	echo -e ${template} | envsubst '$NAME $URL' > ${target_file}
done
