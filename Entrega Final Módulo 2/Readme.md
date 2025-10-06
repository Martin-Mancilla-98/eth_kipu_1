Está pensado como un banco básico en la blockchain: podés depositar fondos, retirarlos con un límite por transacción, y el contrato mantiene un tope global de depósitos.
---

## ¿Qué hace este contrato?

- Cada usuario puede **depositar ETH** en su bóveda personal.
- Puede **retirar ETH**, pero con un **límite fijo por transacción**.
- El contrato tiene un **límite global de depósitos** (`bankCap`) que no se puede superar.
- Se lleva registro de la cantidad de **depósitos y retiros** realizados.
- Se emiten **eventos** cada vez que alguien deposita o retira.
---

## ¿Cómo desplegarlo?

Podés usar Remix y MetaMask para desplegarlo en la testnet Sepolia.

1. Abrí [Remix](https://remix.ethereum.org/) en el navegador.
2. Creá un archivo llamado `KipuBank.sol` y pegá el código del contrato.
3. Compilalo con la versión de Solidity 0.8.24
4. Conectá MetaMask a la red Sepolia y asegurate de tener algo de ETH de faucet.
5. En la pestaña “Deploy & Run”, seleccioná “Injected Provider – MetaMask”.
6. Ingresá los parámetros del constructor:
   - `bankCap`: por ejemplo `50 ether`
   - `limiteRetiroPorTx`: por ejemplo `0.5 ether`
7. Hacé clic en “Deploy” 

---

## ¿Cómo se usa?

Una vez desplegado, podés interactuar con el contrato desde Remix:

- **Depositar ETH**  
  Llamá a la función `depositar()` y en el campo “Value” poné el monto que querés depositar (por ejemplo `0.1 ether`).

- **Retirar ETH**  
  Llamá a `retirar(monto)` pasando el monto en wei (por ejemplo `50000000000000000` para 0.05 ether).  
  Acordate que el monto debe ser menor o igual a tu saldo y al límite por transacción.

- **Consultar saldo**  
  Usá `saldoDe(direccion)` para ver cuánto tiene una cuenta en su bóveda.

- **Ver estadísticas del banco**  
  Llamá a `estadisticasBanco()` para ver cuántos depósitos y retiros hubo, y cuánto ETH hay en total.

---

## Dirección del contrato desplegado

- **Red: Sepolia  
- Dirección:0xe4De0D7995D0E307Da31F3f020B8C2C7D255db6a

deploy :https://sepolia.etherscan.io/tx/0x6999b0cd5c3667f01f1df4c59504d8b537703675852394c0a0299f5e9773282e
depositar:https://sepolia.etherscan.io/tx/0xe6784ac21b22ce7a538a18d64e701999c2d91b47ec5dc15ad5bf4acb70c34d2a
retirar:https://sepolia.etherscan.io/tx/0x2e41282ee49b6272390b1b0392853b7ea26c2690b73f70addb22e1d76b2ab65a
---
