This script helps configure passwordless SSH between two machines.

# SCOPE
The script itself is nothing more than putting in line the few commands needed to set up this rather simple, if annoying, procedure and should keep
you focusing on the important stuff rather than remembering syntax details.

# USAGE
You must place this script on the client machine and run it. You can provide two arguments on the command line, the first one is the hostname that will
accept passwordless login and the second one is the username on that machine.

If the second argument is ommited, the username will default to the username on the client machine and if both arguments are omitted, they will be asked interactively.
