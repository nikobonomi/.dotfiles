alias ll="colorls -A"
alias ls="colorls"
alias lsa="colorls -lA --sd"
alias chrome="open -a \"Google Chrome\""

dos2mac() {
    tr -d '\015' < "$1" > "tmp.$1"
    mv "tmp.$1" "$1"
}

