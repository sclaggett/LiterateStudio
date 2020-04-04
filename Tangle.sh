#!/bin/bash
mkdir -p bin

echo -n "Tangling..."
lit -t -odir bin Index.md
cp -R resources/* bin
echo " done."

# lit -t -odir ../bin README.md
#if [ $# -eq 1 ]; then
#  echo -n "Copying output to remote server..."
  # The key setting is -c (checksum) which syncs files based on
  # checksum rather than modification time and size. We want to avoid
  # -a (archive) but use most of what it represents:
  #   recursive (r)
  #   copy symlinks as symlinks (l)
  #   preserve permissions (p)
  #   preserve group (g)
  #   preserve owner (o)
#  rsync -c -rlpgoz bin/ $1:~/capture
#	echo " done."
#fi

#echo ""

