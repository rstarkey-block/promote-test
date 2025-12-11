# Scenario B Test Results: Normal Cherry-Pick Promotion

## Test Date
2025-12-10 20:41 PST

## Test Objective
Verify that promoting a commit that exists on main passes validation when using cherry-pick mode.

## Test Setup

### Initial State
- **stable branch**: Contains hotfix commit (3dfcc46) that's not on main
- **main branch**: Contains PR #1, #2, #3 and their merge commits

### Test Execution
1. Created promotion branch `promote-pr3` from `origin/stable`
2. Cherry-picked commit `9e7c096` (PR #3: "Enhance deployment script with health checks")
3. Note: PR #2 cherry-pick was skipped because hotfix already added deploy.sh with same content

## Validation Range
```
$ git log origin/stable..HEAD --no-merges --oneline
d6becae Enhance deployment script with health checks
```

**Result**: Only one commit in validation range (PR #3)

## Patch-ID Verification

### Cherry-picked commit (d6becae):
- Patch-ID: `066f38965148a43426d094d33710cd2d7013f352`
- Commit message: "Enhance deployment script with health checks"
- Changes: 4 insertions to scripts/deploy.sh

### Original commit on main (9e7c096):
- Patch-ID: `066f38965148a43426d094d33710cd2d7013f352`
- Commit message: "Enhance deployment script with health checks"
- Changes: 4 insertions to scripts/deploy.sh

### Comparison
- **Patch-IDs match**: ✓ YES
- **Content identical**: ✓ YES (same diff, same author, same timestamp)
- **SHA differs**: ✓ Expected (different parent commits)

## Validation Test Result

```
Commits to validate:
d6becae Enhance deployment script with health checks

Validating commits exist on main...
Checking commit: d6becae Enhance deployment script with health checks
  Patch-ID: 066f38965148a43426d094d33710cd2d7013f352
  ✓ FOUND on main

✓ All commits validated successfully
```

## Test Result: PASS ✓

### Key Findings
1. **Cherry-pick detection works correctly**: The cherry-picked commit has a different SHA but same patch-id
2. **Patch-id matching is effective**: Successfully identified that PR #3's changes exist on main
3. **Validation passes as expected**: Normal promotion of commits from main to stable works correctly
4. **No false positives**: Validation correctly identifies matching content despite different commit SHAs

### Technical Details
- Cherry-picked commit SHA: `d6becae`
- Original commit SHA: `9e7c096`
- Both produce identical patch-id: `066f38965148a43426d094d33710cd2d7013f352`
- This confirms patch-id is based on diff content, not commit metadata

## Conclusion
Scenario B validates that the promote-configs refactor correctly handles normal cherry-pick promotions. The patch-id based validation successfully identifies when a commit's changes exist on the main branch, even when the commit SHA differs due to cherry-picking.
