group "ci_targets" {
  targets = ["rclone-sync"]
}
target "ci_platforms" {
	platforms = ["linux/amd64", "linux/arm64"]
}

target "docker-metadata-action" {}

group "default" {
  targets = ["rclone-sync"]
}

target "rclone-sync-local" {
  tags = ["rclone-sync:local"]
}

target "rclone-sync" {
	inherits = ["rclone-sync-local", "ci_platforms", "docker-metadata-action"]
	context = "rclone-sync"
	dockerfile = "Dockerfile"
}