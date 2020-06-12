pragma solidity ^0.4.0;

contract GuardaLoteria {
    address dono;

    struct Sorteio {
        uint256 data;
        uint256 numeroSorteado;
        address remetente;
    }

    Sorteio[] sorteios;

    constructor(uint256 numeroInicial) public {
        dono = msg.sender;
        set(numeroInicial);
    }

    function set(uint256 enviado) public {
        sorteios.push(
            Sorteio({data: now, numeroSorteado: enviado, remetente: msg.sender})
        );
    }

    function get()
        public
        view
        returns (
            address _donoDoContrato,
            uint256 _ultimoSorteado,
            uint256 _ultimoData,
            address _ultimoRemetente,
            uint256 _saldoUltimoRemetente,
            uint256 _numeroDeSorteios
        )
    {
        Sorteio memory ultimo = sorteios[sorteios.length - 1]; // esse memory é um modificador que diz que essa variavel não vai ser armazenada na blockchain

        return (
            dono,
            ultimo.numeroSorteado,
            ultimo.data,
            ultimo.remetente,
            ultimo.remetente.balance,
            sorteios.length
        );
    }

    function kill() public {
        require(msg.sender == dono, "Somente o dono do contrato pode encerrar");
        selfdestruct(dono);
    }
}
