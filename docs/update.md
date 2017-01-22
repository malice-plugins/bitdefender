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
