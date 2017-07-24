#!/bin/bash
`useradd -u 1000 jenkins`
`usermod -aG docker jenkins`
`docker exec jenkins groupmod -g 497 docker`
`docker exec  jenkins -aG docker jenkins`


