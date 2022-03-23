#include<stdio.h>
#include<linux/unistd.h>
#include<sys/syscall.h>
#include<linux/kernel.h>
#include<sys/types.h>
int main(void){
  int i = syscall(335);
  if(i<0){
    printf("new systemcall didn't work.\n");
    return 1;
  }
  printf("success\n");
  return 0;
}