# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/odeskteam/odeskteam-3.2.13.ebuild,v 1.2 2013/03/02 19:36:16 hwoarang Exp $

EAPI=4

inherit rpm

# Binary only distribution
QA_PREBUILT="*"

DESCRIPTION="Project collaboration and tracking software for oDesk.com"
HOMEPAGE="https://www.odesk.com/"
SRC_URI="amd64? ( https://www.odesk.com/downloads/linux/beta/${P}-1fc17.x86_64.rpm )
		 x86? ( https://www.odesk.com/downloads/linux/beta/${P}-1fc17.i386.rpm )
"

LICENSE="ODESK"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}

RDEPEND=">=dev-libs/glib-2
		 =media-video/ffmpeg-0.10.6
		 media-libs/alsa-lib
		 media-libs/fontconfig
		 media-libs/freetype
		 media-libs/libpng
		 media-libs/openjpeg
		 app-arch/bzip2
		 dev-libs/expat
		 dev-libs/libxml2
		 dev-libs/openssl:0
		 dev-libs/icu
		 sys-apps/util-linux
		 sys-apps/dbus
		 sys-libs/zlib
		 virtual/libffi
		 x11-libs/libX11
		 x11-libs/libXScrnSaver
		 x11-libs/libXau
		 x11-libs/libXdmcp
		 x11-libs/libXext
		 x11-libs/libxcb
		 x11-libs/libICE
		 x11-libs/libSM
		 x11-libs/libXcursor
		 x11-libs/libXfixes
		 x11-libs/libXi
		 x11-libs/libXrandr
		 x11-libs/libXrender
		 dev-qt/qtcore:4[ssl]
		 dev-qt/qtgui:4
"

src_prepare() {
	epatch "${FILESDIR}/${P}_desktop_file.patch"
}

src_install() {
	into /opt
	dobin usr/bin/odeskteam-qt4

	domenu usr/share/applications/odeskteam.desktop

	doicon usr/share/pixmaps/odeskteam.png
}
