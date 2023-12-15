package server

import (
	"context"
	"math/rand"

	"github.com/woodwo/unknown/grpc/proto"
)

type GRPCServer struct{
}

// Add method for return some Random
func (s *GRPCServer) Random(ctx context.Context, req *proto.Empty) (*proto.Value, error) {
    randomValue := rand.Intn(100) + 1
    return &proto.Value{
        Value: int32(randomValue),
    }, nil
}