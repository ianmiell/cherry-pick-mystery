rm -rf /tmp/repoa /tmp/repob
mkdir -p /tmp/repoa
mkdir -p /tmp/repob
cd /tmp/repoa
git init
cat > acommonfile << END
Line 1 is common
END
git add acommonfile
git commit -am 'Initial repoa'
cat >> acommonfile << END
checkin 2 repoa
END
git commit -am 'Checkin 2'
cat >> acommonfile << END
checkin 3 repoa
END
git commit -am 'Checkin 3'
cd /tmp/repob
git init
cat > acommonfile << END
Line 1 is common
END
git add acommonfile
git commit -am 'Initial repob'
git remote add repoa ../repoa
git fetch repoa
CHERRY_PICK_ID=$(git log --oneline repoa/master | head -1 | awk '{print $1}')
echo Cherry-picking ${CHERRY_PICK_ID} from repoa
echo '================================================================================'
echo Showing ${CHERRY_PICK_ID}
git show ${CHERRY_PICK_ID}
echo '================================================================================'
echo This should only add the checkin 3 line, right?
echo '================================================================================'
echo Cherry-picking that id
git cherry-pick ${CHERRY_PICK_ID}
echo '================================================================================'
echo THE FILE NOW CONTAINS Checkin 2\'s content?
echo $ cat acommonfile
cat acommonfile
echo '================================================================================'

