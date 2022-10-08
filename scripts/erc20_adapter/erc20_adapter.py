from scripts import ERC20Adapter as Contract
from scripts.utils.context import Context
from scripts.erc165.erc165 import ERC165


class ERC20Adapter(Context, ERC165):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def init(
        self,
        id: int,
        name: str,
        symbol: str,
        decimals: int,
        sender: any,
    ):
        tx = self.contract().init(
            id,
            name,
            symbol,
            decimals,
            {"from": sender},
        )
        return tx.return_value

    def contract(self) -> any:
        return self.__contract

    def entity(self) -> any:
        return self.contract().entity()

    def id(self) -> int:
        return self.contract().id()

    def name(self) -> str:
        return self.contract().name()

    def symbol(self) -> str:
        return self.contract().symbol()

    def decimals(self) -> int:
        return self.contract().decimals()

    def getOwner(self) -> any:
        return self.contract().getOwner()

    def totalSupply(self) -> int:
        return self.contract().totalSupply()

    def balanceOf(self, acconut: any) -> int:
        return self.contract().balanceOf(acconut)

    def allowance(self, owner: any, spender: any) -> int:
        return self.contract().allowance(owner, spender)

    def approve(
        self,
        spender: any,
        amount: int,
        sender: any,
    ) -> bool:
        tx = self.contract().approve(
            spender,
            amount,
            {"from": sender},
        )
        return tx.return_value

    def increaseAllowance(
        self,
        spender: any,
        value: int,
        sender: any,
    ) -> bool:
        tx = self.contract().increaseAllowance(
            spender,
            value,
            {"from": sender},
        )
        return tx.return_value

    def decreaseAllowance(
        self,
        spender: any,
        value: int,
        sender: any,
    ) -> bool:
        tx = self.contract().decreaseAllowance(
            spender,
            value,
            {"from": sender},
        )
        return tx.return_value

    def transfer(
        self,
        to: any,
        amount: int,
        sender: any,
    ) -> bool:
        tx = self.contract().transfer(
            to,
            amount,
            {"from": sender},
        )
        return tx.return_value

    def transferFrom(
        self,
        origin: any,
        to: any,
        amount: int,
        sender: any,
    ) -> int:
        tx = self.contract().transferFrom(
            origin,
            to,
            amount,
            {"from": sender},
        )
        return tx.return_value
