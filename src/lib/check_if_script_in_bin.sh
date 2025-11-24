script_in_bin(){

command=$1

if [[ ! -s $HOME/.local/bin/$command ]]; then
        echo "$(red $command not found in $HOME/.local/bin.)"
        echo "$(red add the script to your path, for example with)"
        echo "$(magenta ln -s $PWD/src/lib/$command $HOME/.local/bin)"
        exit 1
fi
}
