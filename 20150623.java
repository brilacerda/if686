/*
	Problemas que podem ocorrrer em programação concorrente:
		- Condição de Corrida
		- Erros de Consistência de memória
		- Starvation
		- Deadlocks
		- LiveLock
		- Fairness

	Se em uma divisão de trabalho entre threads existe o compartilhamento de variável, ou seja, as threads tem acesso a uma mesma posição de memória pode
	ocorrer a *Condição de corrida* que é uma situação a qual duas threads alteram a mesma posição de memória. (Interferência de threads)

	Todo object é um monitor, logo todo objeto possui um monitor.

	Região crítica é o local de compartilhamento de variável. 

	Custos de sincronização: 
		1- Overhead: custo de tornar o método sycronized, pois as operações de load and store passam a ser mais lentas
		por conta de outras operações que precisam ser feitas para garantir as peculiaridades de ser sincronized
		2- Transformar um método em sincronized faz com que as threads a implementem de forma sequencial (FIFO) 
		as threads ponham essa execução em uma fila, logo a execução torna-se parcialmente sequencial

	30.06.2015

	Errros de Incosistência de memória:
		Toda leitura de variáveis voláteis é feita pela memória.

	Starvation - Ocorre normalmente por decisões injustas do escalonador. Um processo com baixa prioridade nunca 
			    pega o recurso que necessita.
	
	Deadlock - Duas ou mais threads esperam uma pela outra pra liberar um ou mais recurso que a outra precisa e 
				ninguém consegue continuar a execução pela necessidade de obter acesso exclusivo a dados recursos.
	
		Condições necessárias para ocorrer o deadlock:

			1. Exclusão mútua
			2. Segura e tenta adquirir outro recurso
			3. Não-preempção (Não tem como forçar a saída de um recurso de um lock. ||
							  Não tem como arrancar o recurso de uma thread que já o adquiriu.)
			4. Espera circular
	
		Maneira de evitar o deadlock: 

			Impedir que uma das condições necessárias seja satisfeita.
				Normalmente a não preempção e a espera circular.
		
		* Maneira de atacar o problema de exclusão mútua:
			Memória transacional é um mecanismo para controle de concorrência
		
			Uso de atomic: Garante que a execução do bloco é atômico. Várias threads podem entrar no bloco, mas caso 
			uma variável global seja acessada, se é garantido que apenas uma thread chega no final do bloco, e as outras 
			voltam pro início do atomic e tentam chegar no fim novamente.
				Ex.: Uma cópia dessa variável global é feita para cada uma ds threads, porém a primeira que escrever nessa
				cópia invalida a cópia das outras e essas voltam pro início do atomic.

		* Evitar a memória circular: Cria uma ordenação de prioridade de aquisição dos recursos. 1 < 2 < 3

		* Evitar 'segura e tenta adquirir outro recurso": 
			Usa o tryLock() pra evitar o travamento de um dos recursos, só trava se o tryLock() der True para todos os 
			recursos, caso contrário, libera o recurso que se tentou travar e conseguiu e tenta tryLock() em todos novamente.
			
			política de backoff: A thread tentou mas não conseguiu adquirir todos os recursos, libera e espera um tempo antes
								 de retentar. threads.sleep() por exemplo.

				thread.yield() = a thread pode liberar a CPU e parar por tempo indeterminado.
				^ verificar se o gargalo de desempenho de um programa é por essa causa.

	Livelock -  Quando um dos recurso está ocupado os outros são facilmente liberados evitando deadlock, porém
				se essa situação se prolongar por muito tempo nada realmente é concluído.
		* No monitor do S.O. o processo tem atividade, diferentemente do deadlock o qual não mostra atividade.
		
*	A propriedade Liveness diz que em algum momento a execução do programa vai chegar em um estado desejável
*	Ou seja, algo de bom acontecerá: Um processo que pode executar, será executador e/ou
*	Uma mensagem enviada de um processo a outro será recebida
*	Cuidados com falhas que podem ocorrer em liveness: Deadlock, Starvation & Livelock
*
*	Safety é a garantia de obter os valores corretos em condição de corrida.
*	Duas threads nunca obtém acesso a uma variável compartilhada ao mesmo tempo
*	As operações devem ser atômicas


*/

//package aula13;

public class ArvoreBusca{
	double value;
	ArvoreBusca left;
	ArvoreBusca right;
	static ArvoreBusca arv = new ArvoreBusca(Math.random()*10000);


	public ArvoreBusca(double val){
		value = val;
		left =  null;
		right = null;
	}

	public ArvoreBusca(double val, ArvoreBusca esq, ArvoreBusca dir){
		value = val;
		left =  esq;
		right = dir;
	}

	public static ArvoreBusca inserir(ArvoreBusca arv, double val){
		if(arv.left == null && (val <= arv.value)){
			arv.left = new ArvoreBusca(val, null, null);
		} else if(arv.right == null && (val > arv.value)){
			arv.right = new ArvoreBusca(val, null, null);				
		} else {
			if(val > arv.value){
				inserir(arv.right, val);
			} else {
				inserir(arv.left, val);
			}
		}
		return arv;
	}

	public static void inorder(ArvoreBusca arv){

		if(arv.left != null){
			inorder(arv.left);
		} else {
			//se for null não faz nada
		}

		if(arv.right != null){
			System.out.print(" -> " + arv.value);
			inorder(arv.right);
		} else {
			System.out.print(" -> " + arv.value);
		}

	}

	public synchronized static void addElement(ArvoreBusca arv) {
		arv = inserir(arv, (Math.random()*10000));
	}

	public static void main(String[] args) {
		long ini =  System.currentTimeMillis();
		Thread[] t = new InserirElementoComThread[50];

		for (int i = 0; i < 50; i++) {
			t[i] = new InserirElementoComThread();
			t[i].start();
		}

		for (int i = 0; i < 50; i++) {
			try {
				t[i].join();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		long fim = System.currentTimeMillis();
		double d = (fim-ini);
		System.out.println();
		System.out.println("Tempo de execução com 50 threads: " + d +" ms\n");
		inorder(arv);
	}

	//main para uma thread apenas

	//	public static void main(String[] args) {
	//		long ini =  System.currentTimeMillis();
	//		ArvoreBusca arv = new ArvoreBusca(13);
	//		for (int i = 0; i < 1000000; i++) {
	//			arv = inserir(arv, (int)(Math.random()*10000));
	//		}
	//		//inorder(arv);
	//		long fim = System.currentTimeMillis();
	//		double d = (fim-ini);
	//		System.out.println();
	//		System.out.println("Tempo de execução com 1 thread: " + d +" ms\n");
	//		
	////		Tempo de execução com 1 thread: 4220.0 ms   //4,22s
	////		Tempo de execução com 1 thread: 4339.0 ms   //4,33s
	////		Tempo de execução com 1 thread: 4284.0 ms   //4.28s
	//	}



	static class InserirElementoComThread extends Thread{

		public void run(){
			int i = 0;
			while(i < 2000)	{
				addElement(arv);
				System.out.println(i);
				i++;
			}
		}
	}

	//	Tempo de execução com 50 threads: 4462.0 ms   //3,46s
	//	Tempo de execução com 50 threads: 4301.0 ms   //4,30s
	//	Tempo de execução com 50 threads: 4609.0 ms   //4,60s

}