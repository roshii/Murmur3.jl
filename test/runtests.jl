using Murmur3, Test, JSON

# Test JSON hash examples
f = open(joinpath(dirname(@__FILE__()), "tests.json"))
tests = JSON.parse(f)
close(f)

for test in tests

    if "seed" in keys(test)
        x86_32 = lpad(string(Murmur3.x86.hash32(test["text"], test["seed"]), base=16), 8, "0")
        # x86_128 = lpad(string(Murmur3.x86.hash128(test["text"], test["seed"]), base=16), 32, "0")
        # x64_128 = lpad(string(Murmur3.x64.hash128(test["text"], test["seed"]), base=16), 32, "0")
    else
        x86_32 = lpad(string(Murmur3.x86.hash32(test["text"]), base=16), 8, "0")
        # x86_128 = lpad(string(Murmur3.x86.hash128(test["text"]), base=16), 32, "0")
        # x64_128 = lpad(string(Murmur3.x64.hash128(test["text"]), base=16), 32, "0")
    end

    @test test["x86_32"] == x86_32
    # @test test["x86_128"] == x86_128
    # @test test["x64_128"] == x64_128

end

# Test multiple dispatch
@test Murmur3.x86.hash32(UInt8[1, 2, 3], 5) == UInt32(0x4c298f63)
@test Murmur3.x86.hash32(UInt8[1, 2, 3]) == UInt32(0x80d1d204)
@test Murmur3.x86.hash32("Test", UInt32(5)) == UInt32(0x578de544)
@test Murmur3.x86.hash32("Test", 5) == UInt32(0x578de544)
@test Murmur3.x86.hash32("Test") == UInt32(0x07556ca6)

# @test Murmur3.x86.hash128(UInt8[1, 2, 3], 5) == UInt128(0x5c845b3cf61b38eef61b38eef61b38ee)
# @test Murmur3.x86.hash128(UInt8[1, 2, 3]) == UInt128(0xf60164e1b5134233b5134233b5134233)
# @test Murmur3.x86.hash128("Test", UInt32(5)) == UInt128(0xfca9493ccf980d40cf980d40cf980d40)
# @test Murmur3.x86.hash128("Test", 5) == UInt128(0xfca9493ccf980d40cf980d40cf980d40)
# @test Murmur3.x86.hash128("Test") == UInt128(0x1bccc51416e53d6c16e53d6c16e53d6c)
#
# @test Murmur3.x64.hash128(UInt8[1, 2, 3], 5) == UInt128(0x88451581d843d60150f5d4a75a40b6c2)
# @test Murmur3.x64.hash128(UInt8[1, 2, 3]) == UInt128(0x0e1337a91a643eef3c239a65494e4a40)
# @test Murmur3.x64.hash128("Test", UInt64(5)) == UInt128(0x536b3b8cfcdf124c3ea8439527849576)
# @test Murmur3.x64.hash128("Test", 5) == UInt128(0x536b3b8cfcdf124c3ea8439527849576)
# @test Murmur3.x64.hash128("Test") == UInt128(0x9eac3743ee31bc6fbf2185a737a1b11a)
