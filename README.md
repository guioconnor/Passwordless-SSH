This script helps configure passwordless SSH between two machines.

# SCOPE
The script itself is nothing more than putting in line the few commands needed to set up this rather simple, if annoying, procedure and should keep
you focusing on the important stuff rather than remembering syntax details.

# USAGE
You must place this script on the client machine and run it. You can provide two arguments on the command line, the first one is the hostname that will
accept passwordless login and the second one is the username on that machine.

If the second argument is ommited, the username will default to the username on the client machine and if both arguments are omitted, they will be asked interactively.

# DOCKER
There is a containerized version at
https://hub.docker.com/r/guioconnor/set_passwordless_ssh/

You can use this version without having to clone or download this repo. Simply use

```
docker run -it -e "COMMENT=$USER@$HOSTNAME" -v ~/.ssh:/root/.ssh guioconnor/set_passwordless_ssh
```

This will
* Run the script inside a container
* Save the keys on your `~/.ssh folder`. You can customise this path.
* Use `$USER@$HOSTNAME on your computer as the key comment. You can customise this comment.
