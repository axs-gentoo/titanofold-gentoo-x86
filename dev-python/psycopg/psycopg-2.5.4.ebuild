# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-2.5.4.ebuild,v 1.3 2014/10/20 03:10:14 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1 flag-o-matic

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PostgreSQL database adapter for Python"
HOMEPAGE="http://initd.org/psycopg/ http://pypi.python.org/pypi/psycopg2"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="debug doc examples"

RDEPEND=">=dev-db/postgresql-8.1"
DEPEND="${RDEPEND}
	doc? (  dev-python/sphinx[${PYTHON_USEDEP}]
		>=dev-python/python-docs-2.7.6-r1:2.7 )"

RESTRICT="test"
# Remove py3.2 entry from intersphinx setting
PATCHES=( "${FILESDIR}/"${PN}-2.4.2-setup.py.patch )

S="${WORKDIR}/${MY_P}"

python_compile() {
	local CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS}

	! python_is_python3 && append-flags -fno-strict-aliasing

	distutils-r1_python_compile
}

python_prepare_all() {
	if use debug; then
		sed -i 's/^\(define=\)/\1PSYCOPG_DEBUG,/' setup.cfg || die
	fi

	# Source local copy of objects.inv
	if use doc; then
		local PYTHON_DOC_ATOM=$(best_version --host-root dev-python/python-docs:2.7)
		local PYTHON_DOC_VERSION="${PYTHON_DOC_ATOM#dev-python/python-docs-}"
		local PYTHON_DOC="/usr/share/doc/python-docs-${PYTHON_DOC_VERSION}/html"
		local PYTHON_DOC_INVENTORY="${PYTHON_DOC}/objects.inv"
		sed -e "s|'http://docs.python.org/', None|'${PYTHON_DOC}', '${PYTHON_DOC_INVENTORY}'|" \
			-e "/^    'py3':/d" -i doc/src/conf.py || die
		einfo "conf.py patched"
	fi

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C doc -j1 html text
}

python_install_all() {
	if use doc; then
		dodoc doc/psycopg2.txt
		dohtml -r doc/html/.
	fi

	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
