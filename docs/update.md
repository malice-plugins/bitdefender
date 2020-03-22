# To update the AV run the following:

```bash
$ docker run --name=bitdefender malice/bitdefender update
```

## Then to use the updated bitdefender container:

```bash
$ docker commit bitdefender malice/bitdefender:updated
$ docker rm bitdefender # clean up updated container
$ docker run --rm malice/bitdefender:updated EICAR
```

## To get a 🆕 license key

Get from <https://www.bitdefender.com/site/Products/ScannerLicense/>

> **NOTE:** Download the new version [here](http://download.bitdefender.com/SMB/Workstation_Security_and_Management/BitDefender_Antivirus_Scanner_for_Unices/Unix/Current/EN/FreeBSD/Bitdefender-Antivirus-Scanner-for-Unices-8.0.0.freebsd.amd64.run)
