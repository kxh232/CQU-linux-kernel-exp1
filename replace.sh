#!/bin/bash
#
# Auther: FredyVia
# set the below variable
# KERNEL_SYSCALL_TBL_PATH /arch/x86/entry/syscalls/syscall_64.tbl
# KERNEL_SYSCALL_C_PATH /kernel/sys.c
# KERNEL_SYSCALL_H_PATH /arch/x86/include/asm/syscalls.h
KERNEL_SYSCALL_TBL_PATH="${KERNEL_PREFIX}${KERNEL_SYSCALL_TBL_PATH}"
KERNEL_SYSCALL_C_PATH="${KERNEL_PREFIX}${KERNEL_SYSCALL_C_PATH}"
KERNEL_SYSCALL_H_PATH="${KERNEL_PREFIX}${KERNEL_SYSCALL_H_PATH}"
#getSyscallNum
SYSCALL_NUM="0"
TMP_NUM="0"
while read line || [[ -n "$line" ]]; do
  TMP_NUM=$(echo $line | awk '{print $1}' | grep -E '[0-9]+')
  if [ ! -z ${TMP_NUM} ]; then
    if [ ${TMP_NUM} -gt ${SYSCALL_NUM} ]; then
      break
    else
      SYSCALL_NUM=$((TMP_NUM + 1))
    fi
  fi
done <${KERNEL_SYSCALL_TBL_PATH}
echo "SYSCALL_NUM found ${SYSCALL_NUM}"

echo "############ generate file ############"
echo "=================sys.c================="
sed -i "s/NAME/${NAME}/" sys.c
sed -i "s/ID/${ID}/" sys.c
cat sys.c
echo "=============syscall_64.tbl============"
sed -i "s/SYSCALL_NUM/${SYSCALL_NUM}/" syscall_64.tbl
cat syscall_64.tbl
echo ""
echo "########end of generate file ########"

echo ""
echo "############replace file ############"
cat sys.c | tee -a ${KERNEL_SYSCALL_C_PATH}

cat syscalls.h | tee -a ${KERNEL_SYSCALL_H_PATH}

cat syscall_64.tbl | tee -a ${KERNEL_SYSCALL_TBL_PATH}
echo ""
echo "############end replace file ############"

echo ""
echo "############check sys.c file ############"
echo ${KERNEL_SYSCALL_C_PATH}
tail -n 5 ${KERNEL_SYSCALL_C_PATH}
echo ""
echo "############check syscalls.h file ############"
echo ${KERNEL_SYSCALL_H_PATH}
tail -n 2 ${KERNEL_SYSCALL_H_PATH}
echo ""
echo "############check syscall_64.tbl file ############"
echo ${KERNEL_SYSCALL_TBL_PATH}
tail -n 2 ${KERNEL_SYSCALL_TBL_PATH}
