Data and scripts for practicals
===============================

This repository contains instructions, bits of data, and scripts. First thing to do is clone it into your home directory. Log on to the cluster and type:

    git clone https://github.com/explodecomputer/wits.git

It will download about 16Mb of data. The next thing to do is cp the necessary executables into your home directory so that it is visible on your path:

    cp -r wits/bin .

There is a file in `wits/` called `config`. This is to point to the directory containing the genotype data (currently `/global/geneticepi/`). In the data directory there are also pre-computed results for some of the more computationally demanding routines, so if they are running slowly then no problem just pick up the results from here.

Each practical has its own folder within `wits/`. If you navigate to the folder on the github website then the README should show up, outlining the instructions etc for that practical.

Ff changes are made by the owner of this repository you can sync your local copy by running the command

    git pull

Finally, it is possible to copy this into your own github repository where you will have the ability to save your changes etc. Just ask how to go about doing this if you're not sure.
