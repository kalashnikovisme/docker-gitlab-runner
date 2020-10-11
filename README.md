A Docker image with:

* Ruby
* Chrome (latest)
* Chromedriver (latest)
* NodeJS

Built for testing ruby / cucumber / selenium.

## Versions

* ruby-2.5.6
* ruby-2.7.0
* ruby-2.7.1

## Usage

kalashnikovisme/ci-rails:#{your_ruby_version}

### Building own ruby version

```
docker build -t %{ruby-version} .
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
