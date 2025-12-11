#!/bin/bash
set -e

# Get commits to validate (from origin/stable to HEAD)
commits=$(git log origin/stable..HEAD --no-merges --format="%H")

if [ -z "$commits" ]; then
    echo "No commits to validate"
    exit 0
fi

echo "Commits to validate:"
git log origin/stable..HEAD --no-merges --oneline

echo ""
echo "Validating commits exist on main..."

# Get patch-ids from main branch
main_patch_ids=$(git log origin/main --format="%H" | while read commit; do
    git show "$commit" --format= | git patch-id --stable
done | awk '{print $1}')

# Check each commit
for commit in $commits; do
    echo "Checking commit: $(git log -1 --oneline $commit)"
    
    # Get patch-id for this commit
    patch_id=$(git show "$commit" --format= | git patch-id --stable | awk '{print $1}')
    echo "  Patch-ID: $patch_id"
    
    # Check if patch-id exists on main
    if echo "$main_patch_ids" | grep -q "^${patch_id}$"; then
        echo "  ✓ FOUND on main"
    else
        echo "  ✗ NOT FOUND on main"
        echo ""
        echo "ERROR: Commit $commit does not exist on main"
        exit 1
    fi
done

echo ""
echo "✓ All commits validated successfully"
