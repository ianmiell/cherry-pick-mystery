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
git checkout ${CHERRY_PICK_ID}
git format-patch HEAD^ --stdout > ${CHERRY_PICK_ID}.patch
echo Patch of ${CHERRY_PICK_ID} from repoa
echo '================================================================================'
echo Showing ${CHERRY_PICK_ID}
cat ${CHERRY_PICK_ID}.patch
echo '================================================================================'
echo This should only add the checkin 3 line, right?
echo '================================================================================'
echo Applying that id
git checkout master
git apply --reject ${CHERRY_PICK_ID}.patch
echo '================================================================================'
echo The rejected change is in this file now:
cat acommonfile.rej
echo '================================================================================'

