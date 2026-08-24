# Security

Download CLI archives only from the GitHub Release linked by this repository.
The installer verifies the matching archive SHA-256 before extraction.

The first customer release will add a signed release manifest, public key,
rotation procedure, and compromise-response policy. Release assets are
immutable; corrections use a new version rather than replacement.

The CLI binds only to loopback, uses short-lived credentials, and does not send
image bytes or commands to a LatentColor server. Agent hosts may separately send
prompts and CLI output to their model provider.
