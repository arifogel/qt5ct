#!/bin/sh

if [ ! -d "cache" ]; then
mkdir cache
fi


cd cache

echo "Receiving sources.."
if [ ! -d "-svn" ]; then
svn checkout https://svn.code.sf.net/p/qt5ct/code/trunk/qt5ct qt5ct-svn
fi

cd qt5ct-svn
svn up
echo "Creating changelog.."
svn log > ChangeLog.svn

MAJOR=`cat src/qt5ct/qt5ct.h | grep "#define QT5CT_VERSION_MAJOR" | cut -d " " -f3`
MINOR=`cat src/qt5ct/qt5ct.h | grep "#define QT5CT_VERSION_MINOR" | cut -d " " -f3`

TARBALL=qt5ct-$MAJOR.$MINOR


echo Sources name: $TARBALL
cd ..
if [ -d $TARBALL ]; then
echo "Removing previous directory.."
rm -rf $TARBALL
fi

echo "Copying sources.."
cp -r qt5ct-svn $TARBALL

cd $TARBALL

echo "Removing svn tags.."
rm -rf .svn
cd ..

echo "Creating tarball.."
tar vcjf ${TARBALL}.tar.bz2 ${TARBALL}/

echo "Removing temporary directory.."
rm -rf ${TARBALL}

#echo "Creating md5 sum.."
#md5sum -b ${TARBALL}.tar.bz2 > ${TARBALL}.tar.bz2.md5sum

echo "Moving released files.."
cd ..
if [ ! -d "files" ]; then
mkdir files
fi
mv cache/${TARBALL}.tar.bz2 files/
#mv cache/${TARBALL}.tar.bz2.md5sum files/

echo ""
echo "****** RELEASED FILES *******"
echo "Tarball: ${TARBALL}.tar.bz2"
#echo "MD5: ${TARBALL}.tar.bz2.md5sum"
echo "*****************************"
echo ""
echo "Finished"
