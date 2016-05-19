LIB_OBJ=libcrypto_module.so
LIB_SRC=crypto_module.c

# openssl
OPENSSL_ANDROID = /home/ken/Desktop/new/ssl/android-21/
INCLUDES=-I$(OPENSSL_ANDROID)/include/

INCLUDES+=-I$(ANDROID_SYSROOT)/usr/include/

STATIC_LIBS=$(OPENSSL_ANDROID)/lib/libcrypto.a
STATIC_LIBS+=$(OPENSSL_ANDROID)/lib/libssl.a

DYN_LIBS=-ldl

CFLAGS=-Wall -g

export CC=$(OPENSSL_ANDROID)/bin/fipsld
export FIPSLD_CC=$(ANDROID_TOOLCHAIN)/$(CROSS_COMPILE)gcc

all: $(LIB_OBJ)

$(LIB_OBJ): $(LIB_SRC)
	$(CC) $(LIB_SRC) -fPIC -shared -o $(LIB_OBJ) --sysroot=$(ANDROID_SYSROOT) $(INCLUDES) -Wl,-Bstatic $(STATIC_LIBS) -Wl,-Bdynamic $(DYN_LIBS)

clean:
	rm -rf $(BIN) $(LIB_OBJ) *.o
