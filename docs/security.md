# Security

Download CLI archives only from the GitHub Release linked by this repository.
The installer verifies the matching archive SHA-256 before extraction.

Every release uses a new version. The release workflow publishes one archive per supported platform together with its checksums and release manifest.

The CLI binds only to loopback, uses short-lived credentials, and does not send
image bytes or commands to a latentcolor server. Agent hosts may separately send
prompts and CLI output to their model provider.
