# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Guix Home Setup
export GUIX_PROFILE=$HOME/.guix-home/profile
if [ -f $GUIX_PROFILE/etc/profile ]; then
    . $GUIX_PROFILE/etc/profile
fi

# User specific environment and startup programs
