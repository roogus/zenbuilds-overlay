# Copyright
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

MY_PV="${PV%"_pre1"}"

DESCRIPTION="An OpenCL general matrix multiplication (GEMM) API and kernel generator"
HOMEPAGE="https://github.com/ROCmSoftwarePlatform/MIOpenGEMM"
#SRC_URI="https://github.com/ROCmSoftwarePlatform/MIOpenGEMM/archive/rocm-${PV}.tar.gz -> miopengemm-${PV}.tar.gz"
SRC_URI="https://github.com/ROCmSoftwarePlatform/MIOpenGEMM/archive/refs/tags/rocm-${MY_PV}.tar.gz -> miopengemm-${MY_PV}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

IUSE="-benchmark"

RDEPEND="virtual/opencl"
DEPEND=">=dev-util/rocm-cmake-${PV}
	>=sys-devel/llvm-roc-${PV}"

S="${WORKDIR}/MIOpenGEMM-rocm-${MY_PV}"

src_prepare() {
	sed -e "s:set( miopengemm_INSTALL_DIR miopengemm):set( miopengemm_INSTALL_DIR \"\"):" -i "${S}/miopengemm/CMakeLists.txt" || die
	sed -e "s:rocm_install_symlink_subdir(\${miopengemm_INSTALL_DIR}):#rocm_install_symlink_subdir(\${miopengemm_INSTALL_DIR}):" -i "${S}/miopengemm/CMakeLists.txt" || die

	cmake_src_prepare
}

src_configure() {
	strip-flags
	filter-flags '*march*'

	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/"
	)

	if use benchmark; then
		mycmakeargs+=( "-DAPI_BENCH_MIOGEMM=On" )
	fi
	cmake_src_configure
}
