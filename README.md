# bitdefender

[![Circle CI](https://circleci.com/gh/malice-plugins/bitdefender.png?style=shield)](https://circleci.com/gh/malice-plugins/bitdefender)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)
[![Docker Stars](https://img.shields.io/docker/stars/malice/bitdefender.svg)](https://hub.docker.com/r/malice/bitdefender/)
[![Docker Pulls](https://img.shields.io/docker/pulls/malice/bitdefender.svg)](https://hub.docker.com/r/malice/bitdefender/)
[![Docker Image](https://img.shields.io/badge/docker%20image-508MB-blue.svg)](https://hub.docker.com/r/malice/bitdefender/)

This repository contains a **Dockerfile** of [Bitdefender](http://www.bitdefender.com/business/antivirus-for-unices.html) for [Docker](https://www.docker.io/)'s [trusted build](https://hub.docker.com/r/malice/bitdefender/) published to the public [DockerHub](https://hub.docker.com).

### Dependencies

- [debian:jessie (_123 MB_\)](https://hub.docker.com/_/debian/)

### Installation

1.  Install [Docker](https://www.docker.io/).
2.  Download [trusted build](https://hub.docker.com/r/malice/bitdefender/) from public [DockerHub](https://hub.docker.com): `docker pull malice/bitdefender`

### Usage

```
docker run --rm malice/bitdefender EICAR
```

#### Or link your own malware folder:

```bash
$ docker run --rm -v /path/to/malware:/malware:ro malice/bitdefender FILE

Usage: bitdefender [OPTIONS] COMMAND [arg...]

Malice Bitdefender AntiVirus Plugin

Version: v0.1.0, BuildTime: 20170122

Author:
  blacktop - <https://github.com/blacktop>

Options:
  --verbose, -V         verbose output
  --table, -t	        output as Markdown table
  --callback, -c	    POST results to Malice webhook [$MALICE_ENDPOINT]
  --proxy, -x	        proxy settings for Malice webhook endpoint [$MALICE_PROXY]
  --timeout value       malice plugin timeout (in seconds) (default: 60) [$MALICE_TIMEOUT]
  --elasitcsearch value elasitcsearch address for Malice to store results [$MALICE_ELASTICSEARCH]
  --help, -h	        show help
  --version, -v	        print the version

Commands:
  update	Update virus definitions
  web       Create a bitdefender scan web service
  help		Shows a list of commands or help for one command

Run 'bitdefender COMMAND --help' for more information on a command.
```

This will output to stdout and POST to malice results API webhook endpoint.

## Sample Output

### [JSON](https://github.com/malice-plugins/clamav/blob/master/docs/results.json)

```json
{
  "bitdefender": {
    "infected": true,
    "result": "EICAR-Test-File (not a virus)",
    "engine": "7.90123",
    "updated": "20170122"
  }
}
```

### [Markdown](https://github.com/malice-plugins/clamav/blob/master/docs/SAMPLE.md)

---

#### Bitdefender

| Infected | Result                        | Engine  | Updated  |
| -------- | ----------------------------- | ------- | -------- |
| true     | EICAR-Test-File (not a virus) | 7.90123 | 20170122 |

---

## Documentation

- [To write results to ElasticSearch](https://github.com/malice-plugins/bitdefender/blob/master/docs/elasticsearch.md)
- [To create a Bitdefender scan micro-service](https://github.com/malice-plugins/bitdefender/blob/master/docs/web.md)
- [To post results to a webhook](https://github.com/malice-plugins/bitdefender/blob/master/docs/callback.md)
- [To update the AV definitions](https://github.com/malice-plugins/bitdefender/blob/master/docs/update.md)

## Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/malice-plugins/bitdefender/issues/new).

## CHANGELOG

See [`CHANGELOG.md`](https://github.com/malice-plugins/bitdefender/blob/master/CHANGELOG.md)

## Contributing

[See all contributors on GitHub](https://github.com/malice-plugins/bitdefender/graphs/contributors).

Please update the [CHANGELOG.md](https://github.com/malice-plugins/bitdefender/blob/master/CHANGELOG.md) and submit a [Pull Request on GitHub](https://help.github.com/articles/using-pull-requests/).

## License

MIT Copyright (c) 2016 **blacktop**
