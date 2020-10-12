# Cryptopals helpers.py

https://raw.githubusercontent.com/ickerwx/cryptopals/master/helpers.py

```python
#!/usr/bin/env python
from Crypto.Cipher import AES
import random
import struct


def toByteList(text):
    """
    Take a string of hexadecimal characters and return a list of bytes, using
    two characters per byte.

    @type   text:   str
    @param  text:   A string contsisting of the characters 0-9, a-f, A-F

    @rtype:         list
    @return:        A list containing positive integers ranging from 0 to 255
    """
    return [ord(c) for c in text.decode('hex')]


def xor(data, key):
    """
    Multi-byte XOR, rotating over the key

    @type   data:   list
    @param  data:   A list of bytes, the cleartext
    @type   key:    list
    @param  key:    A list of bytes, the key

    @rtype:         list
    @return:        A list of bytes, the ciphertext
    """
    result = []
    for i in xrange(len(data)):
        result.append((data[i] & 0xff) ^ (key[i % len(key)] & 0xff))
    return result


def toHexString(byteList):
    """
    Convert a list of bytes to a hexadecimal string.

    @type   byteList:   list
    @param  byteList:   A list of decimal bytes

    @rtype:             str
    @return:            A string consisting of hexadecimal characters
    """
    return "".join([hex(x)[2:] if x > 15 else '0' + hex(x)[2:]
                    for x in byteList])


def textToHexString(text):
    """
    Convert any given string into its hex equivalent. The string AAAA will be
    converted to 41414141. Python actually knows encode('hex'), which will do
    the same.

    @type   text:   str
    @param  text:   the string that should be converted

    @rtype:         str
    @return:        A string consisting of hexadecimal characters
    """
    return text.encode('hex')


def textToByteList(text):
    """
    Convert any given string into its byte list equivalent. The string AAAA
    will be converted to [65, 65, 65, 65].

    @type   text:   str
    @param  text:   the string that should be converted

    @rtype:         list
    @return:        A list containing positive integers ranging from 0 to 255
    """
    return toByteList(textToHexString(text))


def chunks(buffer, n=16):
    """
    Yield successive n-sized chunks from buffer.

    Taken from http://stackoverflow.com/questions/312443/
                    how-do-you-split-a-list-into-evenly-sized-chunks-in-python
    """
    for i in xrange(0, len(buffer), n):
        yield buffer[i:i + n]


def hexToText(text):
    return str(bytearray(toByteList(text)))


def bytesToText(bytes):
    return hexToText(toHexString(bytes))


def pkcs7Padding(data, blocklen=16):
    """
    Apply PKCS7 padding to data so that len(data) is a multiple of blocklen
    """
    if len(data) % blocklen != 0:
        diff = blocklen - len(data) % blocklen
        data.extend([diff] * diff)
    else:
        data.extend([blocklen] * blocklen)
    return data


def checkPkcs7Padding(data):
    padding = data[-1]  # get the last item
    if data[-padding:].count(padding) == padding:   # check if the last p items
                                                    # all equal p
        return True
    else:
        raise ValueError('No valid PKCS7 padding found!')


def removePkcs7Padding(data):
    padding = data[-1]
    if checkPkcs7Padding(data):
        return data[:-padding]


def encryptECB(plain, key):
    """
    Encrypt the plaintext block (16 bytes) with key, using AES in ECB mode

    @type  plain: list
    @param plain: The plaintext
    @type  key:   list
    @param key:   The key to use

    @rtype:   list
    @return:  a list with the encrypted bytes (ciphertext)
    """
    aes = AES.new(bytesToText(key))
    # print 'Blocksize of helper object: %d' % aes.block_size
    return textToByteList(aes.encrypt(bytesToText(plain[:])))


def encryptCBC(plain, key, iv, blocksize=16):
    """
    Encrypt a plaintext block with key, using AES in CBC mode

    @type  plain: list
    @param plain: The plaintext
    @type  key:   list
    @param key:   The key
    @type  iv:    list
    @param iv:    The IV or previous ciphertext

    @rtype:       list
    @return:      a list with the encrypted bytes (ciphertext)
    """
    ciphertext = []
    for block in chunks(plain, blocksize):
        xored = xor(block, iv)
        iv = encryptECB(xored, key)
        ciphertext.extend(iv)
    return ciphertext


def decryptECB(cipher, key):
    """
    Decrypt the ciphertext block (16 bytes) with key, using AES in ECB mode

    @type  cipher: list
    @param cipher: The plaintext
    @type  key:    list
    @param key:    The key to use

    @rtype:        list
    @return:       a list with the decrypted bytes (plaintext)
    """
    aes = AES.new(bytesToText(key), AES.MODE_ECB)
    return textToByteList(aes.decrypt(bytesToText(cipher)))


def decryptCBC(cipher, key, iv, blocksize=16):
    """
    Decrypt a ciphertext block with key, using AES in CBC mode

    @type  cipher: list
    @param cipher: The plaintext
    @type  key:    list
    @param key:    The key
    @type  iv:     list
    @param iv:     The IV or previous ciphertext

    @rtype:        list
    @return:       a list with the decrypted bytes (plaintext)
    """
    plaintext = []
    for c in chunks(cipher, blocksize):
        xored = xor(decryptECB(c, key), iv)
        iv = c
        plaintext.extend(xored)
    return plaintext


def generateRandomData(len=16):
    key = []
    for i in xrange(len):
        key.append(random.randint(0, 255))
    return key


def verifyECB(ciphertext, blocksize):
    ctblocks = [b for b in chunks(ciphertext, blocksize)]
    detected = []
    for b in ctblocks:
        if ctblocks.count(b) > 1:
            detected.append(b)
    if detected:
        return True
    return False


class MersenneTwister():
    def _int32(self, i):
        return int(i & 0xffffffff)

    def setup_constants(self):
        self.n = 624
        self.m = 397
        self.upper_mask = 0x80000000
        self.lower_mask = 0x7fffffff
        self.matrix_a = 0x9908b0df
        self.mt = [0] * self.n
        self.mti = self.n + 1

    def __init__(self, seed):
        self.setup_constants()
        self.mt[0] = self._int32(seed)
        for self.mti in xrange(1, self.n):
            self.mt[self.mti] = self._int32(
                1812433253 *
                (self.mt[self.mti - 1] ^ (self.mt[self.mti - 1] >> 30)) +
                self.mti
            )
        self.mti += 1

    def random(self):
        mag01 = [0, self.matrix_a]
        y = 0
        kk = 0
        if self.mti >= self.n:
            while kk < self.n - self.m:
                y = self._int32((self.mt[kk] & self.upper_mask) |
                                (self.mt[kk + 1] & self.lower_mask))
                self.mt[kk] = self._int32(self.mt[kk + self.m] ^ (y >> 1) ^ mag01[y & 1])
                kk += 1
            while kk < self.n - 1:
                y = self._int32((self.mt[kk] & self.upper_mask) |
                                (self.mt[kk + 1] & self.lower_mask))
                self.mt[kk] = self._int32(self.mt[kk + (self.m - self.n)] ^ (y >> 1) ^
                                          mag01[y & 1])
                kk += 1
            y = (self.mt[self.n - 1] & self.upper_mask) | \
                (self.mt[0] & self.lower_mask)
            self.mt[self.n - 1] = self.mt[self.m - 1] ^ (y >> 1) ^ mag01[y & 1]
            self.mti = 0

        y = self.mt[self.mti]
        self.mti += 1

        y ^= (y >> 11)
        y ^= (y << 7) & 0x9d2c5680
        y ^= (y << 15) & 0xefc60000
        y ^= (y >> 18)
        return self._int32(y)


class AESCTR(object):
    """implement AES-CTR stream cipher mode"""

    def __init__(self, key, nonce):
        self.key = key
        self.nonce = nonce
        self.counter = 0
        self.keystream = self._generateKeyStream(self.counter)
        self.keyBytes = []

    def _generateKeyStream(self, counter):
        bytes = encryptECB(textToByteList(struct.pack('<QQ', self.nonce, self.counter)), self.key)
        bytes.reverse()  # reverse() so we can use the pop() method
        return bytes

    def nextKeyByte(self):
        if len(self.keystream) == 0:
                self.counter += 1
                self.keystream = self._generateKeyStream(self.counter)
        b = self.keystream.pop()
        self.keyBytes.append(b)
        return b

    def encrypt(self, plaintext):
        ciphertext = []
        for byte in plaintext:
            keybyte = self.nextKeyByte()
            ciphertext.append(byte ^ keybyte)
        return ciphertext

    def decrypt(self, ciphertext):
        return self.encrypt(ciphertext)

    def reset(self):
        self.counter = 0
        self.keystream = self._generateKeyStream(self.counter)
```

tags: #python #cryptopals 
