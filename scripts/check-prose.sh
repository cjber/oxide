#!/usr/bin/env bash
# Reject AI-tell prose in docs and code comments. Strict by default.
# Run from repo root.
set -euo pipefail

EXIT=0
report() { echo "::error file=$1,line=$2::$3"; EXIT=1; }

prose_files() {
    # Markdown and code files that hold real prose (READMEs, Lua, shell).
    find . -maxdepth 2 -type f -name '*.md' -not -path './.git/*'
    find . -type f \( -name '*.lua' -o -name '*.sh' \) -not -path './.git/*'
}
all_text_files() {
    # Everything that is plausibly text and might contain comments.
    find . -type f \
        \( -name '*.md' -o -name '*.lua' -o -name '*.sh' \
        -o -name '*.toml' -o -name '*.kdl' -o -name '*.css' \
        -o -name '*.conf' -o -name '*.rasi' -o -name '*.json' \
        -o -name '*.yml' -o -name '*.yaml' \) \
        -not -path './.git/*'
}

# Em-dashes are banned outright. Build the character at runtime so this
# script itself stays slop-free.
EMDASH=$(printf '\xe2\x80\x94')
while IFS=: read -r file line _; do
    [[ -z $file ]] && continue
    report "$file" "$line" "em-dash not allowed (U+2014); use a comma, full stop, or parentheses"
done < <(all_text_files | xargs grep -Hn -- "$EMDASH" 2>/dev/null || true)

# AI-tell words. Case-insensitive, word-boundary. Curated from public
# AI-detection word lists; conservative on technical jargon.
WORDS=(
    delve delves delving
    tapestry
    leverage leverages leveraging
    multifaceted
    comprehensive
    furthermore moreover
    crucial crucially
    utilize utilizes utilization
    robust robustness
    ever-evolving
    testament
    pivotal
    seamless seamlessly
    elevate elevates
    harness harnesses
    unlock unlocks
    unleash unleashes
    embark embarks
    myriad plethora
    paradigm synergy
    nuance nuanced
    holistic
    streamline streamlines streamlining
    empower empowers
    orchestrate orchestrates orchestrating
    underscore underscores
    paramount undoubtedly invaluable
    intricate intricacies
    foster fosters fostering
    quintessential
    spearhead
    "battle-tested" "first-class"
    "in conclusion" "in summary" "to summarize"
    "it's worth noting" "it's important to note" "worth noting"
    "in today's"
    "let's dive" "let's explore" "deep dive"
    "state-of-the-art" "cutting-edge"
    "game-changer" "game-changing" "groundbreaking"
    "as of writing"
)
RX=$(printf '\\b%s\\b\\|' "${WORDS[@]}")
RX=${RX%\\|}

while IFS= read -r f; do
    [[ -z $f ]] && continue
    # Only lines that are comments (for code) or any line (for md).
    if [[ $f == *.md ]]; then
        scope=$(grep -niE "($RX)" "$f" || true)
    else
        scope=$(grep -niE "^\s*(--|#).*($RX)" "$f" || true)
    fi
    [[ -z $scope ]] && continue
    while IFS=: read -r line content; do
        report "$f" "$line" "AI-tell word in: $(echo "$content" | sed 's/^\s*//' | cut -c1-100)"
    done <<< "$scope"
done < <(prose_files)

if [[ $EXIT -eq 0 ]]; then
    echo "prose OK"
fi
exit $EXIT
