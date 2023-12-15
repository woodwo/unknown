package main

import (
	"log"
	"net"

	"github.com/woodwo/unknown/grpc/proto"
	"github.com/woodwo/unknown/internal/server"

	"google.golang.org/grpc"
)

func main() {
	// Create new gRPC server instance
	s := grpc.NewServer()

	// Put function that return Fibonacci
	srv := &server.GRPCServer{}

	// Register gRPC server for handle
	proto.RegisterComplicatedServer(s, srv)

	// Listen on port 8080
	l, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatal(err)
	}

	// Start gRPC server
	if err := s.Serve(l); err != nil {
		log.Fatal(err)
	}
}
