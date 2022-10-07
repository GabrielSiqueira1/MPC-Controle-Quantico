## Atividade 1

Nessa atividade estudaremos a representação de sistemas quânticos por meio da equação de Schrödinger, apresentada abaixo, e sua solução para alguns casos de potenciais simples, como o poço quadrado infinito e o oscilador harmonico simples, este que nos seguirá por toda a pesquisa.

$$i\hbar\cdot\frac{\partial\psi}{\partial t} = \frac{\hbar^{2}}{2m}\cdot\frac{\partial^{2}\psi}{\partial x^{2}}+V(x,t)\psi(x,t)$$

A solução apresentada no artigo do Dr. Hashimoto é para o sistema do poço quadrado infinito e é suficiente para entender o processo de discretização e obtenção do resultado. Utilizando o livro base da Mecânica Quântica, por David Griffiths, utilizaremos a resposta para o oscilador harmônico juntamente dos polinômios de Hermite para modelar sua reposta analítica e usar o artigo para discretizar para o sistema OHS, portanto:

$$V(x) = 0.5mw^{2}x^{2}$$

$$\psi_n(x) = \left(\frac{m\omega}{\pi\hbar}\right)^{1/4}\cdot H_n(x)\cdot \frac{1}{\sqrt{2^nn!}}e^{0.5x^2}$$

Para modelar utilizou-se a linguagem python na plataforma jupyter e nesse primeiro momento apresenta-se a resposta analítca. Além disso, supunhou-se que $\omega = \pi$, $\hbar = 1$ e $m = 1$.

-----
Resultados no espaço
----

De acordo com a teoria proposta para a equação de Schrödinger, a solução para a equação pode ser determinada pela combinação linear de cada $\psi_n(x)$ para todo n pertencente aos naturais. Neste trabalho combinaremos a respostas em 0 e 1 com o valor constante de 0.80 e 0.60 suficiente para que a soma de seus quadrados dê 1. Abaixo estão as curvas com o polinômios de Hermite para graus maiores que 1.

<div align="center"> 
  <img src="griffiths.png" />
  <img src="curvas.png" />
  <img src="curvas2.gif" />
</div>

E a combinação está representada abaixo:

<div align="center">
  <img src="curvas3.gif" />
</div>

----
Resultados no tempo
----

Para concretizar e observar o resultado analítico devemos multiplicar por $e^{-i(n+1/2)\omega t}$ ambos os $\psi$'s com a mesma combinação, 0.80 e 0.60 e a resposta analítica pode ser observada abaixo.

<div align="center">
  <img src="analiticalAnswer.gif" />
</div>

## Atividade 2

Para a segunda atividade foi necessário entender de que forma poderia se aproximar as derivadas para facilitar a sua utilização em laboratórios de controle. Para realizar essa tarefa, utilizou-se a aproximação pelo métodod e Crank-Nicolson do qual está demonstrado em arquivo pdf nesse repositório. Nesse método ocorre uma aproximação por diferenças, especificamente uma média entre a aproximação posterior e anterior de um ponto relacionado. Abaixo está um gráfico comparativo além da representação dos erros absolutos e relativos.

<img src="comparative.gif" />

Uma visualização em três dimensões obsevando a aproximação do resultado exato.

<img src="errors.png" />

## Atividade 3

Para essa etapa vamos arbitrar um valor para o potencial de forma que ele seja capaz de transformar a resposta sem alterar as constantes que o regem. Perceba que isso é um teste que utilizará o método MPC de modo a minimizar os erros entre a curva atual e a ideal no fim realizando uma acumulação.

$$V(x,t) = 0.5mw^{2}x^{2} + u(t)$$

E o objetivo é:

$$\Psi(x,0) = \Psi_0(x) -> MPC -> \Psi_d(x,t)=1/\sqrt 2(\psi_0(x)e^{-iwt/2}+\psi_1(x)e^{-3iwt/2})$$

De modo que:

$$E = \sum_{n = p}^{p+N_h}|\Psi_d(x,t) - \Psi_{i}^{n(u(t))}|^{2}$$

Onde a cada iteração, descobriremos qual é o melhor valor para u(t) por meio de uma otimização não linear regida pela restrição da equação de Schrödinger. P, indicado pelo somatório é o ponto de partida para a resposta otimizada, e nesse começo, utilizaremos o ponto de partida do trabalho com as constates 0.80 e 0.60. 

A cada extrapolação em 3 tempos otimizados, utilizaremos o tempo inicial otimizado para compor a resposta otimizada do sistema. E assim será realizado a cada 3 tempos. A linha de raciocínio do programa que será utilizado se da abaixo:

1. $\Psi_d(x,t) = 1/\sqrt 2(\psi_0(x)e^{-iwt/2}+\psi_1(x)e^{-3iwt/2})$
2. Definimos o ponto de partida $\psi_c(x,0) = 0.80\cdot\psi_0(x,0)+0.60\cdot\psi_1(x,1)$
3. Somente a multiplicação da inversa de A com B
4. Matriz $A^{-1}$, B previamente criadas e multiplicadas entre si, além da multiplicação por $u^{2}$
> x varia -5 até 5 com 1000 pontos, o tempo varia de 0 a 10 com 1000 pontos e u varia de -5 a 5 com 1000 pontos
>
> Utilizando Crank-Nicolson (Passagem de parâmetro: $\psi_c(x,0)$, matrizDoPonto4, xs, ts, us):
- Utiliza-se o for já estabelecido em procedimentos anteriores. Esse for irá calcular o valor de $\psi_{i+1}$ utilizando o valor de $\psi_i$
> Retorna o $\Psi_c(x,t)$ alterado pelas multiplicações das matrizes
5. Em um looping de 10 segundos têm-se: 
6. Utilizaremos o método gradiente, na função $\Psi_d(x,t) - \Psi_c(x,t)$, especificado pelo professor Rodrigo Cardoso, propondo um ponto inicial em todo domínio real e ainda utilizando como condição de parada o valor do gradiente. Usaremos o passo de 0,01 para encontrar o valor de mínimo.
> Para o método MPC, iremos realizar o método gradiente cinco vezes
7. Com o minimo obtido, substituiremos em $\Psi_{i+1} = (matrizDoPonto3 \cdot mínimo[i])\cdot \Psi_{i}$
8. O $\Psi_{i+1}$ se torna o novo $\Psi_c$
9. Neste ponto passaram-se 0,01 segundos do looping e novamente há uma otimização até alcançar 10 segundos.

Pseudocodigo:

```
# Ondas iniciais
psidxt ← 1/sqrt(2) * (psi(x,0) * e^(-iwt/2) + psi(x,1) * e^(-3iwt/2))
psicx ← 0.80 * psi(x,0) * 0.60 * psi(x,1)

# Espaço de pesquisa
ts ← de 0 a 10 com 1000 pontos
xs ← de -5 a 5 com 1000 pontos
us ← de -5 a 5 com 1000 pontos

P ← 3.141111111111111111111111111
#Discretização espacial
dx ← 10/(P*M-1) 

#Discretização temporal
dt ← 5/(P*N-1)

# Produção das matrizes
a ← hbar/(4*m*dx**2) 
b ← 1j*hbar/dt - 2*a - 1/2*V
c ← 1j*hbar/dt + 2*a + 1/2*V
matrizA ← (1000x1000) 
matrizB ← (1000x1000)

matrizResultado1 ← matrizA^-1 * matrizB
funcao matrizAdicional(u):
  matrizResultado2 ← (matrizA^-1 * matrizB) + diagonal(u^2)

#Aproximação

funcao acumula:
  enquanto (i < 1000)
    psi_i+1 ← matrizResultado2 * psi_i
  fim do enquanto
  
enquanto mpc < 10:
  # Método do gradiente
  x0 ← -4 {ponto inicial}
  x∗ {solução encontrada}
  
  defina kmax; k ← 1; x ← x0
  enquanto (k < kmax)
    d ← - gradiente(x)
    α ← unidimensional(x, d)
    x ← x + α × d
    k ← k + 1
  fim enquanto
  x∗ ← x
  fim algoritmo
  
  
  
```
