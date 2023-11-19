#!/usr/bin/env bash
./gen_google_grpc.sh

PROTO_PATH=`pwd`/../rumgap/proto
PROTOS=`find "${PROTO_PATH}" -type f -name '*.proto'`
protoc --proto_path=${PROTO_PATH} --dart_out=grpc:lib/gen $PROTOS --experimental_allow_proto3_optional