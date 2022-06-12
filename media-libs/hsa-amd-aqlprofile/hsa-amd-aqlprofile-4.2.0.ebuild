# Copyright
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit unpacker

DESCRIPTION="AMD HSA Aqlprofile"
HOMEPAGE="https://github.com/RadeonOpenCompute/ROCm"
SRC_URI="http://repo.radeon.com/rocm/apt/4.2/pool/main/h/hsa-amd-aqlprofile4.2.0/hsa-amd-aqlprofile4.2.0_1.0.0.40200-21_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
        unpack_deb ${A}
}

src_install() {
	dolib.so "${S}/opt/rocm-4.2.0/hsa-amd-aqlprofile/lib/libhsa-amd-aqlprofile64.so.1.0.40200"
	dosym "libhsa-amd-aqlprofile64.so.1.0.40200" "/usr/$(get_libdir)/libhsa-amd-aqlprofile64.so"
	dosym "libhsa-amd-aqlprofile64.so.1.0.40200" "/usr/$(get_libdir)/libhsa-amd-aqlprofile64.so.1"
}
