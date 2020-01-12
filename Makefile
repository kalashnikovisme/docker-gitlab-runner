deploy:
	docker build . -t $$(cat .ruby-version)
	docker tag $$( cat .ruby-version ) kalashnikovisme/ci-rails
	docker push kalashnikovisme/ci-rails
