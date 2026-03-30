class Tachi < Formula
  desc "Local-first memory + Hub for AI agents (MCP server)"
  homepage "https://github.com/kckylechen1/tachi"
  url "https://github.com/kckylechen1/tachi/archive/refs/tags/v0.12.2.tar.gz"
  sha256 "ebf976362bccbfa5c5e552128b94cb4dabc7a05e6c748834bdab7bb981424663"
  license "AGPL-3.0"
  head "https://github.com/kckylechen1/tachi.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked", "-p", "memory-server",
           "--target-dir", buildpath/"target"
    bin.install buildpath/"target/release/memory-server" => "tachi"
  end

  test do
    assert_match "tachi", shell_output("#{bin}/tachi --version")
  end

  def caveats
    <<~EOS
      To use Tachi with your AI agent, add to your MCP config:

        {
          "mcpServers": {
            "tachi": {
              "command": "#{HOMEBREW_PREFIX}/bin/tachi"
            }
          }
        }

      API keys (optional, for embedding + LLM features):
        export VOYAGE_API_KEY="your_key"
        export SILICONFLOW_API_KEY="your_key"
    EOS
  end
end
