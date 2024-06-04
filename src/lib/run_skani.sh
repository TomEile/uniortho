run_skani(){
    dout=$1
    skani triangle --full-matrix $dout/fnas/* > $dout/ani
}
