# unknown
This service offers a simple unary RPC (Remote Procedure Call) that returns a random number between 1 and 100. The focus is on real-life build tools and practices, even though the API itself is straightforward.

In this context, the gRPC service serves as a practical example or a "lab" to demonstrate:

- gRPC Implementation: How to set up and implement a gRPC service in Go, including defining the service in a .proto file and generating the corresponding Go code.

- Use of Build Tools: Demonstrating the use of tools like golangci-lint, mockgen, and protoc-gen-go-grpc in a real-life development scenario.

This setup is valuable for learning purposes as it covers several aspects of Go and gRPC development in a controlled environment, making it easier to understand each component in the context of a functional service.

# howto

## generate
```bash
make generate
```
will update the generated code from the .proto description.

## build and run

```bash
make run
```
will build and start the service on localhost, making it available on port 8080.

## interact

You have to install Evans via package manager or GitHub releases, then run
```bash
make evans
```
At this point, you can call `Random` on the server.