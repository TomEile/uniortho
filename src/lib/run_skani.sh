run_skani(){
    dout=$1
    skani triangle --full-matrix $dout/fnas/* -o $dout/ani
}