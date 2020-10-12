# VMware vmnet interfaces

after Update/Upgrade

## problem: vmnet interfaces disappeared, following to fix it 

neuinstallieren!!!!!

`sudo mount -o remount,exec /tmp `
`pacaur -S --noconfirm --needed  vmware-workstation`
`sudo modprobe vmnet && sudo vmware-networks --start`



```sudo modprobe vmnet && sudo vmware-networks --start```

```vmware-modconfig --console --install-all```

reboot

tags: #vmware #vmnet #admin #interface #christian 
