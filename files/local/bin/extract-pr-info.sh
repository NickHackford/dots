#!/bin/bash

# Extract pull request information and repository PR template
# Usage: extract-pr-info.sh [OWNER] [REPO]

set -e

OWNER="$1"
REPO="$2"

# Try to get owner/repo from git if not provided
if [ -z "$OWNER" ] || [ -z "$REPO" ]; then
    GIT_REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
    if [[ $GIT_REMOTE =~ git\.hubteam\.com[:/]([^/]+)/([^/]+)\.git ]]; then
        OWNER="${BASH_REMATCH[1]}"
        REPO="${BASH_REMATCH[2]}"
    else
        echo '{"error": "Could not determine repository owner/name"}' >&2
        exit 1
    fi
fi

# Check if there's an existing PR for current branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "")
EXISTING_PR=""
EXISTING_PR_JSON="{}"

if [ -n "$CURRENT_BRANCH" ]; then
    EXISTING_PR=$(gh pr list --repo $OWNER/$REPO --head $CURRENT_BRANCH --json number,title,body,url --limit 1 2>/dev/null || echo "[]")
    if [ "$EXISTING_PR" != "[]" ]; then
        EXISTING_PR_JSON=$(echo "$EXISTING_PR" | jq '.[0]')
    fi
fi

# Try to find PR template in common locations
PR_TEMPLATE=""
TEMPLATE_LOCATIONS=(
    ".github/pull_request_template.md"
    ".github/PULL_REQUEST_TEMPLATE.md"
    "docs/pull_request_template.md"
    "docs/PULL_REQUEST_TEMPLATE.md"
    "PULL_REQUEST_TEMPLATE.md"
    "pull_request_template.md"
)

for template_path in "${TEMPLATE_LOCATIONS[@]}"; do
    if [ -f "$template_path" ]; then
        PR_TEMPLATE=$(cat "$template_path" 2>/dev/null || echo "")
        break
    fi
done

# If no local template found, try to get from GitHub API
if [ -z "$PR_TEMPLATE" ]; then
    for template_path in "${TEMPLATE_LOCATIONS[@]}"; do
        TEMPLATE_CONTENT=$(gh api repos/$OWNER/$REPO/contents/$template_path --jq '.content' 2>/dev/null | base64 -d 2>/dev/null || echo "")
        if [ -n "$TEMPLATE_CONTENT" ]; then
            PR_TEMPLATE="$TEMPLATE_CONTENT"
            break
        fi
    done
fi

# Get repository information
REPO_INFO=$(gh api repos/$OWNER/$REPO --jq '{
    name: .name,
    fullName: .full_name,
    description: .description,
    defaultBranch: .default_branch,
    private: .private
}' 2>/dev/null || echo '{}')

# Output combined information
jq -n --arg owner "$OWNER" \
      --arg repo "$REPO" \
      --arg branch "$CURRENT_BRANCH" \
      --argjson existingPr "$EXISTING_PR_JSON" \
      --arg template "$PR_TEMPLATE" \
      --argjson repoInfo "$REPO_INFO" '{
    owner: $owner,
    repo: $repo,
    currentBranch: $branch,
    existingPr: $existingPr,
    template: $template,
    repository: $repoInfo
}'