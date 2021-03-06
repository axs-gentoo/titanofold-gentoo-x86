# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/isync/isync-1.1.2.ebuild,v 1.1 2015/01/26 23:50:05 radhermit Exp $

EAPI=5

DESCRIPTION="MailDir mailbox synchronizer"
HOMEPAGE="http://isync.sourceforge.net/"
SRC_URI="mirror://sourceforge/isync/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="compat sasl ssl zlib"

DEPEND=">=sys-libs/db-4.2
	sasl? ( dev-libs/cyrus-sasl )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		$(use_enable compat) \
		$(use_with sasl) \
		$(use_with ssl)
}
