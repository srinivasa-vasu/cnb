#!/usr/bin/env bash

usage() { echo "Usage: $0 [-v <image version>]" 1>&2; exit 1; }
version=tiny

while getopts "v:" o; do
  case "${o}" in
    v)
      version=${OPTARG}
      [[ -n ${version} ]] || usage
      ;;
    *)
      usage
      ;;
  esac
done

docker pull ubunutu:bionic

scripts_dir=$(cd $(dirname $0) && pwd)
dir=${scripts_dir}/../tiny

base_image=humourmind/cnb-base:${version}
run_image=humourmind/cnb-run:${version}
#run_base_image=cloudfoundry/run:tiny
run_base_image=gcr.io/distroless/base
build_image=humourmind/cnb-build:${version}
stack_id="io.buildpacks.stacks.bionic"
cnb_uid=1000
cnb_gid=1000
docker build -t "${base_image}" "$dir/base"
docker build --build-arg "base_image=${base_image}" --build-arg "stack_id=${stack_id}" --build-arg "cnb_uid=${cnb_uid}" --build-arg "cnb_gid=${cnb_gid}" -t "${build_image}"  "$dir/build"
docker build --build-arg "base_image=${run_base_image}" --build-arg "stack_id=${stack_id}" --build-arg "cnb_uid=${cnb_uid}" --build-arg "cnb_gid=${cnb_gid}" -t "${run_image}" "$dir/run"

echo "To publish these images:"
for image in "${base_image}" "${run_image}" "${build_image}"; do
  echo "  docker push ${image}"
done
