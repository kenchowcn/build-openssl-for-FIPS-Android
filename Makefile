#
all: openssl-1.0.2h/.built setenv

openssl-fips-2.0.12.tar.gz:
	#wget http://www.openssl.org/source/openssl-fips-2.0.12.tar.gz
	wget http://45.78.29.98/openssl-fips-2.0.12.tar.gz

openssl-1.0.2h.tar.gz:
	#wget http://www.openssl.org/source/openssl-1.0.2h.tar.gz
	wget http://45.78.29.98/openssl-1.0.2h.tar.gz

ssl/:
	mkdir -p ssl/$$ANDROID_API

setenv:
	env OPENSSL_FIPS=1

openssl-fips-2.0.12/.built: openssl-fips-2.0.12.tar.gz ssl/ setenv
	gunzip -c openssl-fips-2.0.12.tar.gz | tar xf -
	cd openssl-fips-2.0.12 && \
	export FIPSDIR=$$PWD/../ssl/$$ANDROID_API && \
	./config && \
	make && \
	make install && \
	touch .built

openssl-1.0.2h/.built: openssl-fips-2.0.12/.built openssl-1.0.2h.tar.gz
	gunzip  -c openssl-1.0.2h.tar.gz | tar xf -
	cd openssl-1.0.2h && \
	./config fips shared -no-sslv2 -no-sslv3 -no-comp -no-hw -no-engines \
	--openssldir=$$PWD/../ssl/$$ANDROID_API \
	--with-fipsdir=$$PWD/../ssl/$$ANDROID_API \
	--with-fipslibdir=$$PWD/../ssl/$$ANDROID_API/lib/ && \
	make depend && \
	make && \
	make install_sw CC=$$ANDROID_TOOLCHAIN/arm-linux-androideabi-gcc \
	                AR=$$ANDROID_TOOLCHAIN/arm-linux-androideabi-ar \
					RANLIB=$$ANDROID_TOOLCHAIN/arm-linux-androideabi-ranlib &&\
	touch .built

clean:
	rm -rf openssl-fips-2.0.12 openssl-1.0.2h ssl
