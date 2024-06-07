int main(void) {
    int data = 0;
    scanf("%d", &data);
    int map[10] = {0};
    while (data != 0) { // 判断是否处理了最高位
        int temp = data%10;
        if (map[temp] == 0) { // 判断这一位  是否已经出现过
            map[temp] = temp;
            printf("%d", temp);
        }
        data = data/10; // 个位 -> 十位 -> 百位
    }
    return 0;
}