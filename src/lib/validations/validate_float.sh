## [@bashly-upgrade validations]
validate_float() {
  [[ "$1" =~ ^[0-9]+(\.[0-9]+)?$ ]] || echo "must be a float"
}