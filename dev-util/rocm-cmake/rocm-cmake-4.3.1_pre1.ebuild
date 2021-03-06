# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV%"_pre1"}"

inherit cmake

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/RadeonOpenCompute/rocm-cmake/"
	inherit git-r3
else
	#SRC_URI="https://github.com/RadeonOpenCompute/rocm-cmake/archive/rocm-${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/RadeonOpenCompute/rocm-cmake/archive/refs/tags/rocm-${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/rocm-cmake-rocm-${MY_PV}"
fi

DESCRIPTION="Radeon Open Compute CMake Modules"
HOMEPAGE="https://github.com/RadeonOpenCompute/rocm-cmake"
LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
RESTRICT="test"

src_prepare() {
	sed -e "s:set(ROCM_INSTALL_LIBDIR lib):set(ROCM_INSTALL_LIBDIR $(get_libdir)):" -i "${S}/share/rocm/cmake/ROCMInstallTargets.cmake" || die
	cmake_src_prepare
}
