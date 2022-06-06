build.%:
	@echo "##### $@ #####"
	cd docker/$*; docker image build -t ros2/$*:latest .

run.%:
	@echo "##### $@ #####"
	docker container run -it \
		-v $$HOME/workspace/ros2-docker:/workspace \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--name ros2_$*_$(shell date '+%s') --workdir /workspace \
		--privileged=true \
		-e TERM=xterm-256color \
		ros2/$*:latest

clean.%:
	@echo "##### $@ #####"
	@docker container prune -f
	@docker rmi $(shell docker images -f dangling=true -q) -f 2>/dev/null || true
	@docker image prune -f
	@docker rmi ros2/$*:latest -f
