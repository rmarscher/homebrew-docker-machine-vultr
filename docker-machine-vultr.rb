class DockerMachineVultr < Formula
  desc "driver for Vultr"
  homepage "https://github.com/janeczku/docker-machine-vultr"
  url "https://github.com/rmarscher/docker-machine-vultr/archive/v1.0.7-cloud-config-template.tar.gz"
  version "1.0.7-cloud-config-template"
  sha256 "7a421c45e0530d59e76ca359e85b855b09c7b9670c7f00ba93d6c7d21c98e350"

  depends_on "go" => :build
  depends_on "docker-machine" => :recommended

  # if OS.linux?
  #   if Hardware.is_64_bit?
  #     url url "https://github.com/rmarscher/docker-machine-vultr/releases/download/v1.0.7-rancher-block-alpha/docker-machine-driver-vultr-v1.0.7-rancher-block-alpha-linux-amd64.tar.gz"
  #     sha256 "45a01118a30f89bd3d26192ab99d9d59ac0867d716acfb1514e82a6f76fd7223"
  #   end
  # end
  # depends_on :arch => :intel

  # def install
  #   bin.install "docker-machine-driver-vultr"
  # end

  def install
    ENV["GOPATH"] = buildpath
    ENV["VERSION"] = "v#{version}"
    mkdir_p "src/github.com/janeczku/docker-machine-vultr"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/janeczku/docker-machine-vultr"
    system "make", "get-build-deps"
    system "make", "build"
    cp "build/docker-machine-driver-vultr-v#{version}", "docker-machine-driver-vultr"
    bin.install "docker-machine-driver-vultr"
  end

  test do
    system "#{bin}/docker-machine-driver-vultr"
  end
end
