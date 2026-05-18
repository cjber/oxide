#!/usr/bin/env bash
# Every hex literal referenced under ports/ must be present in palette/oxide.json.
# Catches drift between the canonical palette and the port files.
# Pass --strict to exit non-zero on drift (default: warn-only).
set -euo pipefail

strict=0
[[ ${1:-} == --strict ]] && strict=1

PALETTE=palette/oxide.json
[[ -f $PALETTE ]] || { echo "missing $PALETTE"; exit 1; }

# Lowercased set of canonical hex values (no leading #).
mapfile -t allowed < <(jq -r '.. | strings | select(test("^#[0-9a-fA-F]{6}([0-9a-fA-F]{2})?$"))' "$PALETTE" \
    | sed 's/^#//' | tr '[:upper:]' '[:lower:]' | awk '{print substr($0,1,6)}' | sort -u)

is_allowed() {
    local hex=$1
    for a in "${allowed[@]}"; do
        [[ $hex == "$a" ]] && return 0
    done
    return 1
}

declare -A seen=()
drift_count=0
while IFS= read -r line; do
    file=${line%%:*}
    rest=${line#*:}
    rest=${rest#*:}
    for match in $(grep -oE '#[0-9a-fA-F]{6,8}' <<< "$rest"); do
        hex=${match#'#'}
        hex=$(echo "${hex:0:6}" | tr '[:upper:]' '[:lower:]')
        if ! is_allowed "$hex"; then
            key="$file:#$hex"
            if [[ -z ${seen[$key]:-} ]]; then
                echo "drift: $file uses #$hex (not in $PALETTE)"
                seen[$key]=1
                drift_count=$((drift_count + 1))
            fi
        fi
    done
done < <(grep -rHnoE '#[0-9a-fA-F]{6,8}' ports/ 2>/dev/null || true)

if [[ $drift_count -eq 0 ]]; then
    echo "palette OK: every hex literal in ports/ is in $PALETTE"
    exit 0
fi

echo
echo "$drift_count distinct off-palette colours found across ports/."
if [[ $strict -eq 1 ]]; then
    echo "strict mode: failing"
    exit 1
fi
echo "warn-only (default). Pass --strict to enforce."
exit 0
