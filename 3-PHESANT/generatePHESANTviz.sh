

module add languages/java-jdk-1.8.0-66

dir="${PHESANT}/PHESANT-viz/"

resDir="${RES_DIR}/results-PHESANT-main-noCIs/"

cd ${dir}/bin/
java -cp .:../jar/json-simple-1.1\ 2.jar ResultsToJSON ${resDir}results-combined.txt "../node-positions.csv" "${resDir}java-json.json"
