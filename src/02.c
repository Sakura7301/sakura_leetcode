#include<stdio.h>
#include<string.h>

int main(){
    int i = 0;
    int j = 0;
    int len = 0;
    char str[5000] = {0};
    char chr[2] = {0};
    scanf("%[^\n]", str);
    scanf("%s", chr);

    len = strlen(str);
    if(chr[0] - '0' >= 0 && chr[0] - '0' <= 9){
        for(i = 0,j = 0; i < len; i++){
            if(str[i] == chr[0]){
                j++;
            }  
        }    
    } else {
        for(i = 0,j = 0; i < len; i++){
            if(str[i] == chr[0] || str[i]+32 == chr[0] || str[i] == chr[0]+32){
                j++;
            }
        }
    }
    printf("%d\n", j);
    return 0;
}