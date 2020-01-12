A Docker image with:

* Ruby-2.7.0
* Chrome
* Chromedriver
* Npm

Built for testing ruby / cucumber / selenium.

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
