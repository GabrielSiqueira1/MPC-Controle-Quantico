# MPC-Quantum-Computing
Esse projeto usa MPC (Modelo de controle preditivo) juntamente com o controle quântico para manipulação da função de onda apresentada na equação de Schrodinger, a base para mecânica quântica

Para realizar tal procedimento, é utilizado a linguagem Python no projeto Jupyter. 

---

## Atividade 1

### Projeção das soluções

O objetivo dessa atividade é desenvolver gráficos referentes a solução da equação de Schrodinger e em um primeiro momento foi desenvolvido para a solução usando polinômios de Hermite.

Para que seja possível utilizar tal solução, considerou-se um sistema massa mola, ou seja, um oscilador harmônico simples $V(x)=m\cdot\omega^{2}\cdot x²/2$

No vídeo abaixo é apresentado a solução para os polinômios 0 e 1 e o seu movimento quando passado pela origem, sua complementação está disposto no projeto .ipynb.

https://user-images.githubusercontent.com/109818266/188509783-cb8ce10f-77d1-4572-be23-0fba1809ef43.mp4

Afim de mostrar a transação entre os polinômios de Hermite, construiu-se o gráfico em vermelho, mostrando todas as posições até o polinômio de grau 50.

https://user-images.githubusercontent.com/109818266/188509566-a4458cfe-09ef-4c11-b1f2-901f2807c246.mp4

Para análise completa, recomenda-se visitar o projeto .ipynb.

### Método de Crank-Nicolson
