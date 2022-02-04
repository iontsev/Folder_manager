# Folder manager
## A simple bash script to deploy and manage the environment 

Usage:

    select.sh [COMMAND]... [PROJECT]...

A simple way to manage different versions of the environment. But true way is Docker.

    Mandatory arguments to long options are mandatory for short options too.
        -с, --command    setting the command (only “create”, “update”, “delete”,
                        “attach”, and “detach” are allowed)
        -p, --project    the name of the project folder in the current directory
            --create     equivalent to “--command create”
            --update     equivalent to “--command update”
            --delete     equivalent to “--command delete”
            --attach     equivalent to “--command attach”
            --detach     equivalent to “--command detach”
        -h, --help       display this help and exit

    Exit status:
        0    if OK,
        1    if problems (e.g., the project does not exist).

Examples:

    chmod ugo+x select.sh
    ./select.sh create new_project
    ./select.sh attach new_project


## The example
Example usage for environment management in JupiterLab.

+ __\_\_create.sh__ — the “create” command extension.
+ __\_\_update.sh__ — the “update” command extension.
+ __\_\_delete.sh__ — the “delete” command extension.
+ __\_\_attach.sh__ — the “attach” command extension.
+ __\_\_detach.sh__ — the “detach” command extension.
