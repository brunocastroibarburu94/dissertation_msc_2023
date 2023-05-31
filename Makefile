pip-compile:
	pip-compile --resolver=backtracking --verbose --output-file=./python/requirements.txt ./python/requirements.in
	pip-sync ./python/requirements.txt

dev-compile:
	pip-compile --resolver=backtracking --verbose --output-file=requirements_dev.txt requirements_dev.in
	pip-sync requirements_dev.txt

dev-sync:
	pip-sync requirements_dev.txt

pip-sync:
	pip-sync requirements.txt

J:
	julia --project=./julia

jupyterlab:
	jupyter lab  --port=8080 --no-browser --ip=0.0.0.0 --allow-root

Jsync:
	cp -fr /root/project/julia/Project.toml  /root/.julia/environments/v1.8/Project.toml 
	cp -fr /root/project/julia/Manifest.toml  /root/.julia/environments/v1.8/Manifest.toml 