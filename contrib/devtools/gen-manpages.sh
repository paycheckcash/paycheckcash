#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

PAYCHECKCASHD=${PAYCHECKCASHD:-$BINDIR/paycheckcashd}
PAYCHECKCASHCLI=${PAYCHECKCASHCLI:-$BINDIR/paycheckcash-cli}
PAYCHECKCASHTX=${PAYCHECKCASHTX:-$BINDIR/paycheckcash-tx}
PAYCHECKCASHQT=${PAYCHECKCASHQT:-$BINDIR/qt/paycheckcash-qt}

[ ! -x $PAYCHECKCASHD ] && echo "$PAYCHECKCASHD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
PCCVER=($($PAYCHECKCASHCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for paycheckcashd if --version-string is not set,
# but has different outcomes for paycheckcash-qt and paycheckcash-cli.
echo "[COPYRIGHT]" > footer.h2m
$PAYCHECKCASHD --version | sed -n '1!p' >> footer.h2m

for cmd in $PAYCHECKCASHD $PAYCHECKCASHCLI $PAYCHECKCASHTX $PAYCHECKCASHQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${PCCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${PCCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
