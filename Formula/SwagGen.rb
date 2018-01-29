class Swaggen < Formula
  desc "Swagger/OpenAPISpec code generator written in Swift"
  homepage "https://github.com/TimPapler/SwagGen"
  url "https://github.com/TimPapler/SwagGen/archive/1.3.0-beta1.tar.gz"
  sha256 "7d96d2781db09a58ffc9a98e70e126b612d6e34aa000675d7cd2298c1d958398" 
  head "https://github.com/TimPapler/SwagGen.git"

  depends_on :xcode

  def install
    build_path = "#{buildpath}/.build/release/SwagGen"
    ohai "Building SwagGen"
    system("swift build --disable-sandbox -c release -Xswiftc -static-stdlib")
    bin.install build_path
  end
end
