# dependency: scarap
run_pangenome() {
#input variables based on in and output
#variables change how many threads you want to use
din=$1/faas
dout=$1/pan
threads=$2
[ -d "$dout" ] || mkdir -p "$dout"
scarap pan $din $dout -t $threads -c 
}