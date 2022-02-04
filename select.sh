#!/bin/bash


# Monitoring the list of command-line arguments
if [[ ${@} =~ ^(-h|--help)$ ]]
then
    echo "Usage: select.sh [COMMAND]... [PROJECT]..."
    echo "A simple way to manage different versions of the environment."
    echo
    echo "Mandatory arguments to long options are mandatory for short options too."
    echo "    -с, --command    setting the command (only “create”, “update”, “delete”,"
    echo "                     “attach”, and “detach” are allowed)"
    echo "    -p, --project    the name of the project folder in the current directory"
    echo "        --create     equivalent to “--command create”"
    echo "        --update     equivalent to “--command update”"
    echo "        --delete     equivalent to “--command delete”"
    echo "        --attach     equivalent to “--command attach”"
    echo "        --detach     equivalent to “--command detach”"
    echo "    -h, --help       display this help and exit"
    echo
    echo "Exit status:"
    echo "    0    if OK,"
    echo "    1    if problems (e.g., the project does not exist)."
    echo
    echo "Examples:"
    echo "./select.sh create new_project"

    exit 0
else
    work=""
    name=""
    meta=${#}
    data=(${@})
    step=0

    while [[ $step -lt $meta ]]
    do
        size=1
        mark=0

        # Command
        if [[ "${data[$step]}" =~ ^(-c|--command).* ]]
        then
            if [[ -z "$work" ]]
            then
                if [[ "${data[$step]}" =~ .*[:=].* ]]
                then
                    work="${data[$step]##*[:=]}"
                else
                    work="${data[$[$step + 1]]}"
                    size=2
                fi
            fi
            mark=$[$mark + 1]
        fi
        if [[ "${data[$step]}" =~ ^(--)?(create|update|delete|attach|detach)$ ]]
        then
            if [[ -z "$work" ]]
            then
                work="${data[$step]##--}"
            fi
            mark=$[$mark + 1]
        fi

        # Project
        if [[ "${data[$step]}" =~ ^(-p|--project).* ]]
        then
            if [[ -z "$name" ]]
            then
                if [[ "${data[$step]}" =~ .*[:=].* ]]
                then
                    name="${data[$step]##*[:=]}"
                else
                    name="${data[$[$step + 1]]}"
                    size=2
                fi
                mark=$[$mark + 1]
            fi
        fi

        # Position encoding
        if [[ 0 -eq $mark ]]
        then
            if [[ "${@}" =~ ^(create|update|delete|attach|detach)( )([a-zA-Z0-9][a-zA-Z0-9_\-]*)$ ]]
            then
                work="${1}"
                name="${2}"
                break
            else
                echo "Invalid list of command-line arguments." >&2

                exit 1
            fi
        fi

        step=$[$step + $size]
    done

    if [[ -z "$work" ]]
    then
        PS3="Select the operation: "
        select work in "create" "update" "delete" "attach" "detach"
        do
            if [[ "$work" =~ ^(create|update|delete|attach|detach)$ ]]
                then
                    echo "Selected “command” $work ($REPLY)."
                    break
            else
                echo "Invalid input ($REPLY)." >&2
            fi
        done
    fi

    while [[ -z "$name" ]]
    do
        echo -n "Enter the project name: "
        read name
        if [[ "$name" =~ ^([a-zA-Z0-9][a-zA-Z0-9_\-]*)$ ]]
        then
            break
        else
            echo "Invalid input ($name)." >&2
            name=""
        fi
    done
fi


# Definition of operations

# Create
function create {
    if [[ "${1}" =~ ^([a-zA-Z0-9][a-zA-Z0-9_\-]*)$ ]]
    then
        local name="${1}"

        if [[ -d "./$name" ]]
        then
            echo "The “$name” project already exists."
        else
            mkdir "./$name"
            cd "./$name"
            if [[ -f "../__create.sh" ]]
            then
                source "../__create.sh"
            fi
            cd ".."
            echo "The “$name” project has been created."
        fi

        return 0
    else
        echo "Invalid “create” function argument ($name)." >&2

        return 1
    fi
}

# Update
function update {
    if [[ "${1}" =~ ^([a-zA-Z0-9][a-zA-Z0-9_\-]*)$ ]]
    then
        local name="${1}"

        if [[ -d "./$name" ]]
        then
            cd "./$name"
            if [[ -f "../__update.sh" ]]
            then
                source "../__update.sh"
            fi
            cd ".."
            echo "The “$name” project has been updated."
        else
            echo "The “$name” project does not exist."
        fi

        return 0
    else
        echo "Invalid “create” function argument ($name)." >&2

        return 1
    fi
}

# Delete
function delete {
    if [[ "${1}" =~ ^([a-zA-Z0-9][a-zA-Z0-9_\-]*)$ ]]
    then
        local name="${1}"

        if [[ -d "./$name" ]]
        then
            cd "./$name"
            if [[ -f "../__delete.sh" ]]
            then
                source "../__delete.sh"
            fi
            cd ".."
            rm -rf "./$name"
            echo "The “$name” project has been deleted."
        else
            echo "The “$name” project does not exist."
        fi

        return 0
    else
        echo "Invalid “create” function argument ($name)." >&2

        return 1
    fi
}

# Attach
function attach {
    if [[ "${1}" =~ ^([a-zA-Z0-9][a-zA-Z0-9_\-]*)$ ]]
    then
        local name="${1}"

        if [[ -d "./$name" ]]
        then
            cd "./$name"
            if [[ -f "../__attach.sh" ]]
            then
                source "../__attach.sh"
            fi
            cd ".."
            echo "The “$name” project has been attached."
        else
            echo "The “$name” project does not exist."
        fi

        return 0
    else
        echo "Invalid “create” function argument ($name)." >&2

        return 1
    fi
}

# Detach
function detach {
    if [[ "${1}" =~ ^([a-zA-Z0-9][a-zA-Z0-9_\-]*)$ ]]
    then
        local name="${1}"

        if [[ -d "./$name" ]]
        then
            echo "The “$name” project has been detached."
        else
            echo "The “$name” project does not exist."
        fi

        return 0
    else
        echo "Invalid “create” function argument ($name)." >&2

        return 1
    fi
}


# Main
if [[ "$work" == "create" ]]
then
    create $name
fi

if [[ "$work" == "update" ]]
then
    update $name
fi

if [[ "$work" == "delete" ]]
then
    delete $name
fi

if [[ "$work" == "attach" ]]
then
    attach $name
fi

if [[ "$work" == "detach" ]]
then
    detach $name
fi

exit ${?}
