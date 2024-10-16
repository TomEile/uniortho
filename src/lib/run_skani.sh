run_skani(){
    dout=$1
    skani triangle --full-matrix $dout/fnas/* > $dout/ani
    rm skani_matrix_af
}
