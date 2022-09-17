# Copyright 2022 Yurii Ivanov <yivanov00@gmail.com>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Unified All-in-one Monero miner"
HOMEPAGE="https://github.com/fireice-uk/xmr-stak"
SRC_URI=""

EGIT_REPO_URI="https://github.com/fireice-uk/xmr-stak.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda +hwloc +httpd opencl ssl"

PATCHES=( "${FILESDIR}/disable_donate.patch" )

RDEPEND="
	cuda? ( >=dev-util/nvidia-cuda-sdk-8 )
	hwloc? ( sys-apps/hwloc )
	httpd? ( net-libs/libmicrohttpd )
	opencl? ( >=virtual/opencl-0 )
	ssl? ( dev-libs/openssl )
"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCPU_ENABLE=ON
		-DCUDA_ENABLE=$(usex cuda)
		-DHWLOC_ENABLE=$(usex hwloc)
		-DMICROHTTPD_ENABLE=$(usex httpd)
		-DOpenCL_ENABLE=$(usex opencl)
		-DOpenSSL_ENABLE=$(usex ssl)
	)

	cmake_src_configure
}

src_install() {
	dobin ${BUILD_DIR}/bin/xmr-stak
	if use cuda; then
		dolib ${BUILD_DIR}/bin/libxmrstak_cuda_backend.so
	fi
	if use opencl; then
		dolib ${BUILD_DIR}/bin/libxmrstak_opencl_backend.so
	fi
}
