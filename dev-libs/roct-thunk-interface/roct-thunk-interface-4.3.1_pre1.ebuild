# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV%"_pre1"}"

inherit cmake linux-info

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/"
	inherit git-r3
else
	#SRC_URI="https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/archive/rocm-${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/archive/refs/tags/rocm-${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/ROCT-Thunk-Interface-rocm-${MY_PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Radeon Open Compute Thunk Interface"
HOMEPAGE="https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface"
CONFIG_CHECK="~HSA_AMD ~HMM_MIRROR ~ZONE_DEVICE ~DRM_AMDGPU ~DRM_AMDGPU_USERPTR"
LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"

RDEPEND="sys-process/numactl"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "s:get_version ( \"1.0.0\" ):get_version ( \"${MY_PV}\" ):" -i CMakeLists.txt || die
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
		-DCPACK_PACKAGING_INSTALL_PREFIX="${EPREFIX}/usr"
	)
	cmake_src_configure
}
