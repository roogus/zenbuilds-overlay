# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV%"_pre1"}"

inherit cmake

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/RadeonOpenCompute/ROCm-Device-Libs/"
	inherit git-r3
	S="${WORKDIR}/${P}/src"
else
	#SRC_URI="https://github.com/RadeonOpenCompute/ROCm-Device-Libs/archive/rocm-${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/RadeonOpenCompute/ROCm-Device-Libs/archive/refs/tags/rocm-${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/ROCm-Device-Libs-rocm-${MY_PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Radeon Open Compute Device Libraries"
HOMEPAGE="https://github.com/RadeonOpenCompute/ROCm-Device-Libs"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"

RDEPEND=">=sys-devel/llvm-roc-${PV}:="
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "s:amdgcn/bitcode:lib/amdgcn/bitcode:" -i "${S}/cmake/OCL.cmake" || die
	sed -e "s:amdgcn/bitcode:lib/amdgcn/bitcode:" -i "${S}/cmake/Packages.cmake" || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLLVM_DIR="${EPREFIX}/usr/lib/llvm/roc/lib/cmake/llvm"
	)
	cmake_src_configure
}
