// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title KipuBank
 * @notice Bóveda personal de ETH con límite global de depósitos y límite por retiro.
 * @dev Construido con fundamentos de Solidity: variables, mapping, eventos, errores, constructor, modificador y funciones básicas.
 */
contract KipuBank {
    // ============================
    // Errores personalizados
    // ============================
    error MontoCero();
    error SobreLimiteBanco(uint256 solicitado, uint256 disponible);
    error ExcedeSaldo(uint256 solicitado, uint256 saldo);
    error ExcedeLimitePorTx(uint256 solicitado, uint256 limite);
    error TransferenciaFallida();

    // ============================
    // Parámetros sugeridos para despliegue:
    // bankCap = 50 ether
    // limiteRetiroPorTx = 0.5 ether
    // ============================

    // Variables inmutables
    uint256 public immutable bankCap;
    uint256 public immutable limiteRetiroPorTx;

    // Variables de almacenamiento
    mapping(address => uint256) private balances;
    uint256 public depositos;
    uint256 public retiros;
    uint256 public totalBanco;

    // Eventos
    event Deposito(address indexed usuario, uint256 monto, uint256 nuevoSaldo);
    event Retiro(address indexed usuario, uint256 monto, uint256 saldoRestante);

    // Modificador
    modifier montoNoCero(uint256 monto) {
        if (monto == 0) revert MontoCero();
        _;
    }

    // Constructor
    constructor(uint256 _bankCap , uint256 _limiteRetiroPorTx) {
        bankCap = _bankCap;
        limiteRetiroPorTx = _limiteRetiroPorTx;
    }

    // Función external payable: depósito
    function depositar() external payable {
        if (msg.value == 0) revert MontoCero();
        uint256 capacidadRestante = bankCap - totalBanco;
        if (msg.value > capacidadRestante) revert SobreLimiteBanco(msg.value, capacidadRestante);

        balances[msg.sender] += msg.value;
        totalBanco += msg.value;
        depositos++;

        emit Deposito(msg.sender, msg.value, balances[msg.sender]);
    }

    // Función external: retiro
    function retirar(uint256 monto) external montoNoCero(monto) {
        uint256 saldo = balances[msg.sender];
        if (monto > saldo) revert ExcedeSaldo(monto, saldo);
        if (monto > limiteRetiroPorTx) revert ExcedeLimitePorTx(monto, limiteRetiroPorTx);

        balances[msg.sender] = saldo - monto;
        totalBanco -= monto;
        retiros++;

        _transferir(msg.sender, monto);

        emit Retiro(msg.sender, monto, balances[msg.sender]);
    }

    // Función external view: consultar saldo
    function saldoDe(address usuario) external view returns (uint256) {
        return balances[usuario];
    }

    // Función external view: estadísticas
    function estadisticasBanco() external view returns (uint256, uint256, uint256) {
        return (depositos, retiros, totalBanco);
    }

    // Función privada: transferencia nativa
    function _transferir(address to, uint256 monto) private {
        (bool ok, ) = to.call{value: monto}("");
        if (!ok) revert TransferenciaFallida();
    }
}
