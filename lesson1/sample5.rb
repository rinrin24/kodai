def kaiNoKoshiki(a, b, c)
	printf("解は %g と %g\n", (-b + Math.sqrt(b * b - 4 * a * c)) / 2 * a, (-b - Math.sqrt(b * b - 4 * a * c)) / 2 * a)
	return 0;
end
def kaiNoKoshikiX(a, b, c)
	if(b < 0) then
		a = -a;
		b = -b;
		c = -c;
		alpha = -(-b - Math.sqrt(b * b - 4 * a * c)) / 2;
		beta = (c / a) / alpha;
		printf("解は %g と %g\n", beta, alpha);
		return 0;
	end
	alpha = (-b - Math.sqrt(b * b - 4 * a * c)) / 2;
	beta = (c / a) / alpha;
	printf("解は %g と %g\n", beta, alpha);
	return 0;
end
def kaiNoKoshikiBoth(a, b, c)
	kaiNoKoshiki(a, b, c)
	kaiNoKoshikiX(a, b, c)
	return 0;
end

kaiNoKoshikiBoth(1, -4, 4);
kaiNoKoshikiBoth(1, 1.000000000012345, 0.000000000012345);
kaiNoKoshikiBoth(1, 1.000000000002003, 0.000000000002003);
kaiNoKoshikiBoth(1, 1.000000000000001, 0.000000000000001);
