TESTS=test/clogin.bats
BIN=bin/clogin

test: $(BIN) $(TESTS) 
	./test/bats/bats test

install: test $(BIN)
	sudo cp -v bin/clogin /usr/local/bin
	sudo cp -v etc/clogin.conf /usr/local/etc
	hash -r

docker-build: Dockerfile
	docker build -t authq/captive-login .

docker: docker-build
	docker run -it --rm authq/captive-login test

.PHONY: test install docker-build docker
