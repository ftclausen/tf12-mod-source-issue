data "docker_registry_image" "debian" {
  name = "debian:stable-slim"
}

data "docker_registry_image" "alpine" {
  name = "alpine:3.12.0"
}
