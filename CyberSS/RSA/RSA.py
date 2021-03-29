def rsa_algo(p: int,q: int, msg: str):
    # n = pq
    n = p * q
    # z = (p-1)(q-1)
    z = (p-1)*(q-1)

    # e -> gcd(e,z)==1      ; 1 < e < z
    # d -> ed = 1(mod z)        ; 1 < d < z
    e = find_e(z)
    d = find_d(e, z)

    # Convert Plain Text -> Cypher Text
    cypher_text = ''
    # C = (P ^ e) % n
    for ch in msg:
        # convert the Character to ascii (ord)
        ch = ord(ch)
        # encrypt the char and add to cypher text
        # convert the calculated value to Characters(chr)
        cypher_text += chr((ch ** e) % n)

    # Convert Plain Text -> Cypher Text
    plain_text = ''
    # P = (C ^ d) % n
    for ch in cypher_text:
        # convert it to ascii
        ch = ord(ch)
        # decrypt the char and add to plain text
        # convert the calculated value to Characters(chr)
        plain_text += chr((ch ** d) % n)

    return cypher_text, plain_text

def find_e(z: int):
    # e -> gcd(e,z)==1      ; 1 < e < z
    e = 2
    while e < z:
        # check if this is the required `e` value
        if gcd(e, z)==1:
            return e
        # else : increment and continue
        e += 1

def find_d(e: int, z: int):
    # d -> ed = 1(mod z)        ; 1 < d < z
    d = 2
    while d < z:
        # check if this is the required `d` value
        if ((d*e) % z)==1:
            return d
        # else : increment and continue
        d += 1

def gcd(x: int, y: int):
    # GCD by Euclidean method
    small,large = (x,y) if x<y else (y,x)

    while small != 0:
        temp = large % small
        large = small
        small = temp

    return large


#main
if __name__ == "__main__":
    p,q = map(int, input().split())
    msg = input()

    cypher_text, plain_text = rsa_algo(p, q, msg)

    print("Encrypted (Cypher text) : ", cypher_text)
    print("Decrypted (Plain text) : ", plain_text)
