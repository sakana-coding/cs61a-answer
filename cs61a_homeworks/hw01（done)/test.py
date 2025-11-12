def fib(n):
    pre=0
    curr=1
    k=1
    while k<n:
        pre,curr=curr,pre+curr

        k+=1
    return curr
print(fib(7))