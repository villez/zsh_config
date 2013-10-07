if [[ $(uname) = 'Linux' ]]; then
    PLATFORM_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
    PLATFORM_OSX=1
fi
