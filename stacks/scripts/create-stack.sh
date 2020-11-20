#!/usr/bin/env bash

usage() { echo "Usage: $0 [-v <image version> -b <ubuntu base os version>]" 1>&2; exit 1; }
version=tiny
base_os=bionic

set -x

while getopts "v:b:" o; do
  case "${o}" in
    v)
      version=${OPTARG}
      [[ -n ${version} ]] || version=tiny
      ;;
    b)
      base_os=${OPTARG}
      [[ -n ${base_os} ]] || base_os=bionic
      ;;
    *)
      usage
      ;;
  esac
done

docker pull ubunutu:${base_os}

scripts_dir=$(cd $(dirname $0) && pwd)
dir=${scripts_dir}/../tiny

base_image=humourmind/cnb-${base_os}-base:${version}
run_image=humourmind/cnb-${base_os}-run:${version}
run_base_image=gcr.io/paketo-buildpacks/run:tiny-cnb
#run_base_image=gcr.io/distroless/base
build_image=humourmind/cnb-${base_os}-build:${version}
stack_id="io.buildpacks.stacks.bionic"
cnb_uid=1000
cnb_gid=1000
docker build -t "${base_image}" "$dir/base" --build-arg "base_os=${base_os}"
docker build --build-arg "base_os=${base_os}" --build-arg "base_image=${base_image}" --build-arg "stack_id=${stack_id}" --build-arg "cnb_uid=${cnb_uid}" --build-arg "cnb_gid=${cnb_gid}" -t "${build_image}"  "$dir/build"
docker build --build-arg "base_os=${base_os}" --build-arg "base_image=${run_base_image}" --build-arg "stack_id=${stack_id}" --build-arg "cnb_uid=${cnb_uid}" --build-arg "cnb_gid=${cnb_gid}" -t "${run_image}" "$dir/run"

echo "To publish these images:"
for image in "${base_image}" "${run_image}" "${build_image}"; do
  echo "  docker push ${image}"
done
