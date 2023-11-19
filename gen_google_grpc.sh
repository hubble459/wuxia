#!/usr/bin/env bash

export PROTOBUF=/opt/protobuf
export GOOGLEAPIS=/opt/googleapis
GEN_DIR=lib/gen

if [ ! -d "$PROTOBUF" ]; then
  echo "Please set the PROTOBUF environment variable to your clone of protocolbuffers/protobuf."
  exit -1
fi

if [ ! -d "$GOOGLEAPIS" ]; then
  echo "Please set the GOOGLEAPIS environment variable to your clone of googleapis/googleapis."
  exit -1
fi

PROTOC="protoc --dart_out=grpc:$GEN_DIR -I$PROTOBUF/src -I$GOOGLEAPIS"

$PROTOC $GOOGLEAPIS/google/rpc/status.proto

$PROTOC $PROTOBUF/src/google/protobuf/any.proto
$PROTOC $PROTOBUF/src/google/protobuf/duration.proto
$PROTOC $PROTOBUF/src/google/protobuf/empty.proto
$PROTOC $PROTOBUF/src/google/protobuf/struct.proto
$PROTOC $PROTOBUF/src/google/protobuf/timestamp.proto

dart format $GEN_DIR/google