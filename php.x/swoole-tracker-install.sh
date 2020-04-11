#!/bin/sh

DESTTAR='http://resources.swoole-cloud.com/getClient/trial/2.8.8'
MD5HASH='aea6d80e3e42565308bc8790da16c28a'
SHA1HASH='a0bac614a0f707b1913923536a35f0dd2ad53fbe'
FILESIZE='10454509'
MAGICSTRING='ODI2NA=='

tmpprefix=.
tmpdest=${tmpprefix}/swoole-tracker
tmpfile=${tmpdest}.tar.gz

fetchtar()
{
    if type wget 2>&1 >/dev/null
    then
        wget $DESTTAR -O ${tmpfile}
    elif type curl 2>&1 >/dev/null
    then
        curl $DESTTAR -o ${tmpfile}
    else
        printf "No supported downloader (wget or curl) found.\n"
        printf "Please install one of them, or manually download\n"
        printf "\n\t${DESTTAR}\n\n"
        printf "as ${tmpfile}"
        exit 22
    fi
}

checktar()
{
    if type stat 2>&1 >/dev/null
    then
        [ x`stat ${tmpfile} -c "%s"` = x$FILESIZE ] || return 1
    fi
    if type sha1sum 2>&1 >/dev/null
    then
        printf "${SHA1HASH}  ${tmpfile}\n" | sha1sum -c - && return 0 || return 1
    elif type md5sum 2>&1 >/dev/null
    then
        printf "${MD5HASH}  ${tmpfile}\n" | md5sum -c - && return 0 || return 1
    else
        printf "Neither sha1sum nor md5sum found,\n"
        printf "downloaded file cannot be verified.\n"
        return 0
    fi
}

extracttar()
{
    mkdir -p ${tmpdest}
    tar -xvf ${tmpfile} -C ${tmpdest}
}

if [ -f ${tmpfile} ]
then
    checktar || rm ${tmpfile}
fi
if [ ! -f ${tmpfile} ]
then
    fetchtar
    checktar ||
    {
        rm ${tmpfile}
        printf "Verification failed, please download again swoole-tracker-install.sh\n"
        exit 22
    }
fi

extracttar
cd ${tmpdest}
echo $MAGICSTRING > ./app_deps/node-agent/magicstring
exec ./deploy_env.sh

