for file in ${1}/outputs/vcfs/*
do
gunzip $file
sed -i '' 's/SczhEnG_//g' ${1}/outputs/vcfs/*
