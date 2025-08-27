import BigInt

class GetBalanceJsonRpc: JsonRpc<BigUInt> {
    init(address: Address, defaultBlockParameter: DefaultBlockParameter) {
        print("eth_getBalance: \(address.hex)")
        super.init(
            method: "eth_getBalance",
            params: [address.hex, defaultBlockParameter.raw]
        )
    }

    override func parse(result: Any) throws -> BigUInt {
        guard let hexString = result as? String, let value = BigUInt(hexString.hs.stripHexPrefix(), radix: 16) else {
            throw JsonRpcResponse.ResponseError.invalidResult(value: result)
        }
        print("got response: \(hexString)")

        return value
    }
}
