/*
	Se em uma divisão de trabalho entre threads existe o compartilhamento de variável, ou seja, as threads tem acesso a uma mesma posição de memória pode
	ocorrer a *Condição de corrida* que é uma situação a qual duas threads alteram a mesma posição de memória. (Interferência de threads)

	Todo object é um monitor, logo todo objeto possui um monitor.


	Região crítica é o local de compartilhamento de variável 

	Custos de sincronização: 
		1- Overhead: custo de tornar o método sycronized, pois as operações de load and store passam a ser mais lentas
		por conta de outras operações que precisam ser feitas para garantir as peculiaridades de ser sincronized
		2- Transformar um método em sincronized faz com que as threads a implementem de forma sequencial (FIFO) 
		as threads ponham essa execução em uma fila, logo a execução torna-se parcialmente sequencial
*/

		class Node {
		int value;
		Node left;
		Node right;

			public Node(int val, Node dir, Node esq){
				value = val;
				right = dir;
				left = esq;
			}
		}

		public class ArvoreBusca {

			sycronized void insert(int val){
				
			}

		}	