#!/bin/bash


ACTION="$1"
VARIANT="$2"
PKG_BUILD_DIR="$3"
STAGING_DIR_IMAGE="$4"

case "$VARIANT" in
"rk3568")
	ATF="rk35/rk3568_bl31_v1.28.elf"
	DDR="rk35/rk3568_ddr_1560MHz_v1.13.bin"
	;;
*)
	echo -e "Not compatible with your platform: $VARIANT."
	exit 1
	;;
esac

set -x
if [ "$ACTION" == "build" ]; then
	case "$VARIANT" in
	rk33*)
		"$PKG_BUILD_DIR"/tools/mkimage -n "$VARIANT" -T "rksd" -d "$PKG_BUILD_DIR/bin/$DDR" "$PKG_BUILD_DIR/$VARIANT-idbloader.bin"
		cat "$PKG_BUILD_DIR/bin/$LOADER" >> "$PKG_BUILD_DIR/$VARIANT-idbloader.bin"
		"$PKG_BUILD_DIR/tools/trust_merger" --replace "bl31.elf" "$PKG_BUILD_DIR/bin/$ATF" "$PKG_BUILD_DIR/trust.ini"
		;;
	esac
elif [ "$ACTION" == "install" ]; then
	mkdir -p "$STAGING_DIR_IMAGE"
	cp -fp "$PKG_BUILD_DIR/bin/$ATF" "$STAGING_DIR_IMAGE"/
	case "$VARIANT" in
	rk33*)
		cp -fp "$PKG_BUILD_DIR/tools/loaderimage" "$STAGING_DIR_IMAGE"/
		cp -fp "$PKG_BUILD_DIR/$VARIANT-idbloader.bin" "$STAGING_DIR_IMAGE"/
		cp -fp "$PKG_BUILD_DIR/$VARIANT-trust.bin" "$STAGING_DIR_IMAGE"/
		;;
	rk35*)
		cp -fp "$PKG_BUILD_DIR/bin/$DDR" "$STAGING_DIR_IMAGE"/
		;;
	esac
else
	echo -e "Unknown operation: $ACTION."
	exit 1
fi
set +x
