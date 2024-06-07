//快排直接输出前k个
#include<stdio.h>
#include<string.h>

int cmp(const void *a, const void *b){
    if(*(int*)a > *(int*)b) return 1;
    else return -1;
}

int main(){
    int n = 0;
    int k = 0;
    scanf("%d %d\n",&n,&k);
    int nums[n];
    for(int i = 0; i < n; i++){
        scanf("%d",&nums[i]);
    }
    qsort(nums,n,sizeof(int),cmp);
    for(int i = 0; i < k; i++){
        printf("%d ",nums[i]);
    }
    return 0;
}