#!/usr/bin/env bash
clear && rm -rf $HOME/test/test_helper/batscore  && rm -rf $HOME/test/test_helper/batsassert
git clone https://github.com/ztombol/bats-core $HOME/test/test_helper/batscore
git clone https://github.com/ztombol/bats-assert $HOME/test/test_helper/batsassert
ls $HOME/test/test_helper/batscore
source $HOME/test/test_helper/batscore/script/install-bats.sh ~