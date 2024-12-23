#!/bin/zsh

alias ask="python3 $ZSH/plugins/err-finder/script.py ask $3"
ERR_DEBUG=1

precmd() {
    if [ "$?" != 0 ] && [ "$preexec_called" = 1 ]; then
    # Getting command
        last_command=$(fc -ln -1)

        line=$(cat $temp_file | grep -n '___' | gawk '{print $1}' FS=":" | tail -n 1)
        line=$(expr $line + 1)
        err_lines=$(sed -n $line,\$p $temp_file)
        python3 $ZSH/plugins/err-finder/script.py $last_command $err_lines
    # 
        unset preexec_called;
    fi
}

ERR_FI=""
temp_file=$(mktemp /tmp/error_parcer.XXXXXX)
if [ -z "$SCRIPT_RUNNING" ]; then
    export SCRIPT_RUNNING=1
    exec > >(tee -a $temp_file) 2>&1
    ERR_FI=$temp_file
fi

preexec() {
    preexec_called=1
    echo "\n___" >> $temp_file
}



