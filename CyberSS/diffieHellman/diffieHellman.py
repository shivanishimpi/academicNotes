def tempFunc(x,y,z):
    return (x**y)%z

def diffieHellman(P,G,a,b):
    x = int(tempFunc(G,a,P)) 
    y = int(tempFunc(G,b,P)) 
    ka = int(tempFunc(y,a,P))
    kb = int(tempFunc(x,b,P))
    return ka, kb


privKey1 = 4
privKey2 = 3

print(f'Secret Keys for privateKeys ({privKey1},{privKey2}) = {diffieHellman(23,9,privKey1,privKey2)}')
