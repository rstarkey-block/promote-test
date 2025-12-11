# promote-test

Test repository for validating the `promote-configs` script.

## Purpose

This repo simulates the tcp-salt promotion workflow:
- `main` branch = canary (where PRs merge first)
- `stable` branch = production (promoted from main)

## Testing

```bash
# Run promote-configs from tcp-salt repo, pointing at this repo
cd ~/Development/tcp-salt/main
REPO_URL="https://github.com/rstarkey-block/promote-test" script/promote-configs --dry-run
```
