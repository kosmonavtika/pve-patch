#!/usr/bin/env bash
CONTROLFILE='proxmox-patch-tests-control.txt'
ORIGINALFILE='proxmox-patch-tests-original.txt'
TESTFILE='proxmox-patch-tests.txt'
sed -i.backup "s/data.status !== 'Active'/false/g" ${TESTFILE}
sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.false/false/g"${TESTFILE}
sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status \!== 'Active'/false/g" ${TESTFILE}
sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" ${TESTFILE}

echo "Comparing ${TESTFILE} file after replacements with ${ORIGINALFILE}"
echo '===================================================='
diff -y ${TESTFILE} ${ORIGINALFILE}
echo '===================================================='

echo "Comparing ${TESTFILE} file after replacements with ${CONTROLFILE}"
echo '===================================================='
diff -y ${TESTFILE} ${CONTROLFILE}
echo '===================================================='
echo "Run the below to reset the ${TESTFILE} file after replacements with ${ORIGINALFILE}"
echo '===================================================='
echo "rm -f ${TESTFILE} && cp ${ORIGINALFILE} ${TESTFILE}"
echo '===================================================='

