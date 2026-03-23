class Tachi < Formula
  desc "Local-first memory + Hub for AI agents (MCP server)"
  homepage "https://github.com/kckylechen1/sigil"
  url "https://github.com/kckylechen1/sigil/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "f7d21ef3228b2294bccb964c91c85f5b7202ee37b210209d6656034975acf5ea"
  license "AGPL-3.0"
  head "https://github.com/kckylechen1/sigil.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "-p", "memory-server",
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
