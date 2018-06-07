A Docker image with:

* Ubuntu 16.04
* Chrome
* Chromedriver
* Xvfb
* Rvm
* Npm
* Python

Built for testing ruby / cucumber / selenium and node server apps.

### Building
```
docker build -t rb-%{ruby-version} .
```

### Deploying to docker hub

```
docker tag %{ruby_version} kalashnikovisme/ci-rails
docker push kalashnikovisme/ci-rails
```


### Pulling from docker  - [https://hub.docker.com/r/kalashnikovisme/ci-rails](https://hub.docker.com/r/kalashnikovisme/ci-rails)
```
docker run -t -i kalashnikovisme/ci-rails
```
