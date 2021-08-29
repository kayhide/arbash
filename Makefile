test:
	false; while [[ $$? != 0 ]]; do find src -type f | entr -cdr test/test_arbash.sh; done
.PHONY: test
	
install:
	nix-env -f ./. -i arbash
.PHONY: install
