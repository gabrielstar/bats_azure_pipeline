git clone https://github.com/ztombol/bats-core $HOME/test/test_helper/batscore
git clone https://github.com/ztombol/bats-assert $HOME/test/test_helper/batsassert
source $HOME/test/test_helper/batscore/script/install-bats.sh ~
bats -version