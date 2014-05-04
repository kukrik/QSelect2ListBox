#! /bin/bash

which greadlink >/dev/null || alias greadlink='readlink'
self="$(greadlink -f $0 2>/dev/null || echo $(pwd -P)/$0)"
source_dir=$(dirname "$self")/../source
cd "$source_dir"

echo "Creating a zip archive.."
#Format date
date=$(date +%Y-%m-%d)
#Package variables
version=$(grep "strVersion" install.php | grep -oE '[0-9](.[0-9])+')
platform=$(grep "strPlatformVersion" install.php | grep -oE '[0-9](.[0-9])+')
package=$(grep "strName" install.php | grep -oE '\"[A-Za-z0-9]*\"' | tr -d '"')

filename=${package}_${version}_${platform}_${date}.zip
rm -f ../releases/$filename
zip -x \*.svn\* \*~ \*.sh -rq ../releases/$filename .

echo ""
echo "All done, saved as $filename"
