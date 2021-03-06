#!/bin/bash
# 
# USAGE
# 
#       bash installvmc.sh
# 
# NOTES
# 
#       Copies the vmc packages into /opt/vmc, and puts the vmc script into /usr/local/bin.  Once
#       there, vmc can be called (with its requisite options) from anywhere with just vmc.sh.
# 


# SET VARIABLES ===================================================================================

 
script=$(readlink -f "$0") # Absolute path to this script, e.g. /home/user/bin/foo.sh
scriptpath=$(dirname "$script") # Absolute path this script is in, thus /home/user/bin
        # http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides

tdir=/opt/vmc/tools

fdir=/opt/vmc/functions

# CHECK FOR PREVIOUS INSTALLATION =================================================================

if [ -d /opt/vmc/ ]; then

    echo -n "Removing vmc..."

    bash $scriptpath/uninstallvmc.sh 1>/dev/null
    
    echo "done."

    # echo "A version of vmc is already installed.  To uninstall, run uninstallvmc.sh"
    # exit 1

fi

# MOVE VMC FILES ==================================================================================

# get sudo 
sudo ls 1>/dev/null

echo -n "Installing vmc..."

# create vmc directories
sudo mkdir -p $tdir
sudo mkdir -p $fdir

# move tools
sudo cp -r $scriptpath/tools/* $tdir/

sudo tar -xf $scriptpath/cmusphinx-en-us-ptm-5.2.tar.gz -C $tdir
sudo mv  $tdir/cmusphinx-en-us-ptm-5.2 $tdir/en-us

# move functions
sudo cp -r $scriptpath/functions/* $fdir/

# move vmc into user's path & set as executable
sudo cp $scriptpath/vmc.sh /usr/local/bin/vmc.sh
sudo chmod +x /usr/local/bin/vmc.sh

# move lmt into user's path  & set as executable
sudo cp $scriptpath/lmt.sh /usr/local/bin/lmt.sh
sudo chmod +x /usr/local/bin/lmt.sh

# GET SPHINXTRAIN BINARIES ========================================================================

# copy binary tools into model folder
sudo cp /usr/local/libexec/sphinxtrain/bw $tdir
sudo cp /usr/local/libexec/sphinxtrain/map_adapt $tdir
sudo cp /usr/local/libexec/sphinxtrain/mk_s2sendump $tdir
sudo cp /usr/local/libexec/sphinxtrain/mllr_solve $tdir

echo "done."

