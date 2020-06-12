pragma solidity ^0.4.0;

contract GuardaLoteria {
    uint16 numeroSorteado; // 0 a 65535
    uint256 numeroSorteadoGrande; // 0 a 2^256

    uint16 contadorDeSorteios;

    address dono;

    constructor(uint16 _numeroInicial) public {
        numeroSorteado = _numeroInicial;
        contadorDeSorteios = 65530;
        dono = msg.sender;
    }

    function set(uint256 enviado) public payable {
        numeroSorteadoGrande = enviado;
        numeroSorteado = uint16(enviado);

        require(msg.sender == dono, "apenas o dono do contrato pode setar");

        require(
            contadorDeSorteios + 1 > contadorDeSorteios,
            "overflow no contador"
        );
        require(numeroSorteado == numeroSorteadoGrande, "overflow no número");

        contadorDeSorteios++;
    }

    function get()
        public
        view
        returns (
            uint256 _numero,
            uint256 _numeroSorteadoGrande,
            uint16 _contador,
            address _dono,
            address _contrato,
            uint256 _saldo
        )
    {
        return (
            numeroSorteado,
            numeroSorteadoGrande,
            contadorDeSorteios,
            dono,
            this,
            address(this).balance
        );
    }
}
