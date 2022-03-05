include properties.mk
appName = `grep entry manifest.xml | sed 's/.*entry="\([^"]*\).*/\1/'`
devices = `grep 'iq:product id' manifest.xml | sed 's/.*iq:product id="\([^"]*\).*/\1/'`
JAVA_OPTIONS = JDK_JAVA_OPTIONS="--add-modules=java.xml.bind"
build:
	$(SDK_HOME)/bin/monkeyc \
	--jungles ./monkey.jungle \
	--device $(DEVICE) \
	--output $(BINDIR)/$(appName).prg \
	--private-key $(PRIVATE_KEY) \
	--warn

buildall:
	echo build $(BINDIR)/$(appName)
	@for device in $(devices); do \
		echo "-----"; \
		echo "Building for" $$device; \
    $(SDK_HOME)/bin/monkeyc \
		--jungles ./monkey.jungle \
		--device $$device \
		--output $(BINDIR)/$(appName)-$$device.prg \
		--private-key $(PRIVATE_KEY) \
		--warn; \
	done


xxx:
		echo "Building for" XX; \
    $(SDK_HOME)/bin/monkeyc --jungles ./monkey.jungle --device legacyherocaptainmarvel --output $(BINDIR)/$(appName)-xxx.prg --private-key $(PRIVATE_KEY) \
		--warn; \
	done

run: build
	@$(SDK_HOME)/bin/connectiq &&\
	sleep 3 &&\
	$(JAVA_OPTIONS) \
	$(SDK_HOME)/bin/monkeydo $(BINDIR)/$(appName).prg $(DEVICE)

deploy: build
	@cp $(BINDIR)/$(appName).prg $(DEPLOY)

package:
	@$(SDK_HOME)/bin/monkeyc \
	--jungles ./monkey.jungle \
	--package-app \
	--release \
	--output $(BINDIR)/$(appName).iq \
	--private-key $(PRIVATE_KEY) \
	--warn
