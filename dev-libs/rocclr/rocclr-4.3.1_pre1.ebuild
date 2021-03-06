# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MY_PV="${PV%"_pre1"}"

DESCRIPTION="Radeon Open Compute Common Language Runtime"
HOMEPAGE="https://github.com/ROCm-Developer-Tools/ROCclr"
#SRC_URI="https://github.com/ROCm-Developer-Tools/ROCclr/archive/rocm-${PV}.tar.gz -> ${P}.tar.gz
#	https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime/archive/rocm-${PV}.tar.gz -> rocm-opencl-runtime-${PV}.tar.gz"
SRC_URI="https://github.com/ROCm-Developer-Tools/ROCclr/archive/refs/tags/rocm-${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz
	https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime/archive/refs/tags/rocm-4.3.1.tar.gz -> rocm-opencl-runtime-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"

RDEPEND="dev-libs/rocm-comgr:${SLOT}
	dev-libs/rocr-runtime:${SLOT}"
DEPEND="${RDEPEND}
	virtual/opengl
	dev-util/rocm-cmake:${SLOT}"

PATCHES=(
	"${FILESDIR}/rocclr-3.7.0-cmake-install-destination.patch"
)

S="${WORKDIR}/ROCclr-rocm-${MY_PV}"

src_configure() {
	local mycmakeargs=(
		-DUSE_COMGR_LIBRARY=YES
		-DOPENCL_DIR="${WORKDIR}/ROCm-OpenCL-Runtime-rocm-${MY_PV}"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
	)
	cmake_src_configure
}
