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
	printf("������Ҫ���н׳˵�����");
	scanf("%d", &num);
	X = JC(num);
	printf("�׳˵Ľ��Ϊ��%d\n", X);
	return 0;
}