goto_reload() {
	[ -f "$GOTO_ALIAS" ] && source "$GOTO_ALIAS"
}

goto() {
	goto_reload
	if [ $# -eq 0 ]; then
		echo "goto: unknown path alias"
		return 1
	fi
	dir="${1/#\~/$HOME}"
	if [ ! -d "$dir" ]; then
		echo "goto: invalid directory '$1'"
		return 1
	fi
	cd "$dir" && ls -l
}

goto_list() {
	goto_reload
	if [ ! -f "$GOTO_ALIAS" ]; then
		echo "goto_list: alias file '$GOTO_ALIAS' not found"
		return 1
	fi
	aliases=("$(grep "^[[:alnum:]_]*=\".*\"$" "$GOTO_ALIAS" | cut -d '=' -f 1 | sort -u)")
	for alias in ${aliases[@]}; do
		printf "$%-20s ${!alias}\n" $alias
	done
}

goto_edit() {
	if [ -z "$EDITOR" ]; then
		echo "goto_edit: default editor not set"
		return 1
	fi
	tmpfile="$(mktemp)"
	if [ -f "$GOTO_ALIAS" ]; then
		cat "$GOTO_ALIAS" > "$tmpfile"
	fi
	$EDITOR "$tmpfile" && mv "$tmpfile" "$GOTO_ALIAS" && goto_reload
}

##
GOTO_ALIAS="$HOME/.goto_alias"
goto_reload

