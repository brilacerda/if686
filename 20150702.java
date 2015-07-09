//Resolução da prova 2014.2

import java.util.concurrent.locks.*;

public class SyncChan {
	static Boolean empty = false;	
	static Lock locker = new ReentrantLock();
	static Condition cond = locker.newCondition();

	public void push(){
		locker.lock();
		try{
			while(empty == false){
				try{
					cond.await();
				} catch(Exception e){}
			}
			empty = false;
			cond.signalAll();
		} finally{
			locker.unlock();
		}

	}

	
	public void pop(){
		locker.lock();
		try{
			while(empty == true){
				try{
					cond.await();
				} catch(Exception e){}
			}
			empty = true;
			cond.signalAll();
		} finally{
			locker.unlock();
		}
	}

	public Boolean peek(){
		return empty;
	}

	public static void main(String[] args) {
		SyncChan sc = new SyncChan();
		Thread pr = new Produtor(sc);
		Thread con = new Consumidor(sc);

		
		con.start();
		pr.start();
	}

}

class Produtor extends Thread{
	SyncChan sc;
	Boolean val;

	public Produtor(SyncChan c){
		sc = c;
	}

	public void run(){
		for (int i = 0; i< 10; i++) {
			sc.push();
			System.out.println("(Prod) Na iteracao "+ i + " esta vazio eh " +sc.peek());
		}
			try{
				sleep((int) Math.random()*100);
			} catch(Exception e){}
	}
}

class Consumidor extends Thread{
	SyncChan sc;

	public Consumidor(SyncChan c){
		sc = c;
	}	

	public void run(){
		for (int i = 0; i < 10; i++) {
			sc.pop();
			System.out.println("(Cons) Na iteracao "+ i + " esta vazio eh " +sc.peek());
		}
	}
}


/*
(Prod) Na iteracao 0 esta vazio eh false
(Cons) Na iteracao 0 esta vazio eh false
(Cons) Na iteracao 1 esta vazio eh true
(Prod) Na iteracao 1 esta vazio eh false
(Prod) Na iteracao 2 esta vazio eh false
(Cons) Na iteracao 2 esta vazio eh true
(Cons) Na iteracao 3 esta vazio eh true
(Cons) Na iteracao 4 esta vazio eh true
(Prod) Na iteracao 3 esta vazio eh false
(Prod) Na iteracao 4 esta vazio eh false
(Prod) Na iteracao 5 esta vazio eh false
(Cons) Na iteracao 5 esta vazio eh true
(Cons) Na iteracao 6 esta vazio eh true
(Cons) Na iteracao 7 esta vazio eh true
(Prod) Na iteracao 6 esta vazio eh false
(Prod) Na iteracao 7 esta vazio eh false
(Prod) Na iteracao 8 esta vazio eh false
(Cons) Na iteracao 8 esta vazio eh true
(Cons) Na iteracao 9 esta vazio eh true
(Prod) Na iteracao 9 esta vazio eh false*/

/*
*	A propriedade Liveness diz que em algum momento a execução do programa vai chegar em um estado desejável
*	Ou seja, algo de bom acontecerá: Um processo que pode executar, será executador e/ou
*	Uma mensagem enviada de um processo a outro será recebida
*	Cuidados com falhas que podem ocorrer em liveness: Deadlock, Starvation & Livelock
*
*	Safety é a garantia de obter os valores corretos em condição de corrida.
*	Duas threads nunca obtém acesso a uma variável compartilhada ao mesmo tempo
*	As operações devem ser atômicas
*
* 	Para garantir safety & liveness foram utilizadas travas explícitas e Conditions para garantir a integridade 
*	dos dados quando em condição de corrida, e await & signalAll para comunicação entre os processos.
*/
