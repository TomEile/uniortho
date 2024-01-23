check_requirement(){

    cmd=$1
    if ! command -v $cmd &> /dev/null
    then
        echo "$(magenta $cmd) could not be found. Please install $cmd and add it to your PATH"
        exit
    fi
}

check_requirements(){

    check_requirement "scarap"
    check_requirement "skani"
    check_requirement "Rscript"

}