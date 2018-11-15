dscl . -create /Users/codequickly
dscl . -create /Users/codequickly UserShell /bin/bash
dscl . -create /Users/codequickly RealName "Codequickly"
dscl . -create /Users/codequickly UniqueID "1000"
dscl . -create /Users/codequickly PrimaryGroupID 20
dscl . -create /Users/codequickly NFSHomeDirectory /Users/codequickly
dscl . -passwd /Users/codequickly Faster21
mkdir /Users/codequickly
dscl . -append /Groups/admin GroupMembership codequickly