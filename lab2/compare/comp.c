#include<stdio.h>

int JC(int num) {
	int i;
	int count = 1;
	if (num == 1 || num == 0) {
		printf("1");
	}
	for (i = 1; i <= num; ++i) {
		count = count * i;
	}
	return count;
}

int main() {
	int num;
	int X;
	printf("请输入要进行阶乘的数：");
	scanf("%d", &num);
	X = JC(num);
	printf("阶乘的结果为：%d\n", X);
	return 0;
}