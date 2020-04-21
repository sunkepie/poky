SUMMARY = "An asynchronous event notification library"
HOMEPAGE = "http://libevent.org/"
BUGTRACKER = "http://sourceforge.net/tracker/?group_id=50884&atid=461322"
SECTION = "libs"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE;md5=17f20574c0b154d12236d5fbe964f549"

PR = "r1"
SRCREV = "${AUTOREV}"

SRC_URI = "git://github.com/sunkepie/libevent.git;branch=master;"

S = "${WORKDIR}/git"

EXTRA_OECONF = "--disable-openssl"

inherit autotools

# Needed for Debian packaging
LEAD_SONAME = "libevent-2.0.so"
