#!/bin/bash
#### nmap chain - with chunks
## env Setup
if [ "$#" -lt 1 ]; then echo -e "Usage:\n./nmap-scanning 192.168.56.0/24\n./nmap-scanning  <directory-to-previous-scan> [PORTCOUNT i.e. 65535]"; exit 1 ; fi
if [ ! $(id -u) -eq 0 ]; then echo "Root Plz !"; exit 1 ; fi


if [[ -z "${2}" ]];then
    PORTCOUNT=5000
else
    PORTCOUNT="${2}"
fi

color ()
{
C_RED="\033[1;31m"
C_RESET="\033[0m"
echo -e "${C_RED}${1}${C_RESET}"
}

scan ()
{
    nmap_cmd=${1}
for chunk in $(ls | grep "^${chunkname}"); do
    count=$(cat "${chunkname}"* | wc -l)
    color "SCAN: ${chunk} | remaining IPs: ${count}"
    eval `echo ${nmap_cmd}`
    grep -vxf ${chunk} ${SOURCE} > remove_scaned_foooobar.tmp
    mv remove_scaned_foooobar.tmp ${SOURCE}
    rm "${chunk}"
done
}

UDP=""
NEWSCAN=0
RANGE=""
DESTDIR=""

if [ -d "${1}" ];then
    DESTDIR="${1}"
    color "Will continue old Scan - in:  $DESTDIR"
    NEWSCAN=0
    if [ -e "${DESTDIR}/"udp.scan ];then
        UDP='y'
    fi
else
    NEWSCAN=1
    RANGE="${1}"
    TIME=$(date +"%Y-%m-%d_%H-%M-%S")
    DESTDIR=`echo "nmapScan_${RANGE}_${PORTCOUNT}xTCP__${TIME}" | sed -e 's/\//cidr/g'`
    color "New Scan - output in: $DESTDIR"
    mkdir -p "${DESTDIR}/scan"
    echo "${RANGE}" > "${DESTDIR}/"scan_range
    echo "Run udp scans? [y/N]"
    read UDP
    if [[ "${UDP}" =~ "y" ]]; then
        UDP='y'
        touch "${DESTDIR}/"udp.scan
        color "Will perform UDP Scans"
    fi
fi
cd "${DESTDIR}"

chunkname="00-DISCOVERY-chunk-"
SOURCE=all_possible_ips
SIZE=64
if [ ${NEWSCAN} -eq 1 ];then
    nmap -n -sL `cat scan_range` 2>&1 | grep "Nmap scan report" | awk '{print $NF}' | grep -v "\.0$\|\.255$"  > ${SOURCE}
    split -l ${SIZE} ${SOURCE} "${chunkname}"
else
    files=$(ls | grep "^${chunkname}")
    code1=$?
    if [ ${code1} -eq 1 ];then
        files=$(ls ./scan/ | grep "^${chunkname}")
        code2=$?
        if [ ${code2} -eq 1 ];then
            split -l ${SIZE} ${SOURCE} ${chunkname}
        else
            color "00-DISCOVERY Scan was compleated"
        fi
    else
        color "continue 00-DISCOVERY Scan ..."
    fi
fi

# NMAP GLOBAL VAR
nmap="nmap -n -v -v -d --max-retries 2 --min-rate 200"
# Hardcore Fast Discovery - Finds also Host with Zero Ports OPEN
scan '${nmap} -T4 -PS21-25,80,135,137,139,443,445,1433,3306,5432,8080 -PU53,111,137,161,162,500,1434 -iL "${chunk}" -oA "./scan/${chunk}" | tee -a "./scan/${chunk}.tee"'

## Filter up-hosts with at least 1 Open Port
SOURCE=targets-with-open-port
SIZE=4
oldchunkname=${chunkname}
chunkname="01-ALL-TCP-chunk-"
if [ ! -e ${SOURCE} ];then
    color "Generate ${SOURCE}"
    cat ./scan/${oldchunkname}*.gnmap | awk '/open/ {print $2}' | grep -vi nmap > ${SOURCE}
fi

## Find all open Ports on Discovered targets
if [ ${NEWSCAN} -eq 1 ];then
    split -l ${SIZE} ${SOURCE} "${chunkname}"
else
    files=$(ls | grep "^${chunkname}")
    code1=$?
    if [ ${code1} -eq 1 ];then
        files=$(ls ./scan/ | grep "^${chunkname}")
        code2=$?
        if [ ${code2} -eq 1 ];then
            split -l ${SIZE} ${SOURCE} ${chunkname}
        else
            color "01-ALL-TCP Scan was compleated"
        fi
    else
        color "continue 01-ALL-TCP ..."
    fi
fi

if [ ! -e "${SOURCE}.bak" ];then
    cp ${SOURCE} "${SOURCE}.bak"
fi

scan '${nmap} -T4 -Pn -iL "${chunk}" --top-ports ${PORTCOUNT} -oA "./scan/${chunk}" | tee -a "./scan/${chunk}.tee"'
cp "${SOURCE}.bak" ${SOURCE}

## Get all open uniq Ports
oldchunkname=${chunkname}
chunkname="02-ALL-TCP-VERSIONS-chunk-"
SOURCE=targets-with-open-port
SIZE=2
if [ ${NEWSCAN} -eq 1 ];then
    cat ./scan/${oldchunkname}*.nmap | grep "open" | grep -v "scan initiated" | cut -d"/" -f 1 | sort -un > targets-found-ports.lst
    cat targets-found-ports.lst | tr '\n' ',' > targets-found-ports.csv
    split -l ${SIZE} ${SOURCE} ${chunkname}
else
    files=$(ls | grep "^${chunkname}")
    code1=$?
    if [ ${code1} -eq 1 ];then
        files=$(ls ./scan/ | grep "^${chunkname}")
        code2=$?
        if [ ${code2} -eq 1 ];then
            cat ./scan/${oldchunkname}*.nmap | grep "open" | grep -v "scan initiated" | cut -d"/" -f 1 | sort -un > targets-found-ports.lst
            cat targets-found-ports.lst | tr '\n' ',' > targets-found-ports.csv
            split -l ${SIZE} ${SOURCE} ${chunkname}
        else
            color "02-ALL-TCP-VERSIONS Scan was compleated"
        fi
    else
        color "continue 02-ALL-TCP-VERSIONS ..."
    fi
fi

# More Efficient Version Scan on Known Ports only
PORTS=$(cat targets-found-ports.csv)
scan '${nmap} -T4 -Pn -iL "${chunk}" -p "${PORTS}" -sV --version-all -oA "./scan/${chunk}" | tee -a "./scan/${chunk}.tee"'
cp "${SOURCE}.bak" ${SOURCE}

## Proto + OS Guess
chunkname="03-OS_GUESS-chunk-"
SOURCE=targets-with-open-port
SIZE=2
if [ ${NEWSCAN} -eq 1 ];then
    split -l ${SIZE} ${SOURCE} ${chunkname}
else
    files=$(ls | grep "^${chunkname}")
    code1=$?
    if [ ${code1} -eq 1 ];then
        files=$(ls ./scan/ | grep "^${chunkname}")
        code2=$?
        if [ ${code2} -eq 1 ];then
            split -l ${SIZE} ${SOURCE} ${chunkname}
        else
            color "03-OS_GUESS Scan was compleated"
        fi
    else
        color "continue 03-OS_GUESS ..."
    fi
fi

scan '${nmap} -Pn -iL "${chunk}" -O --osscan-guess -oA "./scan/${chunk}" | tee -a "./scan/${chunk}.tee"'
cp "${SOURCE}.bak" ${SOURCE}

## QUICK + LARGE UDP
if [[ "${UDP}" =~ "y" ]]; then

    chunkname="04-TOP50-UDP-chunk-"
    SOURCE=targets-with-open-port
    SIZE=2
    if [ ${NEWSCAN} -eq 1 ];then
        split -l ${SIZE} ${SOURCE} ${chunkname}
    else
        files=$(ls | grep "^${chunkname}")
        code1=$?
        if [ ${code1} -eq 1 ];then
            files=$(ls ./scan/ | grep "^${chunkname}")
            code2=$?
            if [ ${code2} -eq 1 ];then
                split -l ${SIZE} ${SOURCE} ${chunkname}
            else
                color "03-OS_GUESS Scan was compleated"
            fi
        else
            color "continue 03-OS_GUESS ..."
        fi
    fi

    scan '${nmap} -T4 -Pn -iL "${chunk}" --top-ports 50 -sU -sV --version-all -oA "./scan/${chunk}" | tee -a "./scan/${chunk}.tee"'
    cp "${SOURCE}.bak" ${SOURCE}

fi
color "DONE" 
exit 0
