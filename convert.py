import struct

chunksize = 256

# roughly based on https://github.com/microsoft/uf2
magicStart0 = 0x0A324655
magicStart1 = 0x9E5D5157
flags = 0x00002000 # use familyID
XIPStart = 0x10000000 # starting base address
familyID = 0xe48bff59  # see https://github.com/microsoft/uf2/blob/70fdee51cf15a487526e88ada2d52346596f80af/utils/uf2families.json#L283
magicEnd = 0x0AB16F30

with open("blink.bin", "rb") as f:
    content = f.read()

blocks = [content[i: i + chunksize] for i in range(0, len(content),  chunksize)]
with open("blink.uf2", "wb") as f:
    for idx, block in enumerate(blocks):
        addr = XIPStart + idx * chunksize
        hdr = struct.pack("<IIIIIIII476sI",
                          magicStart0,
                          magicStart1,
                          flags,
                          addr,
                          chunksize,
                          idx,
                          len(blocks),
                          familyID,
                          block.ljust(476, b"\x00"),
                          magicEnd)
        f.write(hdr)
