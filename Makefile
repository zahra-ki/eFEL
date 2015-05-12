all: install	
install:
	pip install . --upgrade
doc: install
	sphinx-apidoc -f -o docs/source efel
	cd docs; $(MAKE) clean; $(MAKE) html
doc_upload: doc
	cd docs/build/html && \
	touch .nojekyll && \
	git init . && \
	git add . && \
	git commit -m "Updating docs" && \
	git push "git@github.com:BlueBrain/eFEL.git" master:gh-pages --force && \
	rm -rf .git
test: install
	cd efel/tests; nosetests -s -v -x
clean:
	rm -rf build
	rm -rf docs/build
