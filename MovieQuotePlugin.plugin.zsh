# MovieQuotePlugin : Movie Quotes Fortunes

# Automatically generate or update movies compiled fortune data file
# $0 must be used outside a local function. This variable name is unlikly to collide.
MOVIES_PLUGIN_DIR=${0:h}

() {
local DIR=$MOVIES_PLUGIN_DIR/fortunes
if [[ ! -f $DIR/final_quotes.dat ]] || [[ $DIR/final_quotes.dat -ot $DIR/final_quotes ]]; then
  # For some reason, Cygwin puts strfile in /usr/sbin, which is not on the path by default
  local strfile=strfile
  if ! which strfile &>/dev/null && [[ -f /usr/sbin/strfile ]]; then
    strfile=/usr/sbin/strfile
  fi
  if which $strfile &> /dev/null; then
    $strfile $DIR/final_quotes $DIR/final_quotes.dat >/dev/null
  else
    echo "[oh-my-zsh] MovieQuotePlugin depends on strfile, which is not installed" >&2
    echo "[oh-my-zsh] strfile is often provided as part of the 'fortune' package" >&2
  fi
fi

# Aliases
alias quote="fortune -a $DIR"
alias quote_cow="quote | cowthink -W 100 -s"
}

unset MOVIES_PLUGIN_DIR
