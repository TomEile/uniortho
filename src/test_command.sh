blast_check=${args[--blast]}
if [[ $blast_check == 1 ]]; then
    uniortho run "s__Sumerlaea chitinivorans" -C 10 -o test_out --blast
else
    uniortho run "s__Sumerlaea chitinivorans" -C 10 -o test_out
fi
