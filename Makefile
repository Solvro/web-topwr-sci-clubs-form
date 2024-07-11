WEB_RENDERER=canvaskit
TAR_FILE=./deploy.tar
BUILD_DIR=./build/web
CAPTAIN_DEF=./captain-definition

captain-deploy:
	flutter build web --web-renderer $(WEB_RENDERER)
	tar -cvf $(TAR_FILE) $(CAPTAIN_DEF) $(BUILD_DIR)/*
	caprover deploy -t $(TAR_FILE) --default
	rm -f $(TAR_FILE)
	rm -rf $(BUILD_DIR)

fvm-captain-deploy:
	fvm flutter build web --web-renderer $(WEB_RENDERER)
	tar -cvf $(TAR_FILE) $(CAPTAIN_DEF) $(BUILD_DIR)/*
	caprover deploy -t $(TAR_FILE) --default
	rm -f $(TAR_FILE)
	rm -rf $(BUILD_DIR)
