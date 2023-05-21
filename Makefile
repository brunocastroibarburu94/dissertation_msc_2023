pip-compile:
	pip-compile --resolver=backtracking --verbose --output-file=requirements.txt requirements.in
	pip-sync requirements.txt

dev-compile:
	pip-compile --resolver=backtracking --verbose --output-file=requirements_dev.txt requirements_dev.in
	pip-sync requirements_dev.txt

dev-sync:
	pip-sync requirements_dev.txt

pip-sync:
	pip-sync requirements.txt

jul:
	julia --project=./julia

jupyterlab:
	jupyter lab  --port=8080 --no-browser --ip=0.0.0.0 --allow-root
