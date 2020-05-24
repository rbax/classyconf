test:
	python setup.py pytest

lint:
	flake8 classyconf tests

clean:
	-find . -iname "*.py[ocd]" -delete
	-find . -iname "__pycache__" -exec rm -rf {} \;
	-rm -rf dist

release: clean lint test
	git tag `python setup.py -q version`
	git push origin `python setup.py -q version`
	rm -rf dist/*
	python setup.py sdist
	twine check dist/*
	twine upload dist/*