## Esquema do Banco de Dados: Oficina Mecânica

Este banco de dados foi projetado para gerenciar os diversos processos e informações de uma oficina mecânica, incluindo dados de clientes, veículos, mecânicos, equipes de trabalho, ordens de serviço, custos, peças e serviços disponíveis. Ele é estruturado para garantir a integridade dos dados, a escalabilidade e a fácil execução de consultas. Abaixo está um resumo de cada componente do esquema:

### Estrutura Geral:
- **Mecânicos (`mecanics`)**: Contém informações sobre os mecânicos, incluindo nome, especialidade, endereço, CPF e CEP. Um mecânico pode pertencer a uma ou mais equipes de trabalho.
  
- **Equipes de Trabalho (`working_team`)**: Representa grupos de mecânicos que executam serviços. Cada equipe está associada a um tipo de serviço (manutenção, reparo ou inspeção) e possui uma data de entrega esperada.

- **Clientes (`clients`)**: Registra dados dos clientes, como nome, endereço, CEP, CPF e número de contato. Cada cliente pode ter um ou mais veículos registrados e ordens de serviço associadas.

- **Veículos (`vehicle`)**: Armazena informações sobre os veículos dos clientes, incluindo a placa, modelo e uma ligação com o proprietário (cliente).

- **Ordens de Serviço (`service_order`)**: Gere pedidos para serviços realizados, armazenando informações como data de emissão, valor total, status (pendente, em andamento, concluído), data de conclusão e cliente associado.

- **Custos de Mão de Obra (`labor_cost`)**: Armazena descrições e valores de custos de mão de obra associados às ordens de serviço.

- **Custos de Peças (`parts_cost`)**: Contém informações sobre as peças utilizadas nos serviços, como descrição e valor unitário.

- **Serviços Disponíveis (`available_services`)**: Representa os serviços que a oficina oferece, incluindo nome e descrição.

### Relacionamentos:
- **`mecanics_in_team`**: Relaciona mecânicos a equipes de trabalho.
- **`working_team_vs_os`**: Liga equipes de trabalho a ordens de serviço.
- **`labor_cost_vs_os`**: Relaciona custos de mão de obra às ordens de serviço.
- **`parts_vs_os`**: Associa custos de peças às ordens de serviço e registra a quantidade de peças utilizadas.
- **`services_vs_os`**: Vincula serviços disponíveis às ordens de serviço.

### Destaques:
- A estrutura usa **chaves primárias e estrangeiras** para garantir consistência referencial.
- Suporta **atributos derivados**, como o cálculo do custo total (peças + mão de obra) para cada ordem.
- As tabelas estão otimizadas para **consultas complexas**, permitindo junções e agrupamentos para análises detalhadas.

Este esquema é ideal para simular cenários reais em uma oficina mecânica, servindo tanto para práticas educacionais quanto para protótipos de sistemas. O banco de dados foi populado com dados fictícios, garantindo uma base sólida para consultas e exercícios. 🚗🔧
